class Bubble {
  float posX;
  float posY;
  float s;     // Size
  FullCanvas canvas;

  Bubble(FullCanvas fullCanvas) {
    canvas = fullCanvas;
    init();
  }

  void init() {
    s = random(4, 12);
    posY = canvas.height + s;
    posX = random(-s, canvas.width + s);
  }

  void update() {
    canvas.pushStyle();
    canvas.noStroke();
    canvas.fill(255, (s - 2) / 6.0 * 128);  // Larger bubbles are brighter
    canvas.ellipse(posX, posY, s, s);

    float speed = 0.25;
    float angle = PI + random(-QUARTER_PI, QUARTER_PI);
    posX += sin(angle) * s * speed;
    posY += cos(angle) * s * speed;

    if (posY <= -s) {
      init();
    }

    canvas.popStyle();
  }
}

class Bubbles extends Routine {
  ArrayList bubbles;
  int nBubbles = 20;
  float QUARTER_PI = PI * 0.125;
  FullCanvas canvas;

  Bubbles(FullCanvas fullCanvas) {
    canvas = fullCanvas; 
    generateBubbles();
  }

  Bubbles(FullCanvas fullCanvas, int nBubbles_) {
    canvas = fullCanvas;
    nBubbles = nBubbles_;
    generateBubbles();
  }

  void generateBubbles() {
    bubbles = new ArrayList();
    for (int i = 0; i < nBubbles; i++) {
      Bubble d = new Bubble(canvas);
      bubbles.add(d);
    }
  }

  void draw() {
    canvas.fill(0);
    canvas.rect(0, 0, canvas.width, canvas.height);

    for (int i = 0; i < nBubbles; i++) {
      Bubble d = (Bubble) bubbles.get(i);
      d.update();
    }
  }
}

