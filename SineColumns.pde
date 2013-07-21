/*

  ~~~~~~~~~  ~~  ~~~~~~~~~  ~~~~~~~~  ~~~~~~~~~  ~~  ~~~~~~~~  ~~~~~~~~~  ~~~~~~~~~~
  ~~~~~~~~~~ ~~ ~~~~~~~~~~ ~~~~~~~~~~ ~~~~~~~~~~ ~~ ~~~~~~~~~~ ~~~~~~~~~~ ~~~~~~~~~~
  ~~      ~~    ~~         ~~      ~~ ~~      ~~    ~~      ~~ ~~      ~~     ~~
  ~~      ~~ ~~ ~~~~~~~~~  ~~      ~~ ~~      ~~ ~~ ~~~~~~~~~~ ~~      ~~     ~~
  ~~      ~~ ~~  ~~~~~~~~~ ~~      ~~ ~~~~~~~~~  ~~ ~~~~~~~~~~ ~~      ~~     ~~
  ~~      ~~ ~~         ~~ ~~      ~~ ~~~~~~~~~  ~~ ~~         ~~      ~~     ~~
  ~~~~~~~~~~ ~~ ~~~~~~~~~~ ~~~~~~~~~~ ~~     ~~~ ~~ ~~~~~~~~~  ~~      ~~     ~~
  ~~~~~~~~~  ~~ ~~~~~~~~~   ~~~~~~~~  ~~      ~~ ~~  ~~~~~~~~  ~~      ~~     ~~

  ~~~~~~~~~  ~~  ~~~~~~~~~
  ~~~~~~~~~~ ~~~ ~~~~~~~~~~         |  |
  ~~      ~~  ~~         ~~         |  |
  ~~      ~~  ~~   ~~~~~~~~       | |  | |
  ~~      ~~  ~~   ~~~~~~~~       | |  | |
  ~~      ~~  ~~         ~~     | | |  | | |
  ~~~~~~~~~~  ~~ ~~~~~~~~~~     | | |  | | | 
  ~~~~~~~~~   ~~ ~~~~~~~~~    | | | |  | | | |

*/


class SineColumns extends Routine {
  FullCanvas c;
  int sineTableSize = 128;
  float[] sineTable;
  float phase = 0.0;
  float inc = 0.01;

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

/*
    // Sanity line
    c.line(0, c.height, c.width, 0);
*/

    c.stroke(255);
    c.strokeWeight(4);
    float amplitude = c.height / 2.0;

    c.beginShape(LINES);
    for (int i = 0; i < c.width; i++) {
      int realPhase = (int) ((float) (i % sineTableSize) + phase * (float) sineTableSize);
      if (realPhase >= sineTableSize) {
        realPhase -= sineTableSize;
      }
      c.vertex(i, amplitude + sineTable[realPhase] * amplitude);

    }
    phase += inc;
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

