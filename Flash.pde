class Flash extends CanvasRoutine {
  ModFloat minNextTime;
  ModFloat maxNextTime;
  ModFloat decayTime;
  ModColor c;

  private int nextCounter;
  private int decayCounter = 0;
  private int w;
  private int h;

  Flash() {
    minNextTime = new ModFloat(0.0);
    maxNextTime = new ModFloat(1.0);
    decayTime = new ModFloat(1.0);
    c = new ModColor(color(255));
  }

  void reinit() {
    w = pg.width;
    h = pg.height;
}

  void draw() {
    pg.beginDraw();

    color thisColor = c.get();

    pg.background(lerpColor(color(thisColor, 0), thisColor, constrain((float) decayCounter / (decayTime.get() * FRAMERATE), 0.0, 1.0)));

    nextCounter--;
    decayCounter--;

    if (nextCounter <= 0) {
      setNextTime();
      decayCounter = (int) (decayTime.get() * FRAMERATE);
    }

    pg.endDraw();
  }

  private void setNextTime() {
    nextCounter = (int) (random(minNextTime.get(), maxNextTime.get()) * FRAMERATE);
  }
}
