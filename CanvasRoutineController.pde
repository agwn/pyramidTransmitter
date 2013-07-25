class CanvasRoutineController {
  ArrayList werd;
  int index = 0;
  boolean[] activeCanvases;

  CanvasRoutineController() {
    werd = new ArrayList();
    activeCanvases = new boolean[4];
    for (int i = 0; i < 4; i++) {
      activeCanvases[i] = false;
    }
  }

  void programIt() { }  

  void update() {
    // Draw all active canvases
    DOMESetCanvas wc = (DOMESetCanvas) werd.get(0); 
    CanvasRoutine cr = (CanvasRoutine) wc.params.get(1);

    if (activeCanvases[0]) {
      canvas1.cr.draw();
    }
    if (activeCanvases[1]) {
      canvas2.cr.draw();
    }

    doDome();
  }

  void setCanvas(Canvas c, CanvasRoutine cr) {
    werd.add(new DOMESetCanvas(c, cr));
    if (c == canvas1) {
      activeCanvases[0] = true;
    }
    if (c == canvas2) {
      activeCanvases[1] = true;
    }
  }

  void wait(float seconds) {
    int waitFrameCounter = (int) (seconds * FRAMERATE);
    werd.add(new DOMEWait(waitFrameCounter));
  }

  private void next() {
    index++;

    if (index >= werd.size()) {
      index = 0;

      // if is child, return to parent
      // else index = 0
    }
  }

  void doDome() {
    DomeCode wc = (DomeCode) werd.get(index);
    int ID = wc.ID;

    switch(ID) {
      case DOME_SET_CANVAS:
        println("DOME_SET_CANVAS");
        doSetCanvas(wc);
        break;
      case DOME_WAIT:
        println("DOME_WAIT");
        doWait(wc);
        break;
      default:
        println("Unrecognized werd code. Dome!");
    }
  }

  private void doSetCanvas(DomeCode wc_) {
    DOMESetCanvas wc = (DOMESetCanvas) wc_;
    println("doSetCanvas()  index: " + index);
    Canvas c = (Canvas) wc.params.get(0);
    CanvasRoutine rc = (CanvasRoutine) wc.params.get(1); 

    if (c == canvas1) {
      c.cr = rc;
    } 


    next();
    doDome();
  };

  private void doWait(DomeCode wc_) {
    DOMEWait wc = (DOMEWait) wc_;

    if (!wc.isInitialized) {
      wc.init();
    }

    wc.frameCounter--;

    if (wc.frameCounter <= 0) {
      wc.finish();
      next();
    }
  };
}

class SetList extends CanvasRoutineController {
  SetList() {
    println("SetList instantiated");
    Pxxxls r1 = new Pxxxls(canvas1, 100);
    SineColumns r2 = new SineColumns(canvas2);

    setCanvas(canvas1, r1);
    //setActiveCanvas(0);
    wait(0.25);
    setCanvas(canvas1, r2);
    wait(2.0);
  }
}



