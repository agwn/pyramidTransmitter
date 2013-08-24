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

class SimpleCircles extends CanvasRoutine {
  private int w;
  private int h;
  private color c0 = color(pornj, 128);
  private int strokeWeight0=2;
  private float SecondsOfOneTravel;
  float max_distance;
  int x=0;
  boolean moving_right = true;
  int circleSize = 35;
  int step;

  
  SimpleCircles(float secondsOfOneTravel) {
    SecondsOfOneTravel = secondsOfOneTravel;
  }

  void reinit() {
    w = pg.width;
    h = pg.height;

    max_distance = dist(0, 0, width, height);
    step = (int)(w/(SecondsOfOneTravel*FRAMERATE));
  }

  void draw() {
    pg.beginDraw();
    pg.background(0);

    pg.strokeWeight(strokeWeight0);
    pg.stroke(c0);

    if (moving_right && x >= w-1) {
      moving_right = false;
    }
    if (!moving_right && x<=0 ) {
      moving_right = true;
    }
    
    x = moving_right ? ((x+step)) : x-step; 
 
    for(int i = 4; i <= w; i += 15) {
      for(int j = 0; j <= h; j += 15) {
        float size = dist(x, h/2, i, j);
        size = size/max_distance * circleSize;
        pg.pushStyle();
        pg.pushMatrix();
        pg.ellipseMode(CENTER);
        pg.ellipse(i, j, size, size);
        pg.popMatrix();
        pg.popStyle();
        pg.point(i, j);
      }
    }

    pg.endDraw();
  }
}

class SimpleCirclesPresets extends SetList {
  SimpleCirclesPresets() {
  }

  SimpleCirclesPresets(SetList setList) {
    super(setList);
  }

  void thePreset(Canvas canvas) {
    SimpleCircles simpleCircles = new SimpleCircles(1.0);
    simpleCircles.circleSize = 24;

    setCanvas(canvas, simpleCircles);
  }
}
