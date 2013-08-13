class Warp extends CanvasRoutine {
  boolean warpHorizontal;
  boolean warpVertical;
  ModFloat yAmp;
  ModFloat yFreq;
  float yPhase = 0.0;
  float yBias = 0.0;
  ModFloat xAmp;
  ModFloat xFreq;
  float xPhase = 0.0;
  float xBias = 0.0;
  private int w;
  private int h;

  public Warp() {
    warpHorizontal = true;
    warpVertical = true;
    yAmp = new ModFloat(1.0);
    xAmp = new ModFloat(1.0);
    yFreq = new ModFloat(1.0);
    xFreq = new ModFloat(1.0);
    setPaintMode(DIRECT);
  }

  void reinit() {
    w = pg.width;
    h = pg.height;
  }

  void draw() {
    pg.beginDraw();

    if (warpVertical) {
      float thisXFreq = xFreq.get();
      float xPhaseInc = thisXFreq * 1.0 / w; 
      float tempPhase = xPhase;
      float amp = xAmp.get() * h;

      for (int x = 0; x < w; x++) {
        float v = sineTableNorm[(int) (tempPhase * sineTableSize)];
        tempPhase += xPhaseInc;
        if (tempPhase >= 1.0) {
          tempPhase -= 1.0;
        }

        int offset = (int) (v * amp);
        offset += xBias * amp;
        offset -= (offset / h) * h;
        int length = h - offset;

        PImage imageSlice = pg.get(x, offset, 1, length);
        pg.copy(pg.get(), x, 0, 1, offset,
                x, length, 1, offset);
        pg.image(imageSlice, x, 0, 1, length);
      }

      xPhase += thisXFreq / FRAMERATE;
      if (xPhase >= 1.0) {
        xPhase -= 1.0;
      }      
    }

    if (warpHorizontal) {
      float thisYFreq = yFreq.get();
      float yPhaseInc = thisYFreq * 1.0 / h; 
      float tempPhase = yPhase;
      float amp = yAmp.get() * w;

      for (int y = 0; y < h; y++) {
        float v = sineTableNorm[(int) (tempPhase * sineTableSize)];
        tempPhase += yPhaseInc;
        if (tempPhase >= 1.0) {
          tempPhase -= 1.0;
        }

        int offset = (int) (v * amp);
        offset += yBias * amp;
        offset -= (offset / w) * w;
        int length = w - offset;

        PImage imageSlice = pg.get(offset, y, length, 1);
        pg.copy(pg.get(), 0, y, offset, 1,
                length, y, offset, 1);
        pg.image(imageSlice, 0, y, length, 1);
      }

      yPhase += thisYFreq / FRAMERATE;
      if (yPhase >= 1.0) {
        yPhase -= 1.0;
      }      
    }

    pg.endDraw();
  }
}
