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
  FullCanvas c;
  int sineTableSize = 256;
  float[] sineTable;
  float phase = 0.0;
  float rate = 2.0 / sineTableSize;
  float period = 1.5 / sineTableSize;
  float bias;
  float amplitude;
  color pornjPink = color(252, 23, 218);
  color orange = color(255, 128, 0);

  SineColumns(Canvas canvas_) {
    setCanvas(canvas_);
    initSineTable();
    bias = pg.height - 15;
    amplitude = 15;
  }

  void draw() {
    pg.beginDraw();
    pg.pushStyle();

    // Clear
    pg.fill(0);
    pg.noStroke();
    pg.rect(0, 0, pg.width, pg.height);

    // Sine
    pg.strokeWeight(4);

    pg.stroke(pornjPink, 128);
    drawSine(pg.height + 15, 45);
    drawSine(pg.height - 45, 45);
    drawSine(pg.height - 105, 45);
    drawSine(pg.height - 165, 45);
    drawSine(pg.height - 225, 45);

    pg.stroke(orange, 128);
    drawSine(pg.height - 15, 15);
    drawSine(pg.height - 75, 15);
    drawSine(pg.height - 135, 15);
    drawSine(pg.height - 195, 15);

    phase += rate;

    if (phase >= 1.0) {
      phase -= 1.0;
    }

    pg.popStyle();
    pg.endDraw();
    renderCanvas();
  }

  void drawSine(float bias, float amp) {
    pg.beginShape(LINES);
    float drawPhase = phase;

    for (int i = 0; i < pg.width; i++) {
      pg.vertex(i, bias + sineTable[(int) (drawPhase * sineTableSize)] * amp);

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
    float lengthInv = 1.0 / (float) sineTableSize;

    for (int i = 0; i < sineTableSize; i++) {
      sineTable[i] = sin(i * lengthInv * TWO_PI);
    }
  }
}

