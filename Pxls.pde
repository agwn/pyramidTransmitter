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

class Pxls extends Routine {
  ArrayList pxls;
  int nPxls = 20;

  Pxls() {
    generatePxls();
  }

  Pxls(int nPxls_) {
    nPxls = nPxls_;
    generatePxls();
  }

  void generatePxls() {
    pxls = new ArrayList();
    for (int i = 0; i < nPxls; i++) {
      Pxl b = new Pxl();
      pxls.add(b);
    }
  }

  void draw() {
    fill(0);
    rect(0, 0, width, height);

    for (int i = 0; i < nPxls; i++) {
      Pxl b = (Pxl) pxls.get(i);
      b.update();
    }
  }
}

class Pxl {
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

  Pxl() {
    init();
  }

  void init() {
    s = random(minSize, maxSize);
    posY = height + s;
    posX = random(-s, width + s);
    thisColor = lerpColor(pornj, orange, random(1.0));
  }

  void update() {
    pushStyle();
    noStroke();

    if (random(1.0) >= flashTriggerOdds) {
      flash = 1.0;
    }
    color tempColor = lerpColor(thisColor, white, flash);

    // Flash animations start at full opacity & brightness
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
