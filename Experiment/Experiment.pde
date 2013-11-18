// Sand Dollar 
// j.tarbell   March, 2004
// Albuquerque, New Mexico
// complexification.net

// Processing 0085 Beta syntax update
// j.tarbell   April, 2005

// dim is the screen dimensions of rendering window
int dim = 400;
// num is the actual number of sand dollars
int num = 0;
// maxnum is the maximum number of sand dollars
int maxnum = 50;
int time;
// gtime measures rendering time in the system
int gtime;
// maxdepth keeps the tree structures reasonable
int maxdepth = 7;
// k defines number of grid spaces (n = k * k)
int k=2;
// drag is the number of segments within a full revolution
int drag = 1000;//2048;
// drawing is the state of the system.  setting to false stops all activity
boolean drawing = true;

// sandDollars is the array of sand dollar objects
SandDollar[] sandDollars;

// maxpal is the maximum number of 'good color' palette entries
int maxpal = 512;
// numpal is the actual number of 'good color' palette entries
int numpal = 0;
// goodcolor is the array of palette entries
color[] goodcolor = new color[maxpal];


// ENVIRONMENT METHODS ---------------------------

void setup() {
  // set up drawing area
  size(400,400,P3D);
  println("one");
  takecolor("sw.jpg");
  background(0);
  
  // create sand dollars
  sandDollars = new SandDollar[maxnum];
  
  // generate sand dollars
  genAllsandDollars();
  frameRate(100);
}

void draw() {
  if (drawing) {
    for (int n=0;n<num;n++) 
    {
       sandDollars[n].swim();
    }
    
    if (gtime++ > (drag*1.1)) {
      // stop drawing
      drawing = false;
      gtime=0;
 
    }
   }
}

void mousePressed() 
{ 
  if(!drawing) {
      // make new instances
    background(255);
    genAllsandDollars();
    drawing = true;
  }
} 


// METHODS ---------------------------

void genAllsandDollars() {
  // n tracks totally number of instances
  int n=0;
  // g is calculation of grid spacing
  int g=int(dim/k);
  for (int y=0;y<k;y++) {
    for (int x=0;x<k;x++) {
      // bp is number of petals
      int bp = int(random(13)+3);
      sandDollars[n] = new SandDollar(x*g+g/2,y*g+3*g/6,0,-HALF_PI,5.22,bp);
      sandDollars[n].render();
      n++;
    }
  }
  // set number of sandDollars
  num=n;
  // set rendering clock
  gtime=0;
}



// COLOR METHODS -----------------------------------------------

color somecolor() {
  // pick some random good color
  return goodcolor[int(random(numpal))];
}

void takecolor(String fn) {
  PImage b;
  b = loadImage(fn);
  image(b,0,0);
  println("height:" + b.height + " width: " + b.width);
  for (int x=0;x<b.width;x++){
    for (int y=0;y<b.height;y++) {
      color c = get(x,y);
      boolean exists = false;
      for (int n=0;n<numpal;n++) {
        if (c==goodcolor[n]) {
          exists = true;
          break;
        }
      }
      if (!exists) {
        // add color to pal
        if (numpal<maxpal) {
          goodcolor[numpal] = c;
          numpal++;
        } else {
          break;
        }
      }
    }
  }
 /*
  // pad with whites
  for (int n=0;n<64;n++) {
    goodcolor[numpal] = #FFFFFF;
    numpal++;
  }
   

  // pad with blacks
  for (int n=0;n<100;n++) {
    goodcolor[numpal] = #000000;
    numpal++;
  }
 */  
}

// j.tarbell   March, 2004
// Albuquerque, New Mexico
// complexification.net

