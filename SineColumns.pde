/*
  .........  ..  .........  ........  .........  ..  .........  .........  ..........
  .......... .. .......... .......... .......... ... .......... .......... ..........
  ..      ..    ..         ..      .. ..      ..  ..         .. ..      ..     ..
  ..      .. .. .........  ..      .. ..      ..  .. .......... ..      ..     ..
  ..      .. ..  ......... ..      .. .........   .. .......... ..      ..     ..
  ..      .. ..         .. ..      .. .........   ..         .. ..      ..     ..
  .......... .. .......... .......... ..     ...  .. .......... ..      ..     ..
  .........  .. .........   ........  ..      ..  .. ........   ..      ..     ..
*/


class SineColumns extends CanvasRoutine {
  int resolution = 1;  // Higher value = lower resolution
  float phase = 0.0;
  float strokeWeight0 = 4;
  float strokeWeight1 = 4;
  color c0 = color(pornj, 128);
  color c1 = color(disorientOrange, 128);
  float freq = 1.0;
  float nCycles = 1.0;
  private float bias;
  private float amp;
  private int w;
  private int h;

  SineColumns() {
    setPaintMode(DIRECT);
  }

  void reinit() {
    w = pg.width;
    h = pg.height;
    bias = h - 15;
    amp = 15;
  }

  void draw() {
    pg.beginDraw();
    pg.pushStyle();
    pg.background(0);
    pg.noFill();

    pg.strokeWeight(strokeWeight0);
    pg.stroke(c0);
    drawSine(h + 15, 45);
    drawSine(h - 45, 45);
    drawSine(h - 105, 45);
    drawSine(h - 165, 45);
    drawSine(h - 225, 45);

    pg.strokeWeight(strokeWeight1);
    pg.stroke(c1);
    drawSine(h - 15, 15);
    drawSine(h - 75, 15);
    drawSine(h - 135, 15);
    drawSine(h - 195, 15);

    phase += freq / FRAMERATE;
    while (phase >= 1.0) {
      phase -= 1.0;
    }
    while (phase < 0.0) {
      phase += 1.0;
    }

    pg.popStyle();
    pg.endDraw();
  }

  void drawSine(float bias, float amp) {
    pg.beginShape();
    float drawPhase = phase;
    float drawPhaseInc = nCycles / ((float) w / resolution);

    for (int i = -resolution; i <= w + resolution * 2; i = i + resolution) {
      pg.curveVertex(i, bias + sineTable[(int) (drawPhase * sineTableSize)] * amp);

      drawPhase += drawPhaseInc;
      while (drawPhase >= 1.0) {
        drawPhase -= 1.0;
      }
      while (drawPhase < 0.0) {
        drawPhase += 1.0;
      }
    }

    pg.endShape();
  }
}
