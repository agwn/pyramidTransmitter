class Canvas {
  int x;
  int y;
  int w;
  int h;
  CanvasRoutine cr;
  PGraphics pg;
  PGraphics pgFlat;
  ArrayList routines;

  
  float brightness = 1.0;

  Canvas(int x_, int y_, int w_, int h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;

    routines = new ArrayList();
    pg = createGraphics(w, h, P2D);
    pgFlat = createGraphics(w, h, P2D);
  }

  void setRoutine(CanvasRoutine cr_) {
    cr = cr_;
    cr.setCanvas(this);
  }

  void setRoutineX(CanvasRoutine cr_) {
    routines.add(cr_);
    //cr = cr_;
    cr_.setCanvas(this);
  }


  void sendToOutput() {
    if (this != canvasOut) {
      image(pgFlat, x, y);
    }

    // Apply brightness
    pg.beginDraw();
    pg.noStroke();
    pg.fill(0, (1.0 - brightness) * 255);
    pg.rect(0, 0, w, h);
    pg.endDraw();

    if (w == 474) {
      writeProportional();
      return;
    }
    writeNormal();
  }

  private void writeNormal() {
    canvasOut.pg.blend(pgFlat.get(), 0, 0, displayWidth, displayHeight, 0, 0, displayWidth, displayHeight, SCREEN);
  }

  private void writeProportional() {
    int offset = 0;
    int canvasOutHeight = canvasOut.h;
    PGraphics cpg = canvasOut.pg;

    cpg.beginDraw();

    for (int col = 0; col < 8; col++) {
      for (int strip = 0; strip < 8; strip++) {
        cpg.blend(pgFlat.get(offset + strip * 3, 0, 1, h),
             0, 0, 1, h,
             strip + col * 8, 0, 1, canvasOutHeight, SCREEN);
      }

      // Add gaps
      offset += 60;

      // Add extra gap in middle
      if (col == 3) {
        offset += 30;
      }
    }

    cpg.endDraw();
  }

  void clear() {
    pg.beginDraw();
    pg.background(0);
    pg.endDraw();
  }
}

