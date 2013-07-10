class ColorTest extends Routine {
  int animationStep = 0;
  int frameCnt = 0;
  int lineSpacing = 20;
  int lineSlope = 10;
  float r = 255;
  float g = 0;
  float b = 0;

  void draw() {
    background(0);

    long frame = frameCount - modeFrameStart;
    for (int i=0; i<(displayHeight+lineSlope); i++) {
      if (animationStep == i%lineSpacing) {
        //println("color:"+int(r)+","+int(g)+","+int(b));
        stroke(color(r, g, b));
        line(0, i, displayWidth, i-lineSlope);
      }
    }
    if (frame > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    }

    frameCnt++;

    if (0 == frameCnt%4) {
      animationStep = (animationStep + 1)%lineSpacing;
    }
    if (0 == frameCnt%(64*4)) {
      if (r>0) {
        r = 0;
        g = 255;
        b = 0;
      }
      else if (g>0) {
        r = 0;
        g = 0;
        b = 255;
      }
      else {
        r = 255;
        g = 0;
        b = 0;
      }
      frameCnt = 0;
    }
  }
}

