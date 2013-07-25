final int WC_SET_CANVAS = 0;
final int WC_WAIT = 1;
final int WC_DO_NOTHING = 2;

class WerdCode {
  int ID = -1;
  int nParams = 0;
  ArrayList params;

  WerdCode() { }
}

class WCSetCanvas extends WerdCode {
  int nParams = 2;

  WCSetCanvas(Canvas canvas, CanvasRoutine canvasRoutine) {
    ID = WC_SET_CANVAS;

    params = new ArrayList();
    params.add(canvas);
    params.add(canvasRoutine);
  }
}

class WCWait extends WerdCode {
  int frames;
  int frameCounter;
  boolean isInitialized = false;

  WCWait(int frames_) {
    ID = WC_WAIT;
    frames = frames_;
  }

  void init() {
    isInitialized = true;
    frameCounter = frames;
  }

  void finish() {
    isInitialized = false;
  }
}

class WCDoNothing extends WerdCode {
  WCDoNothing() {
    ID = WC_DO_NOTHING;
  }
}

