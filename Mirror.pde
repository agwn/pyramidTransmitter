class Mirror extends CanvasRoutine {
  Mirror() {
    setPaintMode(DIRECT);
  }

  void draw() {
    pg.beginDraw();
    PImage halfImage = pg.get(0, 0, pg.width / 2, pg.height);
    pg.pushMatrix();
    pg.scale(-1.0, 1.0);
    pg.image(halfImage, -halfImage.width, 0);
    pg.popMatrix();
    pg.copy(halfImage, 0, 0, pg.width / 2, pg.height, pg.width / 2, 0, pg.width / 2, pg.height);
    pg.endDraw();
  }
}
