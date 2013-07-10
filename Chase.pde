class Chase extends Routine {
  float r = random(varMin[0], varMax[0]);
  float g = random(varMin[1], varMax[1]);
  float b = random(varMin[2], varMax[2]);

  void draw() {
    background(0);
    // select from full range to introduce more variance
    r = constrain(0.95*r+0.05*random(varMax[0]/3),0,255);
    g = constrain(0.95*g+0.05*random(varMax[1]/3),0,255);
    b = constrain(0.95*b+0.05*random(varMax[2]/3),0,255);
    //println("color:"+int(r)+","+int(g)+","+int(b));
    stroke(color(r, g, b));

    //stroke(color(random(varMin[0], varMax[0]), random(varMin[1], varMax[1]), random(varMin[2], varMax[2])));

    long frame = frameCount - modeFrameStart;
    for (int i=0; i<6; i++) {
      line((frame/3.0+random(0.25*i, 1.0*i))%displayWidth, 0, ((frame/3.0+random(0.25*i, 1.0*i)))%displayWidth, displayHeight);
    }
    if (frame > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    }
  }
}

