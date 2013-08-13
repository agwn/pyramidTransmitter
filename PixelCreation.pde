class PixelCreation extends CanvasRoutine {
  int x = 0;
  int y = 0;
  int xPad = 0;
  int yPad = 0;
  int pointsPerFrame = 1;
  int frames = FRAMERATE;
  color cStart = color(255, 0);
  color cEnd = color(255);
  float verticalToHorizontalRatio = 1.0;
  private ArrayList<BitPoint> bitPoints;
  private ArrayList<BitPoint> visible;
  private ArrayList<PixelCreationAnimation> animations;
  private ArrayList<PixelCreationAnimation> animationGarbage;
  private int w;
  private int h;

  PixelCreation(ArrayList<BitPoint> bitPoints_) {
    bitPoints = bitPoints_;
    Collections.shuffle(bitPoints);
  }

  void reinit() {
    w = pg.width;
    h = pg.height;
    visible = new ArrayList<BitPoint>();
    animations = new ArrayList<PixelCreationAnimation>();
    animationGarbage = new ArrayList<PixelCreationAnimation>();
  }

  void draw() {
    pg.beginDraw();
    pg.background(0);

    for (BitPoint bp : visible) {
      pg.stroke(bp.c);
      pg.point(bp.x + x + xPad * bp.x, bp.y + y + yPad * bp.y);
    }

    int vSize = visible.size();
    int bSize = bitPoints.size();
    int counter = pointsPerFrame;

    while (counter > 0 && vSize < bSize) {
      addAnimation(bitPoints.get(vSize));
      counter--;
      vSize++;
    }

    doAnimations();

    pg.endDraw();
  }

  void doAnimations() {
    println(frameCount);
    for (PixelCreationAnimation a : animations) {
      a.run();
    }

    for (PixelCreationAnimation a : animationGarbage) {
      animations.remove(a);
    }

    animationGarbage.clear();
  }

  void addAnimation(BitPoint bp) {
    boolean isVertical = true;

    if (random(1.0) > verticalToHorizontalRatio) {
      isVertical = false;
    } 

    animations.add(new PixelCreationAnimation(this, bp, frames, isVertical, cStart, cEnd));
  }

  void endAnimation(PixelCreationAnimation a) {
    a.bp.c = cEnd;
    visible.add(a.bp);
    animationGarbage.add(a);
  }
}

class PixelCreationAnimation {
  int frameCounter;
  PixelCreation parent;
  BitPoint bp;
  int frames;
  int size = 8;
  boolean isVertical = true;
  color cStart;
  color cEnd;
  PGraphics pg;
 
  PixelCreationAnimation(PixelCreation parent_, BitPoint bp_, int frameCounter_, boolean isVertical_, color cStart_, color cEnd_) {
    parent = parent_;
    bp = bp_;
    frameCounter = frameCounter_;
    frames = frameCounter;
    isVertical = isVertical_;
    cStart = cStart_;
    cEnd = cEnd_;
    pg = parent.pg;
  }

  void run() {
    int thisX = bp.x + parent.x + parent.xPad * bp.x;
    int thisY = bp.y + parent.y + parent.yPad * bp.y;
    float ratio = (float) frameCounter / frames;
    int thisSize = (int) pow(2.0, ratio * size); 

    frameCounter--;

    pg.pushStyle();
    pg.strokeWeight(1);
    pg.stroke(lerpColor(cEnd, cStart, (float) ratio));

    if (isVertical) {
      thisSize /= 2;
      pg.line(thisX, thisY - thisSize, thisX, thisY + thisSize);
    }
    else {
      thisSize /= 6;
      pg.line(thisX - thisSize, thisY, thisX + thisSize, thisY);
    }

    pg.popStyle();

    if (frameCounter <= 0) {
      parent.endAnimation(this); 
    }
  }
}
