class Routine {
  PApplet parent;
  public boolean isDone = false;

  void setup(PApplet parent) {
    this.parent = parent;
  }

  void reset() {
  }
  void draw() {
  }
  void newmode() {
    isDone = true;
  }
}

