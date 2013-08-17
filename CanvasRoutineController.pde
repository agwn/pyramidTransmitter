class SetList extends CanvasRoutineController {
  SetList(CanvasRoutineController crc) {
    super(crc);
  }

  SetList() { }
}

class CanvasRoutineController {
  CanvasRoutineController masterControl = this;  // Red spinning cylinder 
  ArrayList<DomeCode> domeCode;
  ArrayList<ModEvent> modEvents;
  ArrayList<ModEvent> modEventsGarbage;
  boolean[] activeCanvases;
  int nCanvases;
  int index = 0;                                 // Current position in DomeCode

  CanvasRoutineController() {
    domeCode = new ArrayList<DomeCode>();
    nCanvases = canvases.length;
    activeCanvases = new boolean[nCanvases];
    modEvents = new ArrayList<ModEvent>();
    modEventsGarbage = new ArrayList<ModEvent>();

    initDomeCode();
  }

  CanvasRoutineController(CanvasRoutineController parent) {
    masterControl = parent;
    domeCode = parent.domeCode;
    nCanvases = parent.nCanvases;
    activeCanvases = parent.activeCanvases;
    modEvents = parent.modEvents;
    modEventsGarbage = parent.modEventsGarbage;

    initDomeCode();
  }

  void setup() { }

  void update() {
    runModEvents();
    cleanupModEvents();
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

  void popCanvas(Canvas c) {
    domeCode.add(new DomePopCanvas(masterControl, c));
  }

  void wait(float seconds) {
    int waitFrameCounter = (int) (seconds * FRAMERATE);
    domeCode.add(new DomeWait(masterControl, waitFrameCounter));
  }

  void crossfade(float seconds, Canvas c0, Canvas c1) {
    int waitFrameCounter = (int) (seconds * FRAMERATE);
    domeCode.add(new DomeCrossfade(masterControl, waitFrameCounter, c0, c1));
  }

  void fadeIn(float seconds, Canvas canvas) {
    int waitFrameCounter = (int) (seconds * FRAMERATE);
    domeCode.add(new DomeFadeIn(masterControl, waitFrameCounter, canvas));
  }

  void fadeOut(float seconds, Canvas canvas) {
    int waitFrameCounter = (int) (seconds * FRAMERATE);
    domeCode.add(new DomeFadeOut(masterControl, waitFrameCounter, canvas));
  }

  void disableCanvas(Canvas c) {
    domeCode.add(new DomeDisableCanvas(masterControl, c));
  }

  void enableCanvas(Canvas c) {
    domeCode.add(new DomeEnableCanvas(masterControl, c));
  }

  void disableCanvases() {
    domeCode.add(new DomeDisableCanvases(masterControl));
  }

  void playSetList(CanvasRoutineController CRC) { }

  void setParam(ModFloat m, float v) {
    domeCode.add(new DomeSetModFloat(masterControl, m, v));
  }

  void setParam(ModColor c, color v) {
    domeCode.add(new DomeSetModColor(masterControl, c, v));
  }

  void line(float seconds, ModFloat m, float start, float end) {
    ModLine modLine = new ModLine(masterControl, m, (int) (seconds * FRAMERATE), start, end);
    domeCode.add(new DomeLine(masterControl, modLine));
  }

  void removeModEvent(ModEvent m) {
    modEventsGarbage.add(m);
  }

  void cleanupModEvents() {
    for (ModEvent m : modEventsGarbage) {
      while (modEvents.contains(m)) {
        modEvents.remove(m);
      }
    }

    modEventsGarbage.clear();
  }

  private void initDomeCode() {
    disableCanvases();  // Resets canvases at beginning of loop
    setup();
    disableCanvases();  // Resets canvases at beginning of loop
  }

  private void runDomeCode() {
    domeCode.get(masterControl.index).run();
  }

  private void runModEvents() {
    for (ModEvent e : modEvents) {
      e.run();
    }
  }

  private void next() {
    masterControl.index++;

    if (masterControl.index >= domeCode.size()) {
      masterControl.index = 0;
    }
  }
}
