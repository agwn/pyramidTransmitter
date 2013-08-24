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

class KochCurvesMany extends CanvasRoutine {
  int CurveCount;
  KochCurve[] curves;
  private int w;
  private int h;
  private float ChangesPerSecond;
  private int maxFractaldepth=7;
  int step;
  int frameId;
  
  KochCurvesMany(int curveCount, float changesPerSecond)
  {
    CurveCount = curveCount;
    ChangesPerSecond = changesPerSecond;
  }

  void reinit() {
    w = pg.width;
    h = pg.height;
    step = 0;
    frameId = 0;

    if (CurveCount > 0) {
      curves = new KochCurve[CurveCount];
      for (int i=0; i<CurveCount; i++) {
        curves[i] = new KochCurve(pg, (i)*w/(CurveCount), h/2, w/CurveCount);
      }
    }
  }
  private color c0 = color(pornj, 128);
  private int strokeWeight0=2;
  
  void draw() {
    if (frameId == 0) {
      pg.beginDraw();
      pg.background(0);
      pg.noFill();

      pg.strokeWeight(strokeWeight0);
      pg.stroke(c0);
      
      for (int i=0; i<CurveCount; i++) {
        curves[i].drawStep(step);
      }
      pg.endDraw();
    }
    
    frameId++;
    if(frameId >= ChangesPerSecond*FRAMERATE) {
        frameId=0;
        step++;
        if (step >= maxFractaldepth) step = 0;
    }
  }
}

class KochCurvesOne extends CanvasRoutine {
  KochCurve oneCurve;
  private int w;
  private int h;
  private float ChangesPerSecond;
  private int maxFractaldepth=7;
  int step;
  int frameId;
  int x;
  int y;
  int len;
  
  KochCurvesOne(float changesPerSecond, int originX, int originY, int fractaLen)
  {
      ChangesPerSecond = changesPerSecond;
      x = originX;
      y = originY;
      len = fractaLen;
  }

  void reinit() {
    w = pg.width;
    h = pg.height;
    step = 0;
    frameId = 0;
    oneCurve = new KochCurve(pg, x, y, len);
    pg.beginDraw();
    pg.background(0);
    pg.endDraw();
  }
  
  private color c0 = color(pornj, 128);
  private int strokeWeight0=2;

  void draw() {
    if (frameId == 0) {
      pg.beginDraw();
      pg.strokeWeight(strokeWeight0);

      if (step > 0) {
        pg.stroke(0);
        oneCurve.drawStep(step-1);
        
      }
      pg.stroke(c0);

      oneCurve.drawStep(step);
      pg.endDraw();
    }
    
    frameId++;
    if(frameId >= ChangesPerSecond*FRAMERATE) {
        frameId=0;
        step++;
        if (step >= maxFractaldepth) step = 0;
    }
  }
}

class KochCurve {
  // Inner class, implements Vector that is set by origin, length and angle
  class Vector {
    float x,y,r, theta;
   
     Vector (float _x, float _y, float _r, float _theta) {
       x = _x; //Origin x
       y = _y; //Origin y
       r = _r; //Length
       theta = _theta; // Angle
     }
     
     float getEndX() { 
       return x + r*cos(theta/57.3);
     }
     
     float getEndY() {
       return y + r*sin(theta/57.3);
     }
  } //Vector
  
  
  private PGraphics pg;
  private int x;
  private int y;
  private int len;
  private int h;
  private int w;
  
  public KochCurve(PGraphics graphics, int originX, int originY, int featureLen) {
    pg = graphics;
    w = pg.width;
    h = pg.height;
    x = originX;
    y = originY;
    len = featureLen;
  }

  void drawVector(Vector v) {
    pg.line(v.x, v.y, v.getEndX(), v.getEndY()); 
  }
  
  // Recursive function that creates a fractal 
  void fractal(Vector v, int N) {
     if (N == 0) {
       drawVector(v); //Draw the current vector
     } else {
       Vector t1 = new Vector(v.x, v.y, v.r/3.0, v.theta);
       Vector t2 = new Vector(t1.getEndX(), t1.getEndY(), v.r/3.0, v.theta + 60.0);
       Vector t3 = new Vector(t2.getEndX(), t2.getEndY(), v.r/3.0,v.theta - 60.0);
       Vector t4 = new Vector(t3.getEndX(), t3.getEndY(), v.r/3.0,v.theta);
       fractal(t1,N-1); //Recurse
       fractal(t2,N-1); //Recurse
       fractal(t3,N-1); //Recurse
       fractal(t4,N-1); //Recurse
     }
  }

  void drawStep(int fractalDepth) {

     Vector seed = new Vector(x, y, len, 0);
     fractal (seed, fractalDepth);
     
     seed = new Vector(x + len, y, len, 180);
     fractal (seed, fractalDepth);
  }
}

class KochCurvesPresets extends SetList {
  KochCurvesPresets() {
  }

  KochCurvesPresets(SetList setList) {
    super(setList);
  }

  void thePreset(Canvas canvas) {
    float changesPerSecond = 1.0;
    int x = 0;
    int y = 200;
    int len = 105;

    for (int i=0; i<5; i++) {
      KochCurvesOne kochCurve1 = new KochCurvesOne(changesPerSecond, x + i*len, y, len);
      pushCanvas(canvas, kochCurve1); 
    }
  }
}
