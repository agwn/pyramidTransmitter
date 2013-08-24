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
class StarBand extends CanvasRoutine {
  private int w;
  private int h;
  private color c0 = color(pornj, 128);
  private int strokeWeight0=2;
  int bandHeightPercentMin=2;
  int bandHeightPercentMax=15;
  float SecondsToHold;
  int frameCounter;
  int n;
  
  StarBand(float secondsToDisplay, int minBandWidthPercent, int maxBandWidthPercent) {
    SecondsToHold = secondsToDisplay;
    bandHeightPercentMin = minBandWidthPercent;
    bandHeightPercentMax = maxBandWidthPercent;
  }

  void reinit() {
    w = pg.width;
    h = pg.height;
    n = 0;
    frameCounter = 0;
  }
  
  void draw() {

    if (frameCounter <= 0) {
      pg.beginDraw();
      pg.background(0);

      pg.strokeWeight(strokeWeight0);
      pg.stroke(c0);

      float centerY = random(h/2-(h/4), h/2+(h/4));
    
      float rand = h*bandHeightPercentMin/100 + random(0, h*(bandHeightPercentMax-bandHeightPercentMin)/100);
      
      for  (int i = 0; i < w/2; i++) {
        int y = (int)((centerY) + random(-rand, rand));
        pg.point( (w/2 - i),  y );
        pg.point( (w/2 + i),  y );
      }

      pg.endDraw();
      frameCounter = (int) (SecondsToHold * FRAMERATE);
    }

    frameCounter--;
  }
}

class StarBandPresets extends SetList {
  StarBandPresets() {
  }

  StarBandPresets(SetList setList) {
    super(setList);
  }

  void thePreset(Canvas canvas) {
    float secondsToHoldTheBand = 0.1;
    int PercentBandWidthMin = 2;
    int PercentBandWidthMax = 15;

    StarBand starBand = new StarBand(secondsToHoldTheBand, PercentBandWidthMin, PercentBandWidthMax);

    setCanvas(canvas, starBand); 
  }
}
