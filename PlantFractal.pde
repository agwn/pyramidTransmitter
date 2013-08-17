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
class PlantFractal extends CanvasRoutine {
  private int w;
  private int h;
  private color c0 = color(pornj, 128);
  private int strokeWeight0=2;

  int BRANCHES = 4; //Number of branches per line
  int DEPTH = 4; // Recursive depth
  float MIN_ANGLE = 10.0; //Minimum angle for new branch
  float MAX_ANGLE = 15.0; //Maximum angle for new branch
  float MIN_LENGTH = 0.00; //Minimum length of new branch, as a pct of current length
  float MAX_LENGTH = 0.8; //Maximum length of new branch, as a pct of current length

  int SecondsToHold;
  PlantFractal(int secondsToHold)
  {
    SecondsToHold = secondsToHold;
  }
  // Implements a Vector that is set by the origin, length and angle
  class Vector {
    int x, y;
    float r, theta;

    Vector (int _x, int _y, float _r, float _theta) {
      x = _x; //Origin x
      y = _y; //Origin y
      r = _r; //Length
      theta = _theta; // Angle
    }

    int getEndPointX() { 
      return int(x + r*cos(theta/57.3));
    }

    int getEndPointY() {
      return int(y + r*sin(theta/57.3));
    }
  } // Vector class

  //Recursive function that creates a fractal 
  void fractal(Vector v, int N) {
    if (N > 0) {
      int dir = 1; //control alternating direction of the branch
      pg.line(v.x, v.y, v.getEndPointX(), v.getEndPointY()); //Draw the current vector
      for (int i = 0; i < BRANCHES; i++) { 
        //Create a random vector based on the current one
        Vector r = new Vector (v.x, v.y, v.r, v.theta); //New random vector that will branch off the current line
        r.r = random(v.r*MIN_LENGTH, v.r*MAX_LENGTH); //Select a random length
        r.x = r.getEndPointX(); //shift the x-origin
        r.y = r.getEndPointY(); //shift the y-origin
        r.theta += dir*random(MIN_ANGLE, MAX_ANGLE); // shift the angle a bit
        dir = dir * -1; //Alternate branch direction
        fractal(r, N-1); //Recurse
      }
    }
  }

  void DrawSnowflake(int x, int y, int radius) {
    int step = 20;
    for (int i = 0; i <= 360; i += step) {
      Vector seed = new Vector(x, y, radius, i);
      fractal (seed, DEPTH);
    }
  }
  int n;
  void reinit() {
    w = pg.width;
    h = pg.height;
    n = 0;
  }

  void draw() {
    if (n == 0) {
      pg.beginDraw();
      pg.background(0);

      pg.strokeWeight(strokeWeight0);
      pg.stroke(c0);

      int snowflakeSize = 3;
      for (int i = (w/snowflakeSize)/2; i < w; i += w/snowflakeSize) {
        for (int j = (h/snowflakeSize)/2; j < h; j += h/snowflakeSize) {
          DrawSnowflake(i, j, w/20*snowflakeSize);
        }
      }
      pg.endDraw();
    }
    n++;

    if (n >= SecondsToHold*FRAMERATE) 
    {
      n = 0;
    }
  }
}

