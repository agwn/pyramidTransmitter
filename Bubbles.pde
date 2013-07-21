class Bubble {
  float posX;
  float posY;
  float s;     // Size

  Bubble() {
    init();
  }

  void init() {
    s = random(4, 12);
    posY = displayHeight + s;
    posX = random(-s, displayWidth + s);
  }

  void update() {
    trueCanvas.pushStyle();
    trueCanvas.noStroke();
    trueCanvas.fill(255, (s - 2) / 6.0 * 128);  // Larger bubbles are brighter
    trueCanvas.ellipse(posX, posY, s / 2, s);

    float speed = 0.25;
    float angle = PI + random(-QUARTER_PI, QUARTER_PI);
    posX += sin(angle) * s / 2 * speed;
    posY += cos(angle) * s * speed;

    if (posY <= -s) {
      init();
    }

    trueCanvas.popStyle();
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
    trueCanvas.fill(0);
    trueCanvas.rect(0, 0, displayWidth, displayHeight);

    for (int i = 0; i < nBubbles; i++) {
      Bubble d = (Bubble) bubbles.get(i);
      d.update();
    }
  }
}

