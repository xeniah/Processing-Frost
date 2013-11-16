/* @pjs preload="lena.png"; */
PImage img;
MPoint fromPoint;
MPoint toPoint;
ArrayList points;

float angle = 2;
float distance = 1;
float chance;
float intensity;
int pointsCount;
int maxPoints = 200;
//int maxPoints = 800;
int fC = 0;

void setup() {
  background(0);
  randomSeed(0);
  img = loadImage("lena.png");
  img.loadPixels();
  size(640, 480);
  //println(width+"/"+img.width+" == "+height+"/"+img.height);
  points = new ArrayList();
  //points.add(new MPoint(0, 0, 0));
  
  points.add(new MPoint(30, 30, -45));
  points.add(new MPoint(width - 30, 30, 225));
  points.add(new MPoint(width - 30, height - 30, 135));
  points.add(new MPoint(30, height - 30, 45));
  
  //points.add(new MPoint(width/2, height/2, 0));
  int pointsCount = 4;
  frameRate(20);
  smooth();
  //strokeWeight(0.3);
  strokeWeight(1);
}


void draw() {


  fC++;
  if (fC > 5){
    fC = 0;
    stroke(0);
    fill(0,0,0,1);
    rect(0,0,width,height);
  }
  
    

  //for every point in ArrayList
  for (int i=0; i<points.size(); i++){
    fromPoint = (MPoint)points.get(i);
    toPoint = nextPoint(fromPoint, pointsCount);
    
    //stroke(random(10, 255));
    //stroke(255);
    
    
    points.set(i, toPoint);
    
    intensity = getPixelValue(toPoint);
    stroke(255, 255, 255);
  
  
  
    if (intensity > 50){
      //line(fromPoint.x, fromPoint.y, toPoint.x, toPoint.y);
      point(toPoint.x, toPoint.y);
      line(toPoint.x, toPoint.y, int(random(toPoint.x-1, toPoint.x+14 )), int(random(toPoint.y-1, toPoint.y+15 )));
    }
    
    
    /*
    if (intensity > 50 && intensity < 60){
      line(fromPoint.x, fromPoint.y, toPoint.x, toPoint.y);
    }
    */
    
    
    
    if (intensity > 100 && pointsCount < maxPoints && random(0,10) < 1){
      toPoint.angle = toPoint.angle + 45;
      points.add(toPoint);
      pointsCount++;
      setPixelsValue(toPoint);
    }
    
    
    /*
    if (intensity > 100 && pointsCount > 5){
      points.remove(i);
      pointsCount--;
    }
    */
    
    
    
  }
  
}//end draw


MPoint nextPoint(MPoint p, int index){
  MPoint nextPoint = new MPoint(0,0,0);
  nextPoint.x = p.x;
  nextPoint.y = p.y;
  nextPoint.angle = p.angle;
  
  /*
  if (index<5){
    if (random(1, 10) <= 9){
      nextPoint.angle = p.angle + random((-1)*angle,angle);
    }
  }else{
    if (random(1, 10) <= 5){
      nextPoint.angle = p.angle + random((-1)*(angle-5),(angle-5));
    }
  }
  
  if (index<5){
    nextPoint.x = nextPoint.x + distance*2*cos(radians(nextPoint.angle));
    nextPoint.y = nextPoint.y + distance*2*sin(radians(nextPoint.angle));
  }else{
    nextPoint.x = nextPoint.x + distance*cos(radians(nextPoint.angle));
    nextPoint.y = nextPoint.y + distance*sin(radians(nextPoint.angle));
  }
  */
  

  chance = random(1,10);
  //if (chance < 5){
    nextPoint.angle = p.angle + random((-1)*10,10);
  //}
  
    
  nextPoint.x = nextPoint.x + distance*cos(radians(nextPoint.angle));
  nextPoint.y = nextPoint.y + distance*sin(radians(nextPoint.angle));
  
  if ((width - nextPoint.x) < 20 || nextPoint.x < 20 || (height - nextPoint.y) < 20 || nextPoint.y < 20){
    nextPoint.angle = p.angle + 90;
  }
  
  nextPoint.x = constrain(nextPoint.x, 0, width-1);
  nextPoint.y = constrain(nextPoint.y, 0, height-1);
  
  return nextPoint;
}


////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
//MPoint
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
class MPoint {

  float x; 
  float y;
  float angle;
  MPoint(float mx, float my, float ma) {
    x = mx;
    y = my;
    angle = ma;
  }//end MPoint
}//end class MPoint 


////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
//GET PIXEL VALUE
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
float getPixelValue(MPoint p) {
  int lx = round(p.x);
  int ly = round(p.y);
  int loc = lx + ly*img.width;
  //println(img.pixels[loc]);
  return red(img.pixels[loc]);
}

void setPixelsValue(MPoint p) {
  //image(img,0,0);
    int loc = (int)p.x + (int)p.y*img.width;
  img.pixels[loc] = color(255, 255, 255);
  img.updatePixels();
  
}


