final int DOME_SET_CANVAS = 0;
final int DOME_WAIT = 1;
final int DOME_DO_NOTHING = 2;

class DomeCode {
  int ID = -1;
  int nParams = 0;
  ArrayList params;

  DomeCode() { }
}

class DOMESetCanvas extends DomeCode {
  int nParams = 2;

  DOMESetCanvas(Canvas canvas, CanvasRoutine canvasRoutine) {
    ID = DOME_SET_CANVAS;

    params = new ArrayList();
    params.add(canvas);
    params.add(canvasRoutine);
  }
}

class DOMEWait extends DomeCode {
  int frames;
  int frameCounter;
  boolean isInitialized = false;

  DOMEWait(int frames_) {
    ID = DOME_WAIT;
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

class DOMEDoNothing extends DomeCode {
  DOMEDoNothing() {
    ID = DOME_DO_NOTHING;
  }
}

