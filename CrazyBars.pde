// Crazy Bars
// Draws some skyscraper-esque glitchy bars on the screen
// David Shimel aka keytarmageddon aka dsshimel
// 2013-8-16

class CrazyBars extends CanvasRoutine {
  private int _w;
  private int _h;
  
  private int _period;
  private int PERIOD_MAX = 10;
  private int _iterations;
  private int[] GROUP_SIZES = {1, 2, 3, 4, 8, 16};
  private int _groupSize;
  private int _groupWidth;
  
  CrazyBars(int width, int height) { 
    _w = width;
    _h = height; 
    _iterations = 0;
    _period = getRandomInt(PERIOD_MAX) + 1;
    setGroupSizeAndGroupWidth();
  }
  
  private void setGroupSizeAndGroupWidth() {
    _groupSize = GROUP_SIZES[(int) Math.floor(Math.random() * GROUP_SIZES.length)];
    _groupWidth = _w / _groupSize;
  }

  private int getRandomBars(int numBars) {
    return getRandomInt(numBars + 1);
  }
  
  private boolean flipCoin() {
    return Math.random() < 0.5;
  }
  
  private int getRandomInt(int range) {
    return (int) Math.floor(Math.random() * range);
  }
  
  private color getRandomColor() {
    return color(getRandomInt(256), getRandomInt(256), getRandomInt(256));
  }

  void draw() {
    pg.beginDraw();
    
    pg.noStroke();
    pg.colorMode(HSB);

    if(_iterations == 0) {
      if(_iterations % 24 == 0) {
        pg.background(getRandomInt(64));
      }
      
      int numHorizBars = getRandomBars(_h);
      boolean horizDiffColor = flipCoin();
      pg.stroke(getRandomColor());    
      for(int i = 0; i < numHorizBars; i++) {
        if(horizDiffColor) {
          pg.stroke(getRandomColor());    
        }
        int y = getRandomInt(_h);
        pg.line(0, y, _h, y);
      }
      
      for(int groupNumber = 0; groupNumber < _groupSize; groupNumber++) {
        int numVertBars = getRandomBars(_groupWidth);
        
        boolean vertDiffColor = flipCoin();
    
        pg.stroke(getRandomColor());
        for(int i = 0; i < numVertBars; i++) {
          if(vertDiffColor) {
            pg.stroke(getRandomColor());
          }
          int x = getRandomInt(_groupWidth) + (groupNumber * _groupWidth);
          
          pg.line(x, 0, x, _h);
        }
      }
    }
    
    _iterations++;
    if(_iterations == _period) {
      _iterations = 0;
      _period = getRandomInt(PERIOD_MAX) + 1;
      setGroupSizeAndGroupWidth();
    }
    
    pg.noStroke();
    pg.colorMode(RGB);
    pg.endDraw();
  }
}

class CrazyBarsPlayer extends SetList {
  
  CrazyBarsPlayer() { 
  }

  CrazyBarsPlayer(SetList setList) {
    super(setList);
  }
  
  void setup() {
    CrazyBars crazyBars = new CrazyBars(64, 210);

    setCanvas(canvas2, crazyBars);
    wait(5.0);
  }
}
