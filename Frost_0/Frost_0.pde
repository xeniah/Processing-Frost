import java.util.Iterator;

ArrayList cells;
ArrayList newcells;
PImage img;
float food[][];
String filename = "lena.png";
//filename = "bg.png";
boolean inverted = false;
int ratio = 2;
boolean mouseClicked = false;

void setup()
{
  size(512,512);
  img = loadImage(filename);
  food = new float[width/ratio][height/ratio];
  for (int x = 0; x < width/ratio; ++x)
    for (int y = 0; y < height/ratio; ++y) {
     // food[x][y] = ((img.pixels[(x+y*512)*ratio] >> 8) & 0xFF)/255.0;
      food[x][y] = 0.34;
      if (inverted) food[x][y] = 1-food[x][y];
    }
  if (inverted) {
    background(255);
  } else {
    background(0);
  }
  cells = new ArrayList();
  newcells = new ArrayList();
  
  frameRate(20);
}

void mouseDragged()
{
    Cell c = new Cell();
    c.xpos = mouseX;
    c.ypos = mouseY;
    cells.add(c);
}

void mousePressed()
{
  mouseClicked = true;
}
void draw()
{
  if(mouseClicked)
  {
    mouseClicked = false;
    Cell c = new Cell();
    c.xpos = mouseX;
    c.ypos = mouseY;
    cells.add(c);
  }
  newcells.clear();
  loadPixels();
  Iterator<Cell> itr = cells.iterator();
  while (itr.hasNext()) {
    Cell c = itr.next();
    c.draw();
    c.update();
  }
 // updatePixels();
  cells.addAll(newcells);
}

float feed(int x, int y, float thresh) {
  float r = 0.0;
  if (x >= 0 && x < width && y >= 0 && y < height) {
    x /= ratio;
    y /= ratio;
    if (food[x][y] > thresh) {
      r = thresh;
      food[x][y] -= thresh;
    } else {
      r = food[x][y];
      food[x][y] = 0.0;
    }
  }
  return r;
}

class Cell {
  float xpos, ypos;
  float dir;
  float state;
  Cell() {
    xpos = random(width);
    ypos = random(height);
    dir = random(2*PI);
    state = 0;
  }
  Cell(Cell c) {
    xpos = c.xpos;
    ypos = c.ypos;
    dir = c.dir;
    state = c.state;
  }
  void draw() {
    if (state > 0.001 && xpos >= 0 && xpos < width && ypos >= 0 && ypos < height) {
      
      if (inverted) {
        fill(0);
       stroke(0);
      //  pixels[ int(xpos) + int(ypos) * width ] = color(0, 0, 0);
      //  pixels[ int(xpos)+int(random(-1, 1)) + int(ypos) * width ] = color(0, 0, 0);
      } else {
      // pixels[ int(xpos) + int(ypos) * width ] = color(255, 255, 255);
     //  pixels[ int(xpos)+int(random(-1, 1)) + int(ypos) * width ] = color(255, 255, 255);
       fill(255, 255, 255, 0.5);
      // stroke(255);
       stroke(255);
       
       
     }
     println("int(xpos): " + int(xpos) + " int(ypos): " + int(ypos) );
     line(int(xpos),  int(ypos),  int(xpos+random(-3, 5)) ,int(ypos+random(-1, 4)));
    }
  }
  void update()
  {
    state += feed(int(xpos),int(ypos), 0.3) - 0.295;
    xpos += cos(dir);
    ypos += sin(dir);
    dir += random(-PI/4,PI/4);
    if (state > 0.15 && cells.size() < 100) {
      divide();
    } else
    if (state < 0) {
      xpos += random(-15,+15);
      ypos += random(-15,+15);
      state = 0.001;
    }
  }
  void divide() {
      state /= 2;
      Cell c = new Cell(this);
      float dd = random(PI/4);
      dir += dd;
      c.dir -= dd;
      newcells.add(c);
  }
}
