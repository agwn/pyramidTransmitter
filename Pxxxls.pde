/*

  ~~~~~~~~~  ~~  ~~~~~~~~~  ~~~~~~~~  ~~~~~~~~~  ~~  ~~~~~~~~  ~~~~~~~~~  ~~~~~~~~~~
  ~~~~~~~~~~ ~~ ~~~~~~~~~~ ~~~~~~~~~~ ~~~~~~~~~~ ~~ ~~~~~~~~~~ ~~~~~~~~~~ ~~~~~~~~~~
  ~~      ~~    ~~         ~~      ~~ ~~      ~~    ~~      ~~ ~~      ~~     ~~
  ~~      ~~ ~~ ~~~~~~~~~  ~~      ~~ ~~      ~~ ~~ ~~~~~~~~~~ ~~      ~~     ~~
  ~~      ~~ ~~  ~~~~~~~~~ ~~      ~~ ~~~~~~~~~  ~~ ~~~~~~~~~~ ~~      ~~     ~~
  ~~      ~~ ~~         ~~ ~~      ~~ ~~~~~~~~~  ~~ ~~         ~~      ~~     ~~
  ~~~~~~~~~~ ~~ ~~~~~~~~~~ ~~~~~~~~~~ ~~     ~~~ ~~ ~~~~~~~~~  ~~      ~~     ~~
  ~~~~~~~~~  ~~ ~~~~~~~~~   ~~~~~~~~  ~~      ~~ ~~  ~~~~~~~~  ~~      ~~     ~~
*/

class Pxxxls extends CanvasRoutine {
  GenerateColor generateColor;
  private ArrayList pxxxls;
  private int nPxxxls;

  Pxxxls(int nPxxxls_) {
    generateColor = new GenCampColor();
    nPxxxls = nPxxxls_;
  }

  void reinit() {
    breedPixxls();
  }

  void breedPixxls() {
    pxxxls = new ArrayList();
    for (int i = 0; i < nPxxxls; i++) {
      Pxxxl pxxxl = new Pxxxl(this);
      pxxxls.add(pxxxl);
    }
  }

  void draw() {
    pg.beginDraw();
    pg.background(0);

    for (int i = 0; i < nPxxxls; i++) {
      Pxxxl pxxxl = (Pxxxl) pxxxls.get(i);
      pxxxl.update();
    }

    pg.endDraw();
  }
}

class Pxxxl {
  float posX;
  float posY;
  float s;
  int minSize = 9;
  int maxSize = 24;
  color thisColor;
  float flash = 0.0;
  float flashTriggerOdds = 0.98;
  float flashDecay = 0.06125;
  float speed = 1.0 / 8.0;
  Pxxxls parent;
  PGraphics pg;

  Pxxxl(Pxxxls parent_) {
    parent = parent_;
    pg = parent.pg;
    init();
  }

  void init() {
    s = random(minSize, maxSize);
    posY = pg.height + s;
    posX = random(-s, pg.width + s);
    thisColor = parent.generateColor.get();
    //thisColor = lerpColor(pornj, disorientOrange, random(1.0));
  }

  void update() {
    pg.pushStyle();
    pg.noStroke();

    if (random(1.0) >= flashTriggerOdds) {
      flash = 1.0;
    }

    // Flash animations start at full opacity & brightness
    color tempColor = lerpColor(thisColor, color(255), flash);
    float tempAlpha = (s - minSize) / maxSize * 239 + 16;
    float flashAlpha = (255.0 - tempAlpha) * flash + tempAlpha;
    pg.fill(tempColor, flashAlpha);
    flash -= flashDecay;
    flash = flash < 0.0 ? 0.0 : flash;

    pg.rect(posX, posY, s, s);
    float angle = PI;
    posX += sin(angle) * s * speed;
    posY += cos(angle) * s * speed;

    if (posY <= -s) {
      init();
    }

    pg.popStyle();
  }
}
