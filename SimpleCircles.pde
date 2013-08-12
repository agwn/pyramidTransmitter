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
  int circleSize = 66;

  
  SimpleCircles(float secondsOfOneTravel) {
    SecondsOfOneTravel = secondsOfOneTravel;
  }
  int step;
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
  
    for(int i = 0; i <= w; i += 20) {
      for(int j = 0; j <= h; j += 20) {
        float size = dist(x, h/2, i, j);
        size = size/max_distance * 35;
        pg.ellipse(i, j, size, size);
      }
    }

    pg.endDraw();
  }
}
