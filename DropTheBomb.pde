class DropTheBomb extends Routine {
  float bombX;
  float bombY;
  float bombSpeed;
  float flashSpeed;
  float flashBrightness;
  float blastRadius;
  float blastSpeed;
  int bombLength;

  void setup(PApplet parent) {
    super.setup(parent);
    bombSpeed = displayHeight / (frameRate*2.5);
    flashSpeed = 255 / (frameRate*4);
    blastSpeed = max(displayWidth, displayHeight) / (frameRate*2);
    bombLength = 7;
  }

  void reset() {
    bombX = displayWidth-bombLength;;
    bombY = random(displayHeight);
    flashBrightness = 255;
    blastRadius = 0;
  }

  void draw() {
    if (bombX > 0) {
      drawBomb();
      bombX -= bombSpeed;
    }
    else if (flashBrightness > 0) {
      drawFlash();
      flashBrightness -= flashSpeed;
    }
//    else if (blastRadius/2 < displayWidth || blastRadius/2 < displayHeight) {
//      drawBlast();
//      blastRadius += blastSpeed;
//    }
    else {
      //newMode();
      newMode(6);
    }
  }

  void drawBomb() {
    int c = 255;
    background(0);

    for (int i=0; i<bombLength; i++) {
      stroke(c);
      point(bombX+i, bombY);
      c = int(0.75*c);
    }
  }

  void drawFlash() {
    colorMode(HSB);
    background(0, 255 - flashBrightness, flashBrightness);
    colorMode(RGB);
  }

  void drawBlast() {
    noStroke();
    rectMode(CENTER);
    background(0);
    for (int i=0; i<5; i++) {
      fill(255-(i*16), 64-(i*4), 32-(i*2));
      ellipseMode(CENTER);
      rect(0, displayHeight, blastRadius/(i+1), displayHeight*2);
    }
  }
}

