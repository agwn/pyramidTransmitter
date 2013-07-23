/*

  ~~~~~~~~~  ~~  ~~~~~~~~~  ~~~~~~~~  ~~~~~~~~~  ~~  ~~~~~~~~  ~~~~~~~~~  ~~~~~~~~~~
  ~~~~~~~~~~ ~~ ~~~~~~~~~~ ~~~~~~~~~~ ~~~~~~~~~~ ~~ ~~~~~~~~~~ ~~~~~~~~~~ ~~~~~~~~~~
  ~~      ~~    ~~         ~~      ~~ ~~      ~~    ~~      ~~ ~~      ~~     ~~
  ~~      ~~ ~~ ~~~~~~~~~  ~~      ~~ ~~      ~~ ~~ ~~~~~~~~~~ ~~      ~~     ~~
  ~~      ~~ ~~  ~~~~~~~~~ ~~      ~~ ~~~~~~~~~  ~~ ~~~~~~~~~~ ~~      ~~     ~~
  ~~      ~~ ~~         ~~ ~~      ~~ ~~~~~~~~~  ~~ ~~         ~~      ~~     ~~
  ~~~~~~~~~~ ~~ ~~~~~~~~~~ ~~~~~~~~~~ ~~     ~~~ ~~ ~~~~~~~~~  ~~      ~~     ~~
  ~~~~~~~~~  ~~ ~~~~~~~~~   ~~~~~~~~  ~~      ~~ ~~  ~~~~~~~~  ~~      ~~     ~~

  ~~~~~~~~~  ~~  ~~~~~~~~~
  ~~~~~~~~~~ ~~~ ~~~~~~~~~~         |  |
  ~~      ~~  ~~         ~~         |  |
  ~~      ~~  ~~   ~~~~~~~~       | |  | |
  ~~      ~~  ~~   ~~~~~~~~       | |  | |
  ~~      ~~  ~~         ~~     | | |  | | |
  ~~~~~~~~~~  ~~ ~~~~~~~~~~     | | |  | | | 
  ~~~~~~~~~   ~~ ~~~~~~~~~    | | | |  | | | |

*/

class Pxxxls extends CanvasRoutine {
  ArrayList pxxxls;
  int nPxxxls = 20;

  Pxxxls(Canvas canvas_) {
    canvas = canvas_;
    generatePxxxls();
  }

  Pxxxls(Canvas canvas_, int nPxxxls_) {
    canvas = canvas_;
    nPxxxls = nPxxxls_;
    generatePxxxls();
  }

  void generatePxxxls() {
    pxxxls = new ArrayList();
    for (int i = 0; i < nPxxxls; i++) {
      Pxxxl b = new Pxxxl(canvas);
      pxxxls.add(b);
    }
  }

  void draw() {
    fill(0);
    rect(0, 0, canvas.w, canvas.h);

    for (int i = 0; i < nPxxxls; i++) {
      Pxxxl b = (Pxxxl) pxxxls.get(i);
      b.update();
    }
  }
}

class Pxxxl {
  float posX;
  float posY;
  float s;
  int minSize = 9;
  int maxSize = 24;
  color pornj = color(252, 23, 218);
  color orange = color(255, 128, 0);
  color white = color(255);
  color thisColor;
  float flash = 0.0;
  float flashTriggerOdds = 0.98;
  float flashDecay = 0.06125;
  float speed = 1.0 / 8.0;
  Canvas canvas;

  Pxxxl(Canvas canvas_) {
    canvas = canvas_;
    init();
  }

  void init() {
    s = random(minSize, maxSize);
    posY = canvas.h + s;
    posX = random(-s, canvas.w + s);
    thisColor = lerpColor(pornj, orange, random(1.0));
  }

  void update() {
    pushStyle();
    noStroke();

    if (random(1.0) >= flashTriggerOdds) {
      flash = 1.0;
    }

    // Flash animations start at full opacity & brightness
    color tempColor = lerpColor(thisColor, white, flash);
    float tempAlpha = (s - minSize) / maxSize * 239 + 16;
    float flashAlpha = (255.0 - tempAlpha) * flash + tempAlpha;
    fill(tempColor, flashAlpha);
    flash -= flashDecay;
    flash = flash < 0.0 ? 0.0 : flash;

    rect(posX, posY, s, s);
    float angle = PI;
    posX += sin(angle) * s * speed;
    posY += cos(angle) * s * speed;

    if (posY <= -s) {
      init();
    }

    popStyle();
  }
}
