class Grid extends CanvasRoutine {
  int xSpacing = 8;
  int ySpacing = 10;

  void draw() {
    pg.beginDraw();
    pg.stroke(255, 64);

    for (int i = 0; i < pg.height; i = i + ySpacing) {
      pg.line(0, i, pg.width, i);
    }
    
    for (int i = 0; i < pg.width; i = i + xSpacing) {
      pg.line(i, 0, i, pg.height);
    }

    pg.endDraw();
  }
}
