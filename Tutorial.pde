class TutorialNoisePlayer extends SetList {
  TutorialNoisePlayer() {
    TutorialNoise noise = new TutorialNoise();
    noise.nPixels = 100;

    setCanvas(canvas2, noise);
  }
}

class TutorialNoise extends CanvasRoutine {
  int nPixels = 1;

  void draw() {
    pg.beginDraw();

    // Set background to black
    pg.background(0);

    // Draw pixels
    pg.stroke(255);

    for (int i = 0; i < nPixels; i++) {
      pg.point(random(pg.width), random(pg.height));
    }

    pg.endDraw();
  }
}

/*-----------------------------------------------------------------------*/

class TutMovingLinesSet extends SetList {
  TutMovingLinesSet() {
    TutMovingLines rl = new TutMovingLines();

    setCanvas(canvas2, rl);
  }
}

class TutMovingLines extends CanvasRoutine {
  int xPos = 0;
  int yPos = 0;

  void draw() {
    pg.beginDraw();

    // Set background to black
    pg.background(0);

    // Draw lines
    pg.stroke(255);
    pg.line(0, xPos, pg.width, xPos);
    pg.line(yPos, 0, yPos, pg.height);

    // Update positions
    xPos++;
    if (xPos >= pg.height) {
      xPos = 0;
    }

    yPos++;
    if (yPos >= pg.width) {
      yPos = 0;
    }

    pg.endDraw();
  }
}
