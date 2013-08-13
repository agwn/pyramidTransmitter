class Mirror extends CanvasRoutine {
  private int w;
  private int h;
  private int halfWidth;
  private int wMinus1;

  Mirror() {
    setPaintMode(DIRECT);
  }

  void reinit() {
    w = pg.width;
    h = pg.height;
    halfWidth = w / 2;
    wMinus1 = w - 1;
  }

  void draw() {
    pg.beginDraw();
    pg.loadPixels();

    for (int i = 0; i < halfWidth; i++) {
      for (int j = 0; j < h; j++) {
        int offset = j * w;
        pg.pixels[wMinus1 - i + offset] = pg.pixels[i + offset];
      }
    }

    pg.updatePixels();
    pg.endDraw();
  }
}
