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

/*
  TUTORIAL TIP - Drawing to the correct canvas

  In most situations, creating a pattern generator is similar to creating
  a normal Processing sketch with two differences:

  1) The destination of the drawing is a PGraphic, which is inherited
  from class SetList/CanvasRoutineController (see CanvasRoutineController.pde).
  Instead of using a drawing function such as:

    line(0, 0, 50, 50)

  You would write it to member "pg" like this:

    pg.line(0, 0, 50, 50);

  2) You should begin end and all drawing with pg.beginDraw() and
  pg.endDraw().

  That's the very basics.
*/

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

class TutMovingLineSet extends SetList {
  TutMovingLineSet() {
    TutMovingLine rl = new TutMovingLine();

    setCanvas(canvas2, rl);
  }
}

class TutMovingLine extends CanvasRoutine {
  int position = 0;

  void draw() {
    pg.beginDraw();

    // Set background to black
    pg.background(0);

    // Draw line
    pg.stroke(255);
    pg.line(0, position, pg.width, position);

    // Update positionition;
    position++;
    if (position >= pg.height) {
      position = 0;
    }

    pg.endDraw();
  }
}
