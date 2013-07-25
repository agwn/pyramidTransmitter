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
    // Draw all active canvases
    DomeSetCanvas wc = (DomeSetCanvas) domeCode.get(0); 
    CanvasRoutine cr = (CanvasRoutine) wc.params.get(1);

    canvasOut.clear();

    if (activeCanvases[0]) {
      canvas1.cr.draw();
      canvas1.sendToOutput();
    }
    if (activeCanvases[1]) {
      canvas2.cr.draw();
      canvas2.sendToOutput();
    }

    doDomeCode();
  }

  void setCanvas(Canvas c, CanvasRoutine cr) {
    domeCode.add(new DomeSetCanvas(c, cr));
  }

  void wait(float seconds) {
    int waitFrameCounter = (int) (seconds * FRAMERATE);
    domeCode.add(new DomeWait(waitFrameCounter));
  }

  void crossfade(float seconds, Canvas c0, Canvas c1) {
    int waitFrameCounter = (int) (seconds * FRAMERATE);
    domeCode.add(new DomeCrossfade(waitFrameCounter, c0, c1));
  }

  private void next() {
    index++;

    if (index >= domeCode.size()) {
      index = 0;

      // if is child, return to parent
      // else index = 0
    }
  }

  void doDomeCode() {
    DomeCode wc = (DomeCode) domeCode.get(index);
    int ID = wc.ID;

    switch(ID) {
      case DOME_SET_CANVAS:
        println("DOME_SET_CANVAS");
        doSetCanvas(wc);
        break;
      case DOME_WAIT:
        print("DOME_WAIT ");
        doWait(wc);
        break;
      case DOME_CROSSFADE:
        print("DOME_CROSSFADE");
        doCrossfade(wc);
      case DOME_DO_NOTHING:
        print("DOME_DO_NOTHING");
        break;
      default:
        println("Unrecognized domeCode code. Dome!");
    }
  }

  private void doSetCanvas(DomeCode wc_) {
    DomeSetCanvas wc = (DomeSetCanvas) wc_;
    println("doSetCanvas()  index: " + index);
    Canvas c = (Canvas) wc.params.get(0);
    CanvasRoutine cr = (CanvasRoutine) wc.params.get(1); 

    c.brightness = 1.0;

    if (c == canvas1) {
      activeCanvases[0] = true;
    }
    if (c == canvas2) {
      activeCanvases[1] = true;
    }

    if (c == canvas1) {
      println("doSetCanvas() if met  index: " + index);
      canvas1.setRoutine(cr);
    } 
    if (c == canvas2) {
      println("doSetCanvas() if met  index: " + index);
      canvas2.setRoutine(cr);
    } 

    next();
    doDomeCode();
  };

  private void doWait(DomeCode wc_) {
    DomeWait wc = (DomeWait) wc_;

    if (!wc.isInitialized) {
      wc.init();
    }

    wc.frameCounter--;

    if (wc.frameCounter <= 0) {
      wc.end();
      next();
    }
  };

  private void doCrossfade(DomeCode wc_) {
    DomeCrossfade wc = (DomeCrossfade) wc_;
    Canvas c0 = wc.c0;
    Canvas c1 = wc.c1;

    if (!wc.isInitialized) {
      wc.init();
      c0.brightness = 1.0;
      c1.brightness = 0.0;
    }

    wc.frameCounter--;

    c0.brightness -= wc.framesInv;
    c1.brightness += wc.framesInv;
 
    if (wc.frameCounter <= 0) {
      c0.brightness = 0.0;
      c1.brightness = 1.0;
      wc.end();
      next();
    }
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

