class Warp extends CanvasRoutine {
  int w;
  int h;
  boolean warpHorizontal;
  boolean warpVertical;
  int sineTableSize = 256;
  float sineTableSizeInv = 1.0 / sineTableSize;
  float[] sineTable;
  float hAmp = 1.0;
  float hCycles = 0.3;
  float hPhaseInc = hCycles * 1.0 / 210.0; 
  float hPhase = 0.0;
  float vAmp = 0.333;
  float vCycles = 0.1;
  float vPhaseInc = vCycles * 1.0 / 64.0; 
  float vPhase = 0.25;

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
    if (warpVertical) {
      float tempPhase = vPhase;
      for (int x = 0; x < w; x++) {
        float v = sineTable[(int) (tempPhase * sineTableSize)] / 2.0 + 0.5;
        tempPhase += vPhaseInc;
        if (tempPhase >= 1.0) {
          tempPhase -= 1.0;
        }

        int offset = (int) (v * vAmp * h);
        int length = h - offset;

        PImage tmp = pg.get(x, offset, 1, length);
        pg.copy(pg.get(), x, 0, 1, offset,
                x, length, 1, offset);
        pg.image(tmp, x, 0, 1, length);
      }

      vPhase += vPhaseInc;
      if (vPhase >= 1.0) {
        vPhase -= 1.0;
      }      
    }

    if (warpHorizontal) {
      float tempPhase = hPhase;
      for (int y = 0; y < h; y++) {
        float v = sineTable[(int) (tempPhase * sineTableSize)] / 2.0 + 0.5;
        tempPhase += hPhaseInc;
        if (tempPhase >= 1.0) {
          tempPhase -= 1.0;
        }

        int offset = (int) (v * hAmp * w);
        int length = w - offset;

        PImage tmp = pg.get(offset, y, length, 1);
        pg.copy(pg.get(), 0, y, offset, 1,
                length, y, offset, 1);
        pg.image(tmp, 0, y, length, 1);
      }

      hPhase += hPhaseInc;
      if (hPhase >= 1.0) {
        hPhase -= 1.0;
      }      
    }
  }

  void initSineTable() {
    sineTable = new float[sineTableSize];

    for (int i = 0; i < sineTableSize; i++) {
      sineTable[i] = sin(i * sineTableSizeInv * TWO_PI);
    }
  }
}
