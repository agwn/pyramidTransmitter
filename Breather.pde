class Breather extends CanvasRoutine {
  color c0 = color(255);
  color c1 = color(0);
  float phase = 0.0;
  float freq = 1.0;
  int x = 0;
  int y = 0;
  int theWidth = width;
  int theHeight = height;
  WaveTable waveTable;
  private int w;
  private int h;

  public Breather() {
    waveTable = gSineTable;
  }

  void reinit() {
    w = pg.width;
    h = pg.height;
  }

  void draw() {
    float[] table = waveTable.getData();
    int size = waveTable.getSize();
    float v = (table[(int) (phase * size)] + 1.0) * 0.5;
    pg.beginDraw();


    color theColor = lerpColor(c0, c1, v);
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
