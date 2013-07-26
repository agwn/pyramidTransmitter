class CanvasRoutineController {
  ArrayList domeCode;
  int index = 0;
  boolean[] activeCanvases;

  CanvasRoutineController() {
    domeCode = new ArrayList();
    activeCanvases = new boolean[4];
    for (int i = 0; i < 4; i++) {
      activeCanvases[i] = false;
    }
  }

  void programIt() { }  

  void update() {
    canvasOut.clear();

    if (activeCanvases[0]) {
      canvas1.cr.draw();
      canvas1.sendToOutput();
    }
    if (activeCanvases[1]) {
      canvas2.cr.draw();
      canvas2.sendToOutput();
    }

    runDomeCode();
  }

  void runDomeCode() {
    DomeCode wc = (DomeCode) domeCode.get(index);
    wc.doIt();
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
}

class SetList extends CanvasRoutineController {
  SetList() {
    println("SetList instantiated");
    Pxxxls r1 = new Pxxxls(canvas1, 100);
    SineColumns r2 = new SineColumns(canvas2);

    setCanvas(canvas1, r1);
    wait(4.0);
    setCanvas(canvas2, r2);
    crossfade(4.0, canvas1, canvas2);
    wait(4.0);
    crossfade(4.0, canvas2, canvas1);
    wait(4.0);
  }
}

