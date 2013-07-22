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


class SineColumns extends Routine {
  FullCanvas c;
  int sineTableSize = 256;
  float[] sineTable;
  float phase = 0.0;
  float rate = 2.0 / sineTableSize;
  float period = 1.5 / sineTableSize;
  float bias;
  float amplitude;
  color pornj = color(252, 23, 218);
  color orange = color(255, 128, 0);

  SineColumns(FullCanvas fullCanvas) {
    c = fullCanvas;
    initSineTable();
    bias = c.height - 15;
    amplitude = 15;
  }

  void draw() {
    c.pushStyle();

    // Clear
    c.fill(0);
    c.noStroke();
    c.rect(0, 0, c.width, c.height);

    // Sanity line
    c.stroke(64, 0, 0);
    c.line(0, c.height, c.width, 0);

    // Sine
    c.strokeWeight(4);

    c.stroke(pornj, 128);
    drawSine(c.height + 15, 45);
    drawSine(c.height - 45, 45);
    drawSine(c.height - 105, 45);
    drawSine(c.height - 165, 45);
    drawSine(c.height - 225, 45);

    c.stroke(orange, 128);
    drawSine(c.height - 15, 15);
    drawSine(c.height - 75, 15);
    drawSine(c.height - 135, 15);
    drawSine(c.height - 195, 15);

    phase += rate;

    if (phase >= 1.0) {
      phase -= 1.0;
    }

    c.popStyle(); 
  }

  void drawSine(float bias, float amp) {
    c.beginShape(LINES);
    float drawPhase = phase;

    for (int i = 0; i < c.width; i++) {
      c.vertex(i, bias + sineTable[(int) (drawPhase * sineTableSize)] * amp);

      drawPhase += period;
      while (drawPhase >= 1.0) {
        drawPhase -= 1.0;
      }
      while (drawPhase < 0.0) {
        drawPhase += 1.0;
      }
    }

    c.endShape();
  }

  void initSineTable() {
    sineTable = new float[sineTableSize];
    float lengthInv = 1.0 / (float) sineTableSize;

    for (int i = 0; i < sineTableSize; i++) {
      sineTable[i] = sin(i * lengthInv * TWO_PI);
    }
  }
}

