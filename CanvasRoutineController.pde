class CanvasRoutineController {
  ArrayList werd;
  int index = 0;

  CanvasRoutineController() {
    werd = new ArrayList();
  }

  void programIt() { }  

  void update() {
    // Draw all active canvases

    doWerd();
  }

  void setCanvas(Canvas c, CanvasRoutine cr) {
    werd.add(new WCSetCanvas(c, cr));
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
        doSetCanvas();
        break;
      case WC_WAIT:
        println("WC_WAIT");
        doWait(wc);
        break;
      default:
        println("Unrecognized werd code. Werd!");
    }
  }

  private void doSetCanvas() {
    println("doSetCanvas()  index: " + index);
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



