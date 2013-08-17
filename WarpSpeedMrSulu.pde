class WarpSpeedMrSulu extends CanvasRoutine {
  int NUM_STARS = 100;
  WarpStar[] warpstars;
  GenerateColor generateColor = new GenWarpSpeedColor();

  WarpSpeedMrSulu() {
    warpstars = new WarpStar[NUM_STARS];
  }

  WarpSpeedMrSulu(int nStars) {
    NUM_STARS = nStars;
    warpstars = new WarpStar[NUM_STARS];
  }

  void reinit() {
    for (int i = 0; i<NUM_STARS; i++) {
      warpstars[i] = new WarpStar(this);
    }
  }

  void draw() {
    pg.beginDraw();
    pg.background(0);
    pg.stroke(255);

    for (int i=0; i<NUM_STARS; i++) {
      warpstars[i].draw();
    }
    pg.endDraw();
  }
}


class WarpStar {
  float x;
  float y;
  float vx;
  float vy;
  float dx;
  float dy;
  int len;

  float r;
  float g;
  float b;
  float a;
  PGraphics pg;
  WarpSpeedMrSulu parent;
  int w;
  int h;

  GenerateColor generateColor;

  public WarpStar(WarpSpeedMrSulu parent_) {
    parent = parent_;
    generateColor = parent.generateColor;
    pg = parent.pg;
    w = pg.width;
    h = pg.height;
    this.reset();
  }

  public void reset() {
    color thisColor = generateColor.get();
    r = red(thisColor);
    g = green(thisColor);
    b = blue(thisColor);
    a = alpha(thisColor);

    y = int(random(0, h));

    if (random(0, 1) > 0.5) {
      x = int(random(0, w));
      vx = (random(0, 1)-0.55)*(2.0*(0.01*(w-x)));
      vy = 0;
      len = int((abs(vx)+2) * 20);
    }
    else {
      x = int(random(0, w));
      vx = 0;
      vy = (random(0, 1)-0.5)*1.0;
      len = int((abs(vy)+1) * 10);
    }

    dx = int(random(0*w, 4*w));
    dy = int(random(0*h, 2*h));
  }

  public void draw() {
    float _r, _g, _b, _a;
    float _x, _y;

    dx--;
    dy--;

    if ((dx > 0) || (dy > 0)) {
      x += vx;
      if (x < 0) x += w;
      if (x > w) x -= w;
      y += vy;
      if (y < 0) y += h;
      if (y > w) y -= h;

      pg.stroke(r, g, b, a);

      pg.noSmooth();
      pg.point(x, y);

      _x = int(x);
      _y = int(y);
      for (int i=1; i<len; i++) {
        float scaler = pow(0.93, i);

        _r = int(scaler*r);
        _g = int(scaler*g);
        _b = int(scaler*b);
        _a = int(scaler*a);
        pg.stroke(color(_r, _g, _b, _a));

        _x = int(x-(i*vx));
        _y = int(y-(i*vy));

        if (_x < 0) _x += w;
        if (_x > w) _x -= w;
        if (_y < 0) _y += h;
        if (_y > h) _y -= h;
        pg.point(_x, _y);
      }
    }
    else {
      this.reset();
    }
  }
}
