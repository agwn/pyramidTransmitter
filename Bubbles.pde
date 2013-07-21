/*

  #########  ##  #########
  ########## ### ##########
  ##      ##  ##         ##
  ##      ##  ##   ########
  ##      ##  ##   ########
  ##      ##  ##         ##
  ##########  ## ##########
  #########   ## #########

*/

class Bubble {
  float posX;
  float posY;
  float s;
  int minSize = 9;
  int maxSize = 24;
  FullCanvas canvas;
  color pornjPink = color(252, 23, 218);
  color orange = color(255, 128, 0);
  color white = color(255);
  color thisColor;
  float flash = 0.0;
  float flashDecay = 0.25;
  float speed = 0.125;

  Bubble(FullCanvas fullCanvas) {
    canvas = fullCanvas;
    init();
  }

  void init() {
    s = random(minSize, maxSize);
    posY = canvas.height + s;
    posX = random(-s, canvas.width + s);
    thisColor = canvas.lerpColor(pornjPink, orange, random(1.0));
  }

  void update() {
    canvas.pushStyle();
    canvas.noStroke();

    if (random(1.0) >= 0.95) {
      flash = 1.0;
    }
    color temp = canvas.lerpColor(thisColor, white, flash);
    canvas.fill(temp, (s - minSize) / maxSize * 239 + 16);
    flash -= flashDecay;
    flash = flash < 0.0 ? 0.0 : flash;

    canvas.ellipse(posX, posY, s, s);

    // Too jittery?
//    float angle = PI + random(-QUARTER_PI, QUARTER_PI);

    float angle = PI;
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

