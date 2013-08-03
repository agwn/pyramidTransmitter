class Warp extends CanvasRoutine {
  int w;
  int h;
  boolean warpHorizontal;
  boolean warpVertical;
  int sineTableNormSize = 256;
  float sineTableNormSizeInv = 1.0 / sineTableNormSize;
  float[] sineTableNorm;
  float hAmp = 1.0;
  float hCycles = 0.25;
  float hPhase = 0.25;
  float hBias = 0.0;
  float vAmp = 1.0;
  float vCycles = 0.25;
  float vPhase = 0.25;
  float vBias = 0.0;

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
      float vPhaseInc = vCycles * 1.0 / w; 
      float tempPhase = vPhase;
      float amp = vAmp * h;

      for (int x = 0; x < w; x++) {
        float v = sineTableNorm[(int) (tempPhase * sineTableNormSize)];
        tempPhase += vPhaseInc;
        if (tempPhase >= 1.0) {
          tempPhase -= 1.0;
        }

        int offset = (int) (v * amp);
        offset += vBias * amp;
        offset -= (offset / h) * h;
        int length = h - offset;

        PImage imageSlice = pg.get(x, offset, 1, length);
        pg.copy(pg.get(), x, 0, 1, offset,
                x, length, 1, offset);
        pg.image(imageSlice, x, 0, 1, length);
      }

      vPhase += vPhaseInc;
      if (vPhase >= 1.0) {
        vPhase -= 1.0;
      }      
    }

    if (warpHorizontal) {
      float hPhaseInc = hCycles * 1.0 / h; 
      float tempPhase = hPhase;
      float amp = hAmp * w;

      for (int y = 0; y < h; y++) {
        float v = sineTableNorm[(int) (tempPhase * sineTableNormSize)];
        tempPhase += hPhaseInc;
        if (tempPhase >= 1.0) {
          tempPhase -= 1.0;
        }

        int offset = (int) (v * amp);
        offset += hBias * amp;
        offset -= (offset / w) * w;
        int length = w - offset;

        PImage imageSlice = pg.get(offset, y, length, 1);
        pg.copy(pg.get(), 0, y, offset, 1,
                length, y, offset, 1);
        pg.image(imageSlice, 0, y, length, 1);
      }

      hPhase += hPhaseInc;
      if (hPhase >= 1.0) {
        hPhase -= 1.0;
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
