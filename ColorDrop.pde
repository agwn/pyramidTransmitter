class ColorDrop extends Routine {
  void draw() {
    background(0);

    float frame_mult = 3;  // speed adjustment

    // lets add some jitter
    modeFrameStart = modeFrameStart - min(0, int(random(-3, 6)));

    long frame = frameCount - modeFrameStart;


    for (int col = 0; col < displayWidth; col++) {
      float phase = sin((float)((col+frame*frame_mult)%displayWidth)/displayWidth*PI + random(0, .01));

      float r = 0;
      float g = 0;
      float b = 0;

      if ((col+frame*frame_mult)%(3*displayWidth) < displayWidth) {
        r = random(varMax[0])*phase;
        g = random(varMin[1]);
        b = random(varMin[2]);
      }
      else if ((col+frame*frame_mult)%(3*displayWidth) < displayWidth*2) {
        r = random(varMin[0]);
        g = random(varMax[1])*phase;
        b = random(varMin[2]);
      }
      else {
        r = random(varMin[0]);
        g = random(varMin[1]);
        b = random(varMax[2])*phase;
      }

      stroke(r, g, b);
      line(col, 0, col, displayHeight);
    }

    if (frame > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    }
  }
}

