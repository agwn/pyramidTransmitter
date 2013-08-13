class Mirror extends CanvasRoutine {
  private int w;
  private int h;

  Mirror() {
    setPaintMode(DIRECT);
  }

  void reinit() {
    w = pg.width;
    h = pg.height;
  }

  void draw() {
    pg.beginDraw();

    for (int i = 0; i < w >> 1; i++) {
      pg.copy(i, 0, 1, h, w - i - 1, 0, 1, h);
    }

    pg.endDraw();
  }
}
