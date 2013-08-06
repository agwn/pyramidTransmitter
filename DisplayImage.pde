class DisplayImage extends CanvasRoutine {
  PImage img;
  int x;
  int y;
  int orientation = 0;
  color c = color(255);
  int xPad = 0;
  int yPad = 0;
  boolean doRotate = false;
  boolean xFlip = false;
  boolean yFlip = false;
  int w;
  int h;

  DisplayImage() { }

  DisplayImage(PImage img_) {
    img = img_;
  }

  void reinit() {
    w = pg.width;
    h = pg.height;
  }

  void draw() {
    pg.beginDraw();
    pg.background(0);
    pg.copy(img, 0, 0, img.width, img.height, x, y, img.width, img.height); 
    pg.endDraw();
  }
}

class ScrollImage extends DisplayImage {
  int xSpeed = 0;
  int ySpeed = 0;
  int yLimitBottom;
  int yLimitTop;

  ScrollImage() { }

  ScrollImage(PImage img_) {
    super(img_);
  }

  void reinit() {
    super.reinit();
    yLimitBottom = h;
    yLimitTop = 0;
  }

  void draw() {
    pg.beginDraw();
    pg.background(0);
    pg.copy(img, 0, 0, img.width, img.height, x, y, img.width, img.height); 

    x += xSpeed;
    if (x >= w) {
      x = -img.width;
    }
    if (x < -img.width) {
      x = w - 1;
    }

    y += ySpeed;
    if (y >= yLimitBottom) {
      y = -img.height + yLimitTop;
    }
    if (y < -img.height + yLimitTop) {
      y = yLimitBottom - 1;
    }

    pg.endDraw();
  }
}
