class SetList extends CanvasRoutineController {
  SetList(CanvasRoutineController crc) {
    super(crc);
  }

  SetList() { }
}

class CanvasRoutineController {
  CanvasRoutineController masterControl = this;  // Red spinning cylinder 
  ArrayList<DomeCode> domeCode;
  boolean[] activeCanvases;
  int nCanvases;
  int index = 0;                                 // Current position in DomeCode

  CanvasRoutineController() {
    domeCode = new ArrayList<DomeCode>();
    nCanvases = canvases.length;
    activeCanvases = new boolean[nCanvases];

    initDomeCode();
  }

  CanvasRoutineController(CanvasRoutineController parent) {
    masterControl = parent;
    domeCode = parent.domeCode;
    nCanvases = parent.nCanvases;
    activeCanvases = parent.activeCanvases;

    initDomeCode();
  }

  void setup() { }

  void update() {
    canvasOut.clear();

    for (int i = 0; i < nCanvases; i++) {
      if (activeCanvases[i]) {
        Canvas canvas = canvases[i];
        int w = canvas.w;
        int h = canvas.h;
        int nRoutines = canvas.routines.size();
        PGraphics pgMaster = canvas.pgMaster;

        pgMaster.beginDraw();
        pgMaster.background(0);

        // Render each routine in the canvases routine stack
        for (int j = 0; j < nRoutines; j++) {
          CanvasRoutine cr = (CanvasRoutine) canvas.routines.get(j);

          cr.draw();
        
          switch(cr.getPaintMode()) {
            case CANVAS_ROUTINE_BLEND:
              pgMaster.blend(cr.pg.get(), 0, 0, w, h, 0, 0, w, h, cr.blendMode);
              break;
            case CANVAS_ROUTINE_OVERWRITE:
              pgMaster.copy(cr.pg.get(), 0, 0, w, h, 0, 0, w, h);
              break;
            case CANVAS_ROUTINE_DIRECT:
              break;
          }
        }

        pgMaster.endDraw(); 
        canvas.sendToOutput();
      }
    }

    runDomeCode();
  }

  void setCanvas(Canvas c, CanvasRoutine cr) {
    domeCode.add(new DomeSetCanvas(masterControl, c, cr));
  }
  
  void pushCanvas(Canvas c, CanvasRoutine cr) {
    domeCode.add(new DomePushCanvas(masterControl, c, cr));
  }

  void wait(float seconds) {
    int waitFrameCounter = (int) (seconds * FRAMERATE);
    domeCode.add(new DomeWait(masterControl, waitFrameCounter));
  }

  void crossfade(float seconds, Canvas c0, Canvas c1) {
    int waitFrameCounter = (int) (seconds * FRAMERATE);
    domeCode.add(new DomeCrossfade(masterControl, waitFrameCounter, c0, c1));
  }

  void disableCanvas(Canvas c) {
    domeCode.add(new DomeDisableCanvas(masterControl, c));
  }

  void enableCanvas(Canvas c) {
    domeCode.add(new DomeEnableCanvas(masterControl, c));
  }

  void disableCanvases() {
    for (int i = 0; i < nCanvases; i++) {
      disableCanvas(canvases[i]);
    }
  }

  void playSetList(CanvasRoutineController CRC) { }

  private void initDomeCode() {
    disableCanvases();  // Resets canvases at beginning of loop
    wait(0.0);          // Prevents infinite DomeCode loop
    setup();
  }

  private void runDomeCode() {
    domeCode.get(index).run();
  }

  private void next() {
    index++;

    if (index >= domeCode.size()) {
      index = 0;
    }
  }
}
