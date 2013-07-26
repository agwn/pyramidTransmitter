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
  color pornjPink = color(252, 23, 218);
  color orange = color(255, 128, 0);

  SineColumns() {
    initSineTable();
  }

  void setCanvas(Canvas canvas_) {
    super.setCanvas(canvas_);
    bias = pg.height - 15;
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

    pg.noStroke();
    pg.rect(0, 0, canvas.w, canvas.h);
    pg.popStyle();
    pg.endDraw();
    renderCanvas();
  }

  void drawSine(float bias, float amp) {
    pg.beginShape();
    float drawPhase = phase;

    for (int i = -resolution; i <= canvas.w + resolution * 2; i = i + resolution) {
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

