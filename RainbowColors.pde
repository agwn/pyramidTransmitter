class RainbowColors extends Routine {
  void draw() {
    long frame = frameCount - modeFrameStart;

    //print(mouseY*255.0/displayHeight);
    //print(" ");

    colorMode(HSB, 100);

    for (int x = 0; x < displayWidth; x++) {
      for (int y = 0; y < displayHeight; y++) {
        if (x < displayWidth/2) {
          stroke((pow(x, 0.3)*pow(y, .8)+frame)%100, 90*random(.7, 1.3), 90*random(.8, 1.2));
        }
        else {
          stroke((pow(displayWidth-x, 0.3)*pow(y, .8)+frame)%100, 90*random(.7, 1.3), 90*random(.8, 1.2));
        }
        point((x+frame)%displayWidth, y);
      }
    }

    colorMode(RGB, 255);

    if (frame > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    }
  }
}

