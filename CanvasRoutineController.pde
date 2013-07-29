class CanvasRoutineController {
  ArrayList domeCode;
  int index = 0;
  boolean[] activeCanvases;
  int nCanvases;

  CanvasRoutineController() {
    domeCode = new ArrayList();
    nCanvases = canvases.length;
    activeCanvases = new boolean[nCanvases];

    for (int i = 0; i < nCanvases; i++) {
      activeCanvases[i] = false;
    }

    wait(0.0);  // Prevents infinite DomeCode loop
  }

  void update() {
    canvasOut.clear();

    for (int i = 0; i < nCanvases; i++) {
      if (activeCanvases[i]) {
        Canvas canvas = canvases[i];
        int w = canvas.w;
        int h = canvas.h;
        int nRoutines = canvas.routines.size();
        PGraphics pgFlat = canvas.pgFlat;

        pgFlat.beginDraw();
        pgFlat.noStroke();
        pgFlat.fill(0);
        pgFlat.rect(0, 0, w, h);

        // Render each routine in the canvases routine stack
        for (int j = 0; j < nRoutines; j++) {
          CanvasRoutine cr = (CanvasRoutine) canvas.routines.get(j);

          cr.draw();
        
          switch(cr.getPaintMode()) {
            case CANVAS_ROUTINE_BLEND:
              pgFlat.blend(cr.pg.get(), 0, 0, w, h, 0, 0, w, h, cr.blendMode);
              break;
            case CANVAS_ROUTINE_OVERWRITE:
              pgFlat.copy(cr.pg.get(), 0, 0, w, h, 0, 0, w, h);
              break;
            case CANVAS_ROUTINE_DIRECT:
              break;
          }
        }

        pgFlat.endDraw(); 
        canvas.sendToOutput();
      }
    }

    runDomeCode();
  }

  void runDomeCode() {
    DomeCode wc = (DomeCode) domeCode.get(index);
    wc.run();
  }

  private void next() {
    index++;

    if (index >= domeCode.size()) {
      index = 0;
      // if is child, return to parent
    }
  }

  void setCanvas(Canvas c, CanvasRoutine cr) {
    domeCode.add(new DomeSetCanvas(this, c, cr));
  }
  
  void pushCanvas(Canvas c, CanvasRoutine cr) {
    domeCode.add(new DomePushCanvas(this, c, cr));
  }

  void wait(float seconds) {
    int waitFrameCounter = (int) (seconds * FRAMERATE);
    domeCode.add(new DomeWait(this, waitFrameCounter));
  }

  void crossfade(float seconds, Canvas c0, Canvas c1) {
    int waitFrameCounter = (int) (seconds * FRAMERATE);
    domeCode.add(new DomeCrossfade(this, waitFrameCounter, c0, c1));
  }

  void disableCanvas(Canvas c) {
    domeCode.add(new DomeDisableCanvas(this, c));
  }

  void enableCanvas(Canvas c) {
    domeCode.add(new DomeEnableCanvas(this, c));
  }
}
