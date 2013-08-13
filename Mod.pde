class ModEvent {
  CanvasRoutineController controller;
  // Passive, so doesn't need to pass info to the controller?
  // Wrong a bit.
  // Needs to pass to controller when to pull itself from the ModEvent list.

  void ModEvent() { }
  void run() { }
}


class ModLine extends ModEvent {
  float duration;
  float frameCounter;
  int frames;
  boolean isInitialized = false;
  ModFloat modFloat;
  float startValue;
  float endValue;
  float change;

  ModLine(CanvasRoutineController controller_, ModFloat modFloat_, int frames_, float startValue_, float endValue_) {
    controller = controller_;
    frames = frames_;
    startValue = startValue_;
    endValue = endValue_;
    modFloat = modFloat_;
  }

  void run() {
    if (!isInitialized) {
      init();
    }

    if (frameCounter <= 0) {
      end();
      controller.removeModEvent(this);
    }

    modFloat.set(modFloat.get() - change);
    frameCounter--;
  }

  void init() {
    isInitialized = true;
    frameCounter = frames;
    modFloat.set(startValue);
    change = (startValue - endValue) / frames;
  }

  void end() {
    isInitialized = false;
    modFloat.set(endValue);
  }
}


class ModFloat {
  private float value;

  ModFloat(float value_) {
    value = value_;
  }

  void set(float value_) {
    value = value_;
  }

  float get() {
    return value;
  }
}

class ModColor {
  private color c;

  ModColor(color c_) {
    c = c_;
  }

  void set(color c_) {
    c = c_;
  }

  color get() {
    return c;
  }
}

