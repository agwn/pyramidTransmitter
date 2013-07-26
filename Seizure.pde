class Seizure extends CanvasRoutine {
  int brightness = 0;

  void draw() {
    pg.beginDraw();
    pg.background(brightness);
    brightness = 255 - brightness;
    pg.endDraw();
  }
}
