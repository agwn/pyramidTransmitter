class Breather extends CanvasRoutine {
  color c0 = color(255);
  color c1 = color(0);
  float phase = 0.0;
  float freq = 1.0;
  int x = 0;
  int y = 0;
  int theWidth = width;
  int theHeight = height;
  private int w;
  private int h;

  public Breather() { }

  void reinit() {
    w = pg.width;
    h = pg.height;
  }

  void draw() {
    pg.beginDraw();

    float v = (sineTable[(int) (phase * sineTableSize)] + 1.0) * 0.5;
    color theColor = lerpColor(c0, c1, v);
    //pg.background(theColor);
    pg.pushStyle();
    pg.noStroke();
    pg.fill(theColor);
    pg.rect(x, y, theWidth, theHeight);
    pg.popStyle();

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
