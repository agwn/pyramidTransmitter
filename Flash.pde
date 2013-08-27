class Flash extends CanvasRoutine {
  ModFloat minNextTime;
  ModFloat maxNextTime;
  ModFloat decayTime;
  GenerateColor generateColor;

  private ModColor c;
  private int nextCounter;
  private int decayCounter = 0;
  private int w;
  private int h;
  private color currentColor;

  Flash() {
    minNextTime = new ModFloat(0.0);
    maxNextTime = new ModFloat(1.0);
    decayTime = new ModFloat(1.0);
    generateColor = new SingleColor(color(255));
  }

  void reinit() {
    w = pg.width;
    h = pg.height;
    currentColor = generateColor.get();
}

  void draw() {
    pg.beginDraw();
    pg.background(lerpColor(color(currentColor, 0), currentColor, constrain((float) decayCounter / (decayTime.get() * FRAMERATE), 0.0, 1.0)));

    nextCounter--;
    decayCounter--;
    decayCounter = max(decayCounter, 0);

    if (nextCounter <= 0) {
      setNextTime();
      decayCounter = (int) (decayTime.get() * FRAMERATE);
      currentColor = generateColor.get();
    }

    pg.endDraw();
  }

  private void setNextTime() {
    nextCounter = (int) (random(minNextTime.get(), maxNextTime.get()) * FRAMERATE);
  }
}
