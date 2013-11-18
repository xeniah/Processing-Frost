class SandPainter {

  float p;
  color c;
  float g;

  SandPainter() {

    p = random(1.0);
    c = somecolor();
    g = random(0.01,0.1);
  }

  void render(float x, float y, float ox, float oy) {
    // draw painting sweeps
    stroke(red(c),green(c),blue(c),22);
    point(ox+(x-ox)*sin(p),oy+(y-oy)*sin(p));

    g+=random(-0.050,0.050);
    float maxg = 0.22;
    if (g<-maxg) g=-maxg;
    if (g>maxg) g=maxg;

    int grains = 6;
    float w = g/(grains*1.0);
    for (int i=0;i<grains+1;i++) {
      float a = 0.1-i/((grains+1)*10);
      stroke(red(c),green(c),blue(c),256*a);
      point(ox+(x-ox)*sin(p + sin(i*w)),oy+(y-oy)*sin(p + sin(i*w)));
      point(ox+(x-ox)*sin(p - sin(i*w)),oy+(y-oy)*sin(p - sin(i*w)));
    }
  }
}

