// Got something backwards.
// Canvas should have member CanvasRoutine,
// not CanvasRoutine having a Canvas.

class CanvasRoutine extends Routine {
  Canvas canvas;
  PGraphics pg;
  PGraphics pgFlat;

  CanvasRoutine() { }
  void reinit() { }

  void setCanvas(Canvas canvas_) {
    canvas = canvas_;
    pg = canvas.pg;
    pgFlat = canvas.pgFlat;
    reinit();
  }
}
