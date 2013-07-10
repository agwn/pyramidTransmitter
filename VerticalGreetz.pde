class VerticalGreetz extends Routine {
  int FONT_SIZE = 16;
  PFont font;
  String messages[] = new String[] {
    "DISORIENT"//,
    //  "KOSTUME  KULT",
    //  "BLACK  LIGHT  BALL"
    //  "COUNTRY  CLUB"
  };
  String message = "DISORIENT";
  PGraphics buffer;
  int bufferWidth;
  int bufferHeight;
  int w;

  void setup(PApplet parent) {
    super.setup(parent);
    w = bufferWidth = displayHeight;
    bufferHeight = displayWidth;

    buffer = createGraphics(bufferWidth, bufferHeight, JAVA2D);
    font = loadFont("Disorient-" + FONT_SIZE + ".vlw");
    buffer.textFont(font, FONT_SIZE);
    buffer.textMode(MODEL);
  }

  void draw() {
    buffer.beginDraw();
    buffer.background(0);

    if (w == 0) {
      w = -int((message.length()-1) * (FONT_SIZE*1.35) + displayWidth);
    }

    buffer.fill(255, 128, 64);
    buffer.text(message, x, FONT_SIZE+5);
    buffer.endDraw();

    pushMatrix();

    rotate(-HALF_PI);
    translate(0, -displayWidth);
    image(buffer, 0, 0);
    popMatrix();

    if (frameCount % 2 == 0) {
      x = x - 1;
    }

    if (x<w) {
      x = bufferWidth;
      message = messages[int(random(messages.length))];
      w = 0;
      newMode();
    }
  }
}

