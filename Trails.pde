class Trails extends CanvasRoutine {
  int w;
  int h;
  PGraphics pgLast;
  int fade = 0;

  public Trails() {
    setPaintMode(DIRECT);
  }

  void reinit() {
    w = pg.width;
    h = pg.height;
    pgLast = createGraphics(w, h, P2D);
    pgLast.background(0);
    pgLast.noStroke();
  }

  void draw() {
    pg.beginDraw();
    pgLast.beginDraw();
    pg.blend(pgLast.get(), 0, 0, w, h, 0, 0, w, h, SCREEN);
    pgLast.copy(pg.get(), 0, 0, w, h, 0, 0, w, h);
    pgLast.fill(0, fade);
    pgLast.rect(0, 0, w, h);
    pgLast.endDraw();
    pg.endDraw();
  }
}

