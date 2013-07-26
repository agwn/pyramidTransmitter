class CanvasRoutineController {
  ArrayList domeCode;
  int index = 0;
  boolean[] activeCanvases;
  CanvasRoutineController parentController = null;

  CanvasRoutineController() {
    domeCode = new ArrayList();
    activeCanvases = new boolean[canvases.length];

    for (int i = 0; i < activeCanvases.length; i++) {
      activeCanvases[i] = false;
    }

    wait(0.0);  // Prevents infinite DomeCode loop
  }

  CanvasRoutineController(CanvasRoutineController parent) {
    parentController = parent;
  }

  void update() {
    canvasOut.clear();

    for (int i = 0; i < canvases.length; i++) {
      if (activeCanvases[i]) {
        canvases[i].cr.draw();
        canvases[i].cr.renderCanvas();
        canvases[i].sendToOutput();
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

  void wait(float seconds) {
    int waitFrameCounter = (int) (seconds * FRAMERATE);
    domeCode.add(new DomeWait(this, waitFrameCounter));
  }

  void crossfade(float seconds, Canvas c0, Canvas c1) {
    int waitFrameCounter = (int) (seconds * FRAMERATE);
    domeCode.add(new DomeCrossfade(this, waitFrameCounter, c0, c1));
  }

  void disableCanvas(Canvas c) {
    println("disableCanvas");
    domeCode.add(new DomeDisableCanvas(this, c));
  }

  void enableCanvas(Canvas c) {
    domeCode.add(new DomeEnableCanvas(this, c));
  }
}

class SetList extends CanvasRoutineController {
  SetList() {
    Seizure r1 = new Seizure();
    //Pxxxls r1 = new Pxxxls(20);
    SineColumns r2 = new SineColumns();

    setCanvas(canvases[2], r1);
    wait(4.0);
    setCanvas(canvases[1], r2);
    wait(4.0);
    setCanvas(canvases[1], r2);
    crossfade(4.0, canvases[2], canvases[1]);
    wait(4.0);
    crossfade(4.0, canvases[1], canvases[2]);
    wait(4.0);
  }
}
