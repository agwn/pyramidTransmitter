class ColumnFlash extends CanvasRoutine {
  ModFloat nextTime;
  ModFloat decayTime;
  GenerateColor generateColor;
  ModFloat timeOffset;
  int x = 0;
  int y = 0;
  int thisWidth = 0;
  int thisHeight = 0;

  private ModColor c;
  private int nextCounter;
  private int decayCounter = 0;
  private int w;
  private int h;
  private color currentColor;

  ColumnFlash() {
    nextTime = new ModFloat(1.0);
    decayTime = new ModFloat(1.0);
    timeOffset = new ModFloat(0.0);
    generateColor = new SingleColor(color(255));
    setLocation(0, 0, 0, 0);
  }

  void setLocation(int x_, int y_, int w_, int h_) {
    x = x_;
    y = y_;
    thisWidth = w_;
    thisHeight = h_;
  }

  void reinit() {
    w = pg.width;
    h = pg.height;
    currentColor = generateColor.get();
    nextCounter = (int) (timeOffset.get() * FRAMERATE);
    
}

  void draw() {
    pg.beginDraw();
    pg.pushStyle();
    pg.background(0);
    pg.fill(lerpColor(color(currentColor, 0), currentColor, constrain((float) decayCounter / (decayTime.get() * FRAMERATE), 0.0, 1.0)));
    pg.noStroke();
    pg.rect(x, y, thisWidth, thisHeight);
    pg.popStyle();
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
    nextCounter = (int) (nextTime.get() * FRAMERATE);
  }
}
