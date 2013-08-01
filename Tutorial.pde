class TutorialPlayer extends CanvasRoutineController {
  TutorialPlayer() {
    TutorialNoise tutorialNoise = new TutorialNoise();

    setCanvas(canvases[2], tutorialNoise);
    wait(30.0);
  }
}

class TutorialNoise extends CanvasRoutine {
  int nPixels = 100;
  int w;
  int h;

  void reinit() {
    w = pg.width;
    h = pg.height;
  }

  void draw() {
    pg.beginDraw();
    pg.background(0);

    for (int i = 0; i < nPixels; i++) {
      pg.stroke(random(255));
      pg.point(random(w), random(h));
    }

    pg.endDraw();
  }
}
