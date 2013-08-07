class PointPopping extends CanvasRoutine {
  ArrayList<BitPoint> bitPoints;
  ArrayList<BitPoint> visible;
  int x = 0;
  int y = 0;
  int xPad = 0;
  int yPad = 0;
  int w;
  int h;
  int pointsPerFrame = 1;

  PointPopping(ArrayList<BitPoint> bitPoints_) {
    bitPoints = bitPoints_;
    Collections.shuffle(bitPoints);
  }

  void reinit() {
    w = pg.width;
    h = pg.height;
    visible = new ArrayList<BitPoint>();
  }

  void draw() {
    pg.beginDraw();

    int xPadOffset = 0;
    int yPadOffset = 0;

    for (BitPoint bp : visible) {
      pg.stroke(bp.c);
      pg.point(bp.x + x + xPad * bp.x, bp.y + y + yPad * bp.y);
    }

    int vSize = visible.size();
    int bSize = bitPoints.size();
    int counter = pointsPerFrame;

    while (counter > 0 && vSize < bSize) {
      visible.add(bitPoints.get(vSize));
      counter--;
      vSize++;
    }

    pg.endDraw();
  }
}
