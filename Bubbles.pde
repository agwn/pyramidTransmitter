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

class Bubble {
  float posX;
  float posY;
  float s;
  int minSize = 9;
  int maxSize = 24;
  color pornjPink = color(252, 23, 218);
  color orange = color(255, 128, 0);
  color white = color(255);
  color thisColor;
  float flash = 0.0;
  float flashTriggerOdds = 0.98;
  float flashDecay = 0.06125;
  float speed = 1.0 / 8.0;

  Bubble() {
    init();
  }

  void init() {
    s = random(minSize, maxSize);
    posY = height + s;
    posX = random(-s, width + s);
    thisColor = lerpColor(pornjPink, orange, random(1.0));
  }

  void update() {
    pushStyle();
    noStroke();

    if (random(1.0) >= flashTriggerOdds) {
      flash = 1.0;
    }
    color tempColor = lerpColor(thisColor, white, flash);

    // Flash animations start at full opacity/brightness
    float tempAlpha = (s - minSize) / maxSize * 239 + 16;
    float flashAlpha = (255.0 - tempAlpha) * flash + tempAlpha;
    fill(tempColor, flashAlpha);
    flash -= flashDecay;
    flash = flash < 0.0 ? 0.0 : flash;

    rect(posX, posY, s, s);

    // Too jittery?
//    float angle = PI + random(-QUARTER_PI, QUARTER_PI);

    float angle = PI;
    posX += sin(angle) * s * speed;
    posY += cos(angle) * s * speed;

    if (posY <= -s) {
      init();
    }

    popStyle();
  }
}

class Bubbles extends Routine {
  ArrayList bubbles;
  int nBubbles = 20;
  float QUARTER_PI = PI * 0.125;

  Bubbles() {
    generateBubbles();
  }

  Bubbles(int nBubbles_) {
    nBubbles = nBubbles_;
    generateBubbles();
  }

  void generateBubbles() {
    bubbles = new ArrayList();
    for (int i = 0; i < nBubbles; i++) {
      Bubble d = new Bubble();
      bubbles.add(d);
    }
  }

  void draw() {
    fill(0);
    rect(0, 0, width, height);

    for (int i = 0; i < nBubbles; i++) {
      Bubble d = (Bubble) bubbles.get(i);
      d.update();
    }
  }
}

