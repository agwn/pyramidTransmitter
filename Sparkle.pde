class Sparkle extends CanvasRoutine {
  int nDots = 1;
  int w;
  int h;
  float threshold = 1.0;
  float dotToCrossRatio = 0.9;
  PGraphics pgMaster;
  int xSize = 4;
  int ySize = 8;
  color c = color(255);

  public Sparkle() { }

  void reinit() {
    w = pg.width;
    h = pg.height;
    pgMaster = canvas.pgMaster;
  }
  void draw() {
    pg.beginDraw();
    pg.background(0);
    pg.stroke(c);

    for (int i = 0; i < nDots; i++) {
      int xPos = (int) random(w);
      int yPos = (int) random(h);
      float b = brightness(pgMaster.get(xPos, yPos));
      //println("b: " + b);

      if (b > threshold) {
        if (random(1.0) < dotToCrossRatio) {
          pg.point(xPos, yPos);
        }
        else {
          int xHalf = xSize / 2;
          int xQuarter = xSize / 2;
          int yHalf = ySize / 2;
          int yQuarter = ySize / 2;

          pg.line(xPos, yPos - yHalf, xPos, yPos + yHalf);
          pg.line(xPos - xHalf, yPos, xPos + xHalf, yPos);
          //pg.line(xPos - quarter, yPos - quarter, xPos + quarter, yPos + quarter);
          //pg.line(xPos + quarter, yPos - quarter, xPos - quarter, yPos + quarter);
        }
      } 
    }

    pg.endDraw();
  }
}
