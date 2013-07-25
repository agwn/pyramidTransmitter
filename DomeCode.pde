final int DOME_SET_CANVAS = 0;
final int DOME_WAIT       = 1;
final int DOME_DO_NOTHING = 2;
final int DOME_CROSSFADE  = 3;

class DomeCode {
  int ID = -1;
  int nParams = 0;
  ArrayList params;

  DomeCode() { }
}

class DomeSetCanvas extends DomeCode {
  int nParams = 2;

  DomeSetCanvas(Canvas canvas, CanvasRoutine canvasRoutine) {
    ID = DOME_SET_CANVAS;

    params = new ArrayList();
    params.add(canvas);
    params.add(canvasRoutine);
  }
}

class DomeWait extends DomeCode {
  int frames;
  int frameCounter;
  boolean isInitialized = false;

  DomeWait(int frames_) {
    ID = DOME_WAIT;
    frames = frames_;
  }

  void init() {
    isInitialized = true;
    frameCounter = frames;
  }

  void end() {
    isInitialized = false;
  }
}

class DomeCrossfade extends DomeCode {
  Canvas c0;
  Canvas c1;
  int frames;
  float framesInv;
  int frameCounter;
  boolean isInitialized = false;

  DomeCrossfade(int frames_, Canvas c0_, Canvas c1_) {
    ID = DOME_CROSSFADE;
    frames = frames_;
    framesInv = 1.0 / frames;
    c0 = c0_;
    c1 = c1_;
  }

  void init() {
    isInitialized = true;
    frameCounter = frames;
  }

  void end() {
    isInitialized = false;
  }
}

class DomeDoNothing extends DomeCode {
  DomeDoNothing() {
    ID = DOME_DO_NOTHING;
  }
}

