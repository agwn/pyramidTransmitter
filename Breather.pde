class Breather extends CanvasRoutine {
  int w;
  int h;
  color c0 = color(255);
  color c1 = color(0);
  float phase = 0.0;
  float freq = 1.0;

  public Breather() { }

  void reinit() {
    w = pg.width;
    h = pg.height;
  }

  void draw() {
    pg.beginDraw();

    float v = (sineTable[(int) (phase * sineTableSize)] + 1.0) * 0.5;
    color theColor = lerpColor(c0, c1, v);
    pg.background(theColor);

    phase += freq / FRAMERATE;
    while (phase >= 1.0) {
      phase -= 1.0;
    }
    while (phase < 0.0) {
      phase += 1.0;
    }

    pg.endDraw();
  }
}
