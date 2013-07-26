/*

  .........  ..  .........  ........  .........  ..  ........  .........  ..........
  .......... .. .......... .......... .......... .. .......... .......... ..........
  ..      ..    ..         ..      .. ..      ..    ..      .. ..      ..     ..
  ..      .. .. .........  ..      .. ..      .. .. .......... ..      ..     ..
  ..      .. ..  ......... ..      .. .........  .. .......... ..      ..     ..
  ..      .. ..         .. ..      .. .........  .. ..         ..      ..     ..
  .......... .. .......... .......... ..     ... .. .........  ..      ..     ..
  .........  .. .........   ........  ..      .. ..  ........  ..      ..     ..

  .........  ..  .........
  .......... ... ..........               /]    /]
  ..      ..  ..         ..               /]    /]
  ..      ..  ..   ........           /]  /]    /]  /]
  ..      ..  ..   ........           /]  /]    /]  /]
  ..      ..  ..         ..       /]  /]  /]    /]  /]  /]
  ..........  .. ..........       /]  /]  /]    /]  /]  /]
  .........   .. .........    /]  /]  /]  /]    /]  /]  /]  /]

*/


class SineColumns extends CanvasRoutine {
  int resolution = 16;  // Higher value = lower resolution
  int sineTableSize = 256;
  float sineTableSizeInv = 1.0 / sineTableSize;
  float[] sineTable;
  float phase = 0.0;
  float rate = 2.0 * sineTableSizeInv;
  float period = 1.0 * sineTableSizeInv * resolution;
  float bias;
  float amplitude;
  int w;
  int h;
  color pornjPink = color(252, 23, 218);
  color orange = color(255, 128, 0);

  SineColumns() {
    initSineTable();
  }

  void reinit() {
    w = pg.width;
    h = pg.height;
    bias = h - 15;
    amplitude = 15;
  }

  void draw() {
    pg.beginDraw();
    pg.background(0);
    pg.pushStyle();

    // Sine
    pg.noFill();
    pg.strokeWeight(4);

    pg.stroke(pornjPink, 128);
    drawSine(h + 15, 45);
    drawSine(h - 45, 45);
    drawSine(h - 105, 45);
    drawSine(h - 165, 45);
    drawSine(h - 225, 45);

    pg.stroke(orange, 128);
    drawSine(h - 15, 15);
    drawSine(h - 75, 15);
    drawSine(h - 135, 15);
    drawSine(h - 195, 15);

    phase += rate;

    if (phase >= 1.0) {
      phase -= 1.0;
    }

    pg.noStroke();
    pg.rect(0, 0, w, h);
    pg.popStyle();
    pg.endDraw();
  }

  void drawSine(float bias, float amp) {
    pg.beginShape();
    float drawPhase = phase;

    for (int i = -resolution; i <= w + resolution * 2; i = i + resolution) {
      pg.curveVertex(i, bias + sineTable[(int) (drawPhase * sineTableSize)] * amp);

      drawPhase += period;
      while (drawPhase >= 1.0) {
        drawPhase -= 1.0;
      }
      while (drawPhase < 0.0) {
        drawPhase += 1.0;
      }
    }

    pg.endShape();
  }

  void initSineTable() {
    sineTable = new float[sineTableSize];

    for (int i = 0; i < sineTableSize; i++) {
      sineTable[i] = sin(i * sineTableSizeInv * TWO_PI);
    }
  }
}
