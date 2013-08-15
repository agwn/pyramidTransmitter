class TutorialNoisePlayer extends SetList {
  TutorialNoisePlayer() { }

  TutorialNoisePlayer(SetList setList) {
    super(setList);
  }

  void setup() {
    TutorialNoise noise = new TutorialNoise();
    noise.nPixels = 100;

    setCanvas(canvas2, noise);
    wait(5.0);
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
  TutMovingLinesSet() { }

  TutMovingLinesSet(SetList setList) {
    super(setList);
  }

  void setup() {
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

/*-----------------------------------------------------------------------*/

class TutorialSimpleSequence extends SetList {
  TutorialSimpleSequence() { }

  TutorialSimpleSequence(SetList setList) {
    super(setList);
  }

  void setup() {
    TutorialNoise noise = new TutorialNoise();
    TutMovingLines movingLines = new TutMovingLines();
    Warp warp = new Warp();

    noise.nPixels = 50;

    // Part I - Mixing
    setCanvas(canvas2, noise);
    wait(5.0);
    setCanvas(canvas3, movingLines);
    wait(5.0);
    disableCanvas(canvas2);
    wait(5.0);
    disableCanvas(canvas3);
    wait(5.0);

    // Part II - Crossfading
    setCanvas(canvas2, noise);
    wait(5.0);
    setCanvas(canvas3, movingLines);
    crossfade(5.0, canvas2, canvas3);
    wait(5.0);
    disableCanvas(canvas3);
    wait(5.0);

    // Part III - Routine Chaining
    setCanvas(canvas2, noise);
    wait(5.0);
    pushCanvas(canvas2, movingLines);
    wait(5.0);
    pushCanvas(canvas2, warp);
    wait(5.0);
    disableCanvas(canvas2);
    wait(5.0);
  }
}
