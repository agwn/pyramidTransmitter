class Warp extends Routine {
  float r;
  float rofs;
  float warpSpeed;
  Routine subroutine;
  boolean warpHorizontal;
  boolean warpVertical;
  float warpFactor;

  public Warp() {
    this.subroutine = null;
    warpHorizontal = false;
    warpVertical = true;
    warpSpeed = 2;
    warpFactor = 1;
  }

  public Warp(Routine subroutine, boolean warpHorizontal, boolean warpVertical, float warpSpeed, float warpFactor) {
    this.subroutine = subroutine;
    this.warpHorizontal = warpHorizontal;
    this.warpVertical = warpVertical;
    this.warpSpeed = warpSpeed;
    this.warpFactor = warpFactor;
  }

  void setup(PApplet parent) {
    super.setup(parent);

    if (this.subroutine != null) {
      this.subroutine.setup(parent);
    }
  }

  void hshift(int y, int xofs) {
    if (xofs < 0)
      xofs = displayWidth + xofs;

    PImage tmp = get(displayWidth-xofs, y, xofs, 1);
    copy(0, y, displayWidth-xofs, 1, xofs, y, displayWidth-xofs, 1);
    image(tmp, 0, y);
  }

  void vshift(int x, int yofs) {
    if (yofs < 0)
      yofs = displayHeight + yofs;

    PImage tmp = get(x, displayHeight-yofs, 1, yofs);
    copy(x, 0, 1, displayHeight-yofs, x, yofs, 1, displayHeight-yofs);
    image(tmp, x, 0);
  }

  void drawBackground() {
    if (subroutine != null) {
      subroutine.draw();

      if (subroutine.isDone) {
        newMode();
      }
    }
    else {
      background(0);
      noFill();
      ellipseMode(RADIUS);
      for (int i=0; i<10; i++) {
        stroke(i%2==0 ? color(varMin[0], varMin[1], varMin[2]) : color(varMax[0], varMax[1], varMax[2]));
        ellipse(displayWidth/2, displayHeight/2, i*(displayWidth/10), i*(displayHeight/10));
      }
    }
  }

  void draw() {
    drawBackground();

    if (warpVertical) {
      for (int x=0; x<displayWidth; x++) {
        r = x*1.0/displayHeight*PI + rofs;
        vshift(x, int(sin(r)*(displayHeight*warpFactor)));
      }

      rofs += 0.0314 * warpSpeed;
    }

    if (warpHorizontal) {
      for (int y=0; y<displayHeight; y++) {
        r = y*1.0/displayWidth*PI + rofs;
        hshift(y, int(sin(r)*(displayWidth*warpFactor)));
      }

      rofs += 0.0314 * warpSpeed;
    }
  }
}

