class Flash extends CanvasRoutine {
  ModFloat minNextTime;
  ModFloat maxNextTime;
  float decayTime = 1.0;;
  color c = color(255);

  private int nextCounter;
  private int decayCounter = 0;
  private int w;
  private int h;

  Flash() {
    minNextTime = new ModFloat(0.0);
    maxNextTime = new ModFloat(1.0);
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
    nextCounter = (int) (random(minNextTime.get(), maxNextTime.get()) * FRAMERATE);
  }
}
