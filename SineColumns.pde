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
  int sineTableSize = 128;
  float[] sineTable;
  float phase = 0.0;
  float rate = 2.0 / sineTableSize;
  float period = 0.25 / sineTableSize;
  SineColumns(FullCanvas fullCanvas) {
    c = fullCanvas;
    initSineTable();
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
    c.stroke(255);
    c.strokeWeight(4);
    float amplitude = c.height / 2.0;
    c.beginShape(LINES);
    float drawPhase = phase;

    for (int i = 0; i < c.width; i++) {
      c.vertex(i, amplitude + sineTable[(int) (drawPhase * sineTableSize)] * amplitude);

      drawPhase += period;
      while (drawPhase >= 1.0) {
        drawPhase -= 1.0;
      }
      while (drawPhase < 0.0) {
        drawPhase += 1.0;
      }
    }

    phase += rate;

    if (phase >= 1.0) {
      phase -= 1.0;
    }

    c.endShape();
    c.popStyle(); 
  }

  void initSineTable() {
    sineTable = new float[sineTableSize];
    float lengthInv = 1.0 / (float) sineTableSize;

    for (int i = 0; i < sineTableSize; i++) {
      sineTable[i] = sin(i * lengthInv * TWO_PI);
    }
  }
}

