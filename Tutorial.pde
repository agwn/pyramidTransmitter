class TutorialNoisePlayer extends CanvasRoutineController {
  TutorialNoisePlayer() {
    TutorialNoise noise = new TutorialNoise();
    noise.nPixels = 100;

    setCanvas(canvases[2], noise);
  }
}

class TutorialNoise extends CanvasRoutine {
  int nPixels = 1;

  void draw() {
    pg.beginDraw();
    pg.background(0);
    pg.stroke(255);

    for (int i = 0; i < nPixels; i++) {
      pg.point(random(pg.width), random(pg.height));
    }

    pg.endDraw();
  }
}
