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
    WCSetCanvas wc = (WCSetCanvas) werd.get(0); 
    CanvasRoutine cr = (CanvasRoutine) wc.params.get(1);

    if (activeCanvases[0]) {
      canvas1.cr.draw();
    }
    if (activeCanvases[1]) {
      canvas2.cr.draw();
    }

    doWerd();
  }

  void setCanvas(Canvas c, CanvasRoutine cr) {
    werd.add(new WCSetCanvas(c, cr));
    if (c == canvas1) {
      activeCanvases[0] = true;
    }
    if (c == canvas2) {
      activeCanvases[1] = true;
    }
  }

  void wait(float seconds) {
    int waitFrameCounter = (int) (seconds * FRAMERATE);
    werd.add(new WCWait(waitFrameCounter));
  }

  private void next() {
    index++;

    if (index >= werd.size()) {
      index = 0;

      // if is child, return to parent
      // else index = 0
    }
  }

  void doWerd() {
    WerdCode wc = (WerdCode) werd.get(index);
    int ID = wc.ID;

    switch(ID) {
      case WC_SET_CANVAS:
        println("WC_SET_CANVAS");
        doSetCanvas(wc);
        break;
      case WC_WAIT:
        println("WC_WAIT");
        doWait(wc);
        break;
      default:
        println("Unrecognized werd code. Werd!");
    }
  }

  private void doSetCanvas(WerdCode wc_) {
    WCSetCanvas wc = (WCSetCanvas) wc_;
    println("doSetCanvas()  index: " + index);
    Canvas c = (Canvas) wc.params.get(0);
    CanvasRoutine rc = (CanvasRoutine) wc.params.get(1); 

    if (c == canvas1) {
      c.cr = rc;
    } 


    next();
    doWerd();
  };

  private void doWait(WerdCode wc_) {
    WCWait wc = (WCWait) wc_;

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



