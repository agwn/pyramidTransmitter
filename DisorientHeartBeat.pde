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


class DisorientHeartBeat extends CanvasRoutine {
  int HeartCount = 3;
  HeartBeat[] hearts;
  private int w;
  private int h;
  private float SecondsOfOneBeat;
  
  DisorientHeartBeat(int heartCount, float secondsOfOneBeat)
  {
    HeartCount = heartCount;
    SecondsOfOneBeat = secondsOfOneBeat;
  }

  void reinit() {
    w = pg.width;
    h = pg.height;
    float graphHeight = 40; //aspect ratio - higher number means smaller graph 

    if (HeartCount > 0) {
      hearts = new HeartBeat[HeartCount];
      for (int i=0; i<HeartCount; i++) {
        hearts[i] = new HeartBeat(pg, (i+1)*h/(HeartCount+1), SecondsOfOneBeat, (int)(graphHeight*HeartCount));
      }
    }
  }
  
  void draw() {
    pg.beginDraw();
    pg.background(0);
    pg.noFill();

    for (int i=0; i<HeartCount; i++) {
      hearts[i].drawHeartBeatStep();
    }
   
    pg.endDraw();
  }

  class HeartBeat {
    private PGraphics pg;
    private color c0 = color(pornj, 128);
    private int strokeWeight0=2;
    private int w;
    private int h;
  
    float[] heartBeatGraph = {0, 0, 0, 0, 1, 0.1, 0, 0, 2, 10, -4, -0.5, 0, 0, 0, 0, 0.6, 1.5, 0.1, 0, 0, 0 };
    int graphLength = 22;
    float graphWidth = 22;
    float step;
    float x=0;
    float zeroAxis;
    float scaleFactorY;
  
    public HeartBeat(PGraphics graphics, float zeroAxisParam, float secondsOfOneBeat, int graphHeight) {
      pg = graphics;
      w = pg.width;
      h = pg.height;
      zeroAxis = zeroAxisParam;
      scaleFactorY = h / graphHeight;
      step = ((float)graphLength)/(secondsOfOneBeat*FRAMERATE);
    }
  
    void drawHeartBeatStep() {
        pg.strokeWeight(strokeWeight0);
        pg.stroke(c0);

        float scaleFactorX = w  / graphWidth;
  
        int i=(int)(x);
        float y=0;
        if (i < graphLength-1) {
          float x1 = i*.5f;
          float y1 = heartBeatGraph[i];
        
          float x2 = (i+1)*.5f;
          float y2 = heartBeatGraph[i+1];
        
          y = ((y2-y1)/(x2-x1))*(x*.5f-x1) + y1;
        }
        int xp = (int)(x*scaleFactorX);
        int yp = (int)(zeroAxis - y*scaleFactorY);
      
        int radius = 4;
        //pg.ellipse(xp, yp, radius, radius);
        pg.point(xp, yp);
        x = x + step; 
  
        if (i > graphLength) {
          x = 0;
        }
    }
  }
}

class DisorientHeartBeatPresets extends SetList {
  DisorientHeartBeatPresets() {
  }

  DisorientHeartBeatPresets(SetList setList) {
    super(setList);
  }

  void singleBeat(Canvas canvas) {
    DisorientHeartBeat disorientHeartBeat = new DisorientHeartBeat(1, 1);
    Trails trails = new Trails();

    setCanvas(canvas, disorientHeartBeat);
    pushCanvas(canvas, trails);
  }
}
