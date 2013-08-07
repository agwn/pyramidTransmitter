class Warp extends CanvasRoutine {
  int w;
  int h;
  boolean warpHorizontal;
  boolean warpVertical;
  int sineTableNormSize = 256;
  float sineTableNormSizeInv = 1.0 / sineTableNormSize;
  float[] sineTableNorm;
  float yAmp = 1.0;
  float yFreq = 0.25;
  float yPhase = 0.25;
  float yBias = 0.0;
  float xAmp = 1.0;
  float xFreq = 0.25;
  float xPhase = 0.25;
  float xBias = 0.0;

  public Warp() {
    initSineTable();
    warpHorizontal = true;
    warpVertical = true;
    setPaintMode(DIRECT);
  }

  void reinit() {
    w = pg.width;
    h = pg.height;
  }

  void draw() {
    pg.beginDraw();

    if (warpVertical) {
      float xPhaseInc = xFreq * 1.0 / w; 
      float tempPhase = xPhase;
      float amp = xAmp * h;

      for (int x = 0; x < w; x++) {
        float v = sineTableNorm[(int) (tempPhase * sineTableNormSize)];
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

      xPhase += xFreq / FRAMERATE;
      if (xPhase >= 1.0) {
        xPhase -= 1.0;
      }      
    }

    if (warpHorizontal) {
      float yPhaseInc = yFreq * 1.0 / h; 
      float tempPhase = yPhase;
      float amp = yAmp * w;

      for (int y = 0; y < h; y++) {
        float v = sineTableNorm[(int) (tempPhase * sineTableNormSize)];
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

      yPhase += yFreq / FRAMERATE;
      if (yPhase >= 1.0) {
        yPhase -= 1.0;
      }      
    }

    pg.endDraw();
  }

  void initSineTable() {
    sineTableNorm = new float[sineTableNormSize];

    for (int i = 0; i < sineTableNormSize; i++) {
      sineTableNorm[i] = sin(i * sineTableNormSizeInv * TWO_PI) * 0.5 + 0.5;
    }
  }
}
