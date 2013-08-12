class Flash extends CanvasRoutine {
  color c = color(255);
  float decayTime = 1.0;;
  float minNextTime = 0;
  float maxNextTime = 60.0;

  private int nextCounter;
  private int decayCounter = 0;
  private int w;
  private int h;

  public Flash() {
    //setPaintMode(DIRECT);
    //setBlendMode(SCREEN);
  }

  void reinit() {
    w = pg.width;
    h = pg.height;

  }

  void draw() {
    pg.beginDraw();

    pg.background(lerpColor(color(c, 0), c, constrain((float) decayCounter / (decayTime * FRAMERATE), 0.0, 1.0)));

    nextCounter--;
    decayCounter--;

    if (nextCounter <= 0) {
      setNextTime();
      decayCounter = (int) (decayTime * FRAMERATE);
    }

    pg.endDraw();
  }

  private void setNextTime() {
    nextCounter = (int) (random(minNextTime, maxNextTime) * FRAMERATE);
  }
}
