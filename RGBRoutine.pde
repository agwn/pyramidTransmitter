class RGBRoutine extends Routine {
  int color_angle = 0;

  void draw() {
    background(0);
    noSmooth();
    float scaling = 1.0;

    for (int row = 0; row < displayHeight; row++) {
      for (int col = 0; col < displayWidth; col++) {
        float r = (((row)*2 + 100.0*col/displayWidth + color_angle +  0)%100)*(varMax[0]/100.0);
        float g = (((row)*2 + 100.0*col/displayWidth + color_angle + 33)%100)*(varMax[1]/100.0);
        float b = (((row)*2 + 100.0*col/displayWidth + color_angle + 66)%100)*(varMax[2]/100.0);

        stroke(int(scaling*r), int(scaling*g), int(scaling*b));
        //print("("+col+","+row+"):"+int(r)+","+int(g)+","+int(b)+" ");
        point(col, row);
      }
    }

    color_angle = (color_angle+1)%255;


    long frame = frameCount - modeFrameStart;
    if (frame > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    }
  }
}

