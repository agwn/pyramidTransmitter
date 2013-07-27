class CanvasRoutine {
  Canvas canvas;
  PGraphics pg;
  PGraphics pgFlat;
  Boolean blendLayers = true;

  CanvasRoutine() { }
  void reinit() { }
  void draw() { }

  void setCanvas(Canvas canvas_) {
    canvas = canvas_;
    pg = canvas.pg;
    pgFlat = canvas.pgFlat;
    reinit();
  }
}

