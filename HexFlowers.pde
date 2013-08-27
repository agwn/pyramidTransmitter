// HexFlowers
// Draws flowers/stars/benzene rings on a hexagonal grid
// David Shimel aka keytarmageddon aka dsshimel
// 2013-8-18

import java.util.Random;

public class HexFlowers extends CanvasRoutine {
  private int _w;		// grid width in number of cells
  private int _h;		// grid height in number of cells
  private int TRI_WIDTH = 2;
  private int TRI_HEIGHT = 4;
  private boolean[][] _grid;
  private int MAX_X_OFFSET = TRI_WIDTH - 1;
  private int MAX_Y_OFFSET = TRI_HEIGHT - 1;
  private int _xOffset, _yOffset;
  private int _generations = 0;
  private boolean _drawConnected = true;
  private double _pornjDensity = 0.5;
  private boolean _drawGrid = true;
  private double _density = 0.1;
  private double _gridDensity = 0.5;
  private double _starDensity = 0.5;
  private double _ringDensity = 0.5;
  private int _gridIntensity = 96;
  private int _frequency = 2;
  private double _ringPartiality = 0.5;
  private int GRID_INTENSITY_FREQ = 27;
  private int GRID_DENSITY_FREQ = 37;
  private int PORNJ_DENSITY_FREQ = 23;
  private int DRAW_CONNECTED_FREQ = 41;
  private int MAX_X_OFFSET_FREQ = 29;
  private int MAX_Y_OFFSET_FREQ = 31;
  private int FREQUENCY_FREQ = 43;
  private int RING_DENSITY_FREQ = 19;
  private int STAR_DENSITY_FREQ = 17;
  private int RING_PARTIALITY_FREQ = 47;
    
  HexFlowers(int width, int height) { 
    _w = width;
    _h = height;
    _xOffset = 0;
    _yOffset = 0;
    initGrid();
  }
  
  private void initGrid() {
    if(Math.random() < 0.3) {
      TRI_WIDTH = 2 + getRandomInt(4);
      TRI_HEIGHT = 4 + getRandomInt(10);
      MAX_X_OFFSET = TRI_WIDTH - 1;
      MAX_Y_OFFSET = TRI_HEIGHT - 1;
    }
    _grid = new boolean[_w][_h];
    for(int i = 0; i < _w; i++) {
      for(int j = 0; j < _h; j++) {
        if(isOutPoint(i, j) || isInPoint(i, j)) {
          _grid[i][j] = true;
        }
      }
    }
  }
  
  private boolean isOutPoint(int i, int j) {
    return (i - _xOffset) % TRI_HEIGHT == 0 && (j - _yOffset) % TRI_HEIGHT == 0; 
  }
  
  private boolean isInPoint(int i, int j) {
    return (i - _xOffset) % TRI_HEIGHT == 2 && (j - _yOffset) % TRI_HEIGHT == 2; 
  }

  private int getRandomInt(int range) {
    return (int) Math.floor(Math.random() * range);
  }

  private color getColor() {
    if(Math.random() < _pornjDensity) {
      if(Math.random() < 0.5) {
        return pornj;
      }
      else {
        return disorientOrange;
      }
    }
    else {
      return color(getRandomInt(256), getRandomInt(256), getRandomInt(256));
    }
  }

  void draw() {
    pg.beginDraw();
    
    if(_generations % _frequency == 0) {
      pg.background(0);
      for(int i = 0; i < _w; i++) {
        for(int j = 0; j < _h; j++) {
          if(_grid[i][j]) {
            pg.stroke(getColor());
            if(!_drawConnected) {
              drawAllVerticesForPoint(i, j);
            }
            else {
              drawConnectedVerticesForPoint(i, j);
            }
            if(_drawGrid && Math.random() < _gridDensity) {
              pg.stroke(_gridIntensity);
              pg.point(i, j);
            }
          }
        }
      }
      _drawConnected = !_drawConnected;
    }
    
    if(_generations % GRID_INTENSITY_FREQ == 0) {
      _gridIntensity = getRandomInt(96);      
    }
    if(_generations % GRID_DENSITY_FREQ == 0) {
      _gridDensity = Math.random();
    }
    if(_generations % PORNJ_DENSITY_FREQ == 0) {
       _pornjDensity = Math.random();
    }
    if(_generations % DRAW_CONNECTED_FREQ == 0) {
      _drawConnected = !_drawConnected;
    }
    boolean doInit = false;
    if(_generations % MAX_X_OFFSET_FREQ == 0) {
      _xOffset = (int) Math.floor(Math.random() * TRI_WIDTH);
      doInit = true;
    }
    if(_generations % MAX_Y_OFFSET_FREQ == 0) {
      _yOffset = (int) Math.floor(Math.random() * TRI_HEIGHT);
       doInit = true;
    }
    if(doInit) {
      initGrid();
    }
    if(_generations % FREQUENCY_FREQ == 0) {
      _frequency = 1 + getRandomInt(15);
    }
    if(_generations % STAR_DENSITY_FREQ == 0) {
      _starDensity = Math.random();
    }
    if(_generations % RING_DENSITY_FREQ == 0) {
      _ringDensity = Math.random();
    }
    if(_generations % RING_PARTIALITY_FREQ == 0) {
      _ringPartiality = Math.random();
    }

    _generations++;
    pg.endDraw();
  }
  
  private PVector[] getValidPoints(int i, int j) {
      PVector[] points = new PVector[6];
      points[0] = new PVector(i - TRI_WIDTH, j - TRI_WIDTH);
      points[1] = new PVector(i, j - TRI_HEIGHT);
      points[2] = new PVector(i + TRI_WIDTH, j - TRI_WIDTH);
      points[3] = new PVector(i + TRI_WIDTH, j + TRI_WIDTH); 
      points[4] = new PVector(i, j + TRI_HEIGHT);
      points[5] = new PVector(i - TRI_WIDTH, j + TRI_WIDTH);
      return points;
  }

  private boolean pointOnBoard(int x, int y) {
    return (x >= 0) && (x <= _w) && (y >= 0) && (y <= _h);
  }

  private void drawConnectedVerticesForPoint(int i, int j) {
     if(isOutPoint(i, j) || isInPoint(i, j)) { // this check may be unnecessary
      if(Math.random() < _density) {
        PVector[] points = getValidPoints(i, j);            
        if(Math.random() < _starDensity) {
          for(PVector point : points) {
            int x = (int)point.x;
            int y = (int)point.y;
            if(pointOnBoard(x, y)) {
              pg.line(i, j, x, y);
            }
          }
        }
        if(Math.random() < _ringDensity) {
          for(int c = 0; c < points.length; c++) {
            if(Math.random() < _ringPartiality) continue;
            PVector p1 = points[c];
            int nextIndex = c + 1;
            if(nextIndex == points.length) {
              nextIndex = 0;
            }
            PVector p2 = points[nextIndex];
            pg.line(p1.x, p1.y, p2.x, p2.y);
          }
        }
      }
    }
  }
  
  private void drawAllVerticesForPoint(int i, int j) {
    if(isOutPoint(i, j) || isInPoint(i, j)) { // this check may be unnecessary
      PVector[] points = getValidPoints(i, j);

      for(PVector point : points) {
        int x = (int)point.x;
        int y = (int)point.y;
          if(pointOnBoard(x, y)) {
            if(Math.random() < _density) {
              pg.line(i, j, x, y);
            }
          }
        }
      }
    }
}

class HexFlowersPlayer extends SetList {
  
  HexFlowersPlayer() { 
  }

  HexFlowersPlayer(SetList setList) {
    super(setList);
  }
  
  void setup() {
    double exp = 0.3;
    HexFlowers hexFlowers = new HexFlowers(64, 210);

    setCanvas(canvas2, hexFlowers);
    wait(60.0);
  }
}

class HexFlowersPresets extends SetList {
  HexFlowersPresets() { 
  }

  HexFlowersPresets(SetList setList) {
    super(setList);
  }
  
  void thePreset(Canvas canvas) {
    double exp = 0.3;
    HexFlowers hexFlowers = new HexFlowers(64, 210);

    setCanvas(canvas, hexFlowers);
  }
}
