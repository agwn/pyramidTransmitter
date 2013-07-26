// Got something backwards.
// Canvas should have member CanvasRoutine,
// not CanvasRoutine having a Canvas.

class CanvasRoutine extends Routine {
  Canvas canvas;
  PGraphics pg;

  CanvasRoutine() { }
  void reinit() { }

  void setCanvas(Canvas canvas_) {
    canvas = canvas_;
    pg = canvas.pg;
    reinit();
  }

  void renderCanvas() {
    image(pg, canvas.x, canvas.y);
  }
}
