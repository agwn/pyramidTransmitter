class Bursts extends CanvasRoutine {
  int NUMBER_OF_BURSTS = 8;
  Burst[] bursts;

  void reinit() {
    bursts = new Burst[NUMBER_OF_BURSTS];
    for (int i = 0; i<NUMBER_OF_BURSTS; i++) {
      bursts[i] = new Burst(pg);
    }
  }

  void reset() {
  }

  void draw()
  {
    pg.background(0);

    for (int i=0; i<NUMBER_OF_BURSTS; i++) {
      bursts[i].draw();
    }
  }
}


class Burst {
  float x;
  float y;
  float xv;
  float yv;
  float d;
  float maxd;
  float speed;
  int intensity;
  int[] varMin = { 64, 64, 64 };
  int[] varMax = { 128, 128, 128 };

  float r;
  float g;
  float b;
  int w;
  int h;
  PGraphics pg;

  public Burst(PGraphics pg_)
  {
    init();
    pg = pg_; 
    w = pg.width;
    h = pg.height;
  }

  public void reset()
  {
    //r = random(255-32)+32;
    //g = random(255-32)+32;
    //b = random(255-32)+32;
    r = random(varMin[0], varMax[0]);
    g = random(varMin[1], varMax[1]);
    b = random(varMin[2], varMax[2]);

    x = random(w);
    y = random(h);

    float max_speed = .15;
    xv = random(max_speed) - max_speed/2.0;
    yv = (32/60.0)*(random(max_speed) - max_speed/2.0);

    maxd = random(20);
    speed = random(1)/10 + 0.1;
    d = 0;
    intensity = int(random(max(max(varMin[0],varMin[1]),varMin[2])));
  }

  public void init()
  {
    reset();
  }

  public void draw_ellipse(float x, float y, float widt, float heigh, color c) {
    while (widt > 1 && heigh > 1) {
      float target_brightness = random(.97, 1.03);
      c = color(red(c)*target_brightness, green(c)*target_brightness, blue(c)*target_brightness);
      pg.fill(c);
      pg.stroke(c);
      pg.ellipse(x, y, widt, heigh);
      widt -= 1;
      heigh -= 1;
    }
  }

  public void draw()
  {
    // Draw multiple elipses, to handle wrapping in the y direction.
    draw_ellipse(x, y, d*(.5-.3*y/h), d*2, color(r, g, b));
    draw_ellipse(x-w, y, d*(.5-.3*y/h), d*0.75, color(r, g, b));
    draw_ellipse(x+w, y, d*(.5-.3*y/h), d*0.75, color(r, g, b));

    d+= speed;

    if (d > maxd) {
      d -= speed/3;

      // day
      //r -= 2;
      //g -= 2;
      //b -= 2;
      //intensity -= 15;
      //night
      //r -= 1;
      //g -= 1;
      //b -= 1;
      intensity -= 4;
    }

    // add speed, try to scale slower at the bottom...
    x +=xv*(h - y/3)/h;
    y +=yv*(h - y/3)/h;

    if ((intensity <= 0) || (false)) {
      reset();
    }

  }
}

