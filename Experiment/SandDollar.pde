class SandDollar {
  // feet
  int depth;
  int limbs;
  int petals;

  float time, timev, timevv;
  float x, y;
  float ox, oy;
  float radius;
  float theta, ptheta;
  

  int numsp = 1;
  int maxsp = 13;
  SandPainter[] sp = new SandPainter[maxsp];

  SandDollar[] mysandDollars = new SandDollar[2];

  SandDollar(float X, float Y, int Depth, float Theta, float Radius, int Petals) {
    // init
    ox = x = X;
    oy = y = Y;
    ptheta = Theta;
    radius = Radius;
    depth = Depth;
    petals = Petals;

    limbs = 0;
    time = 0;
    timev = petals*TWO_PI/drag;
    if (random(100)>50) timev*=-1;

    // add sweeps
    numsp = int(2+random(depth/2.0));
    for (int n=0;n<numsp;n++) {
      sp[n] = new SandPainter();
    }
  }

  void render() {
    theta = random(-HALF_PI/3,HALF_PI/3);
    radius *= random(1.02,1.20);

    // set next radial point
    x = ox + radius*cos(theta);
    y = oy + radius*sin(theta);

    if (depth<maxdepth) {
      int lnum=1;
      if (random(100)>90-depth) lnum++;
      for (int n=0;n<lnum;n++) {
        int bp = petals * int(1+random(3));
        mysandDollars[n] = new SandDollar(x,y,depth+1,theta,radius,bp);
        mysandDollars[n].render();
        limbs++;
      }
    }
  }

  void swim() {
    // move through time
    time+=timev;

    // spin in sinusoidal waves
    if (depth==0) {
      theta += TWO_PI/drag;
    } else {
      theta += sin(time)/1640;
      if (depth%2==0) { 
        radius += sin(time)*0.22;
      } else {
        radius += cos(time)*0.22;
      }
    }

    // set next radius point
    x = ox + radius*cos(theta+ptheta);
    y = oy + radius*sin(theta+ptheta);
    
    // render sand painters
    for (int n=0;n<numsp;n++) {
      sp[n].render(x,y,ox,oy);
    }

    // draw child limbs
    for (int n=0;n<limbs;n++) {
      mysandDollars[n].setOrigin(x,y,theta+ptheta);
      mysandDollars[n].swim();
    }
  }

  void setOrigin(float X, float Y, float Theta) {
    ox = X;
    oy = Y;
    ptheta = Theta;
  }

}
