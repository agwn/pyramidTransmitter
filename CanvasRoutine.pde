final int CANVAS_ROUTINE_DIRECT = 0;
final int CANVAS_ROUTINE_BLEND = 1;
final int CANVAS_ROUTINE_OVERWRITE = 2;

class CanvasRoutine {
  final int DIRECT = CANVAS_ROUTINE_DIRECT;
  final int BLEND = CANVAS_ROUTINE_BLEND;
  final int OVERWRITE = CANVAS_ROUTINE_OVERWRITE;

  Canvas canvas;
  PGraphics pg;
  private int paintMode = BLEND;
  int blendMode = SCREEN;

  CanvasRoutine() { }
  void reinit() { }
  void draw() { }

  void setCanvas(Canvas canvas_) {
    canvas = canvas_;
    setCanvasMode();
    reinit();
  }

  void setPaintMode(int m) {
    paintMode = m;
  }

  int getPaintMode() {
    return paintMode;
  }

  void setBlendMode(int blendMode_) {
    blendMode = blendMode_;
  }

  private void setCanvasMode() {
    switch(paintMode) {
      case BLEND:
        pg = canvas.pg;
        break;
      case OVERWRITE:
        pg = canvas.pg;
        break;
      case DIRECT:
        pg = canvas.pgMaster;
        break;
    }
  }
}

