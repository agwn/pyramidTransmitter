class Warp extends CanvasRoutine {
  float r;
  float rofs;
  float warpSpeed;
  boolean warpHorizontal;
  boolean warpVertical;
  float warpFactor;
  int w;
  int h;
  PImage temp;

  public Warp() {
    warpHorizontal = true;
    warpVertical = true;
    warpSpeed = 0.1;
    warpFactor = 0.5;
    setPaintMode(OVERWRITE);
  }

/*
  public Warp(Routine subroutine, boolean warpHorizontal, boolean warpVertical, float warpSpeed, float warpFactor) {
    this.subroutine = subroutine;
    this.warpHorizontal = warpHorizontal;
    this.warpVertical = warpVertical;
    this.warpSpeed = warpSpeed;
    this.warpFactor = warpFactor;
  }
*/

  void reinit() {
    w = pg.width;
    h = pg.height;
    temp = pgFlat.get();
  }

  void hshift(int y, int xofs) {
    if (xofs < 0)
      xofs = w + xofs;

    PImage tmp = pgFlat.get(w-xofs, y, xofs, 1);
    pg.copy(0, y, w-xofs, 1, xofs, y, w-xofs, 1);
    pg.image(tmp, 0, y);
  }

  void vshift(int x, int yofs) {
    if (yofs < 0)
      yofs = h + yofs;

    PImage tmp = pgFlat.get(x, h-yofs, 1, yofs);
    pg.copy(x, 0, 1, h-yofs, x, yofs, 1, h-yofs);
    pg.image(tmp, x, 0);
  }

  void drawBackground() {
    pg.background(0);
    pg.noFill();
    pg.ellipseMode(RADIUS);
    for (int i=0; i<10; i++) {
      pg.stroke(i%2==0 ? color(varMin[0], varMin[1], varMin[2]) : color(varMax[0], varMax[1], varMax[2]));
      pg.ellipse(w/2, h/2, i*(w/10), i*(h/10));
    }
  }

  void draw() {
    //drawBackground();
    pg.background(0);
    if (warpVertical) {
      for (int x=0; x<w; x++) {
        r = x*1.0/h*PI + rofs;
        vshift(x, int(sin(r)*(h*warpFactor)));
      }

      rofs += 0.0314 * warpSpeed;
    }

    if (warpHorizontal) {
      for (int y=0; y<h; y++) {
        r = y*1.0/w*PI + rofs;
        hshift(y, int(sin(r)*(w*warpFactor)));
      }

      rofs += 0.0314 * warpSpeed;
    }
  }
}
