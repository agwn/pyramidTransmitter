class Greetz extends Routine {
  int FONT_SIZE = 8;
  PFont font;
  PImage imgCopy;
  String messages[] = new String[] {
    "DiSORieNT",
    //"CRASH Space", 
    //"N Y C R",
    //"KOSTUME  KULT",
    //"BLACK  LIGHT  BALL"
    //"COUNTRY  CLUB",
  };
  String message = "DiSORieNT";

  void setup(PApplet parent) {
    super.setup(parent);
    font = loadFont("Disorient-" + FONT_SIZE + ".vlw");
    textFont(font, 7/*FONT_SIZE*/);
    textMode(MODEL);
  }

  void draw() {
    background(0);
    fill(255);

    if (w == 0) {
      w = -int((message.length()-1) * (FONT_SIZE*1.35) + displayWidth);
    }

    fill(255, 128, 64);
    text(message, x, FONT_SIZE);

    if (displayHeight/2 > FONT_SIZE) {

      image(get(0, 0, displayWidth, FONT_SIZE), 0, displayHeight*3/4, displayWidth, displayHeight/4);
      fill(0);
      rect(0, 0, displayWidth, FONT_SIZE);
      //copy(0,0,displayWidth,FONT_SIZE,0,FONT_SIZE,displayWidth,FONT_SIZE/2);
      //imgCopy = copy(0,0,displayWidth,FONT_SIZE);
      //image(imgCopy,0,0,displayWidth,displayHeight);
    }

    if (frameCount % 2 == 0) {
      x = x - 1;
    }

    if (x<w) {
      x = displayHeight;
      message = messages[int(random(messages.length))];
      w = 0;
      newMode();
    }
  }
}

