class Mirror extends CanvasRoutine {
  Mirror() {
    setPaintMode(DIRECT);
  }

  void draw() {
    pg.beginDraw();
    PImage halfImage = pg.get(0, 0, pg.width / 2, pg.height);

    for (int i = 0; i < pg.width >> 1; i++) {
      pg.copy(halfImage, i, 0, 1, pg.height, pg.width - i - 1, 0, 1, pg.height);
    }

    pg.endDraw();
  }
}
