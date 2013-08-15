// Conway's Game of Life (with a twist)
// David Shimel aka keytarmageddon aka dsshimel
// based on http://davidshimel.com/conways-game-of-life-in-processing-js/
// 2013-8-15

class Conway extends CanvasRoutine {
  private int _w;		// grid width in number of cells
  private int _h;		// grid height in number of cells
  boolean WRAP_HORIZ = true;		// grid is endless along the horizontal axis
  boolean WRAP_VERT = true;		// grid is endless along the vertical axis
  double DENSITY = 0.3;		// percentage of cells to populate in initial grid
  int MAX_GEN = 1500;
  color c0 = pornj;
  color c1 = disorientOrange;
  int sizeX = 1;
  int sizeY = 1;

  boolean[][] _grid;	// the game board
  int _generations;	// the number of generations run so far
  
  void reinit() {
    _w = pg.width;
    _h = pg.height;
    initializeGrid();
  }

  private void initializeGrid() {
    populateGrid();
    _generations = 1;
  }
  
  // randomly mark each cell as alive or dead
  private void populateGrid() {
     _grid = new boolean[_w][_h];
     
    for(int i = 0; i < _w; i++) {
      for(int j = 0; j < _h; j++) {
        _grid[i][j] = Math.random() < DENSITY;  
      }
    }
  }
  
  // create the grid for the next generation based on the current GRID
  private void generate() {
    if(_generations > MAX_GEN) {
      populateGrid();
      _generations = 1; 
      return;
    }
    
    boolean[][] nextGeneration = new boolean[_w][_h];

    for(int i = 0; i < _w; i++) {
      for(int j = 0; j < _h; j++) {
          nextGeneration[i][j] = cellWillBeAlive(i, j);
      }
    }	
		
    _grid = nextGeneration;
    _generations++;
  }
  
  // render the current game state
  private void drawGrid() {
    for(int i = 0; i < _w; i++) {
      for(int j = 0; j < _h; j++) {
        if(_grid[i][j]) { // it's alive!!
          setStrokeByLocation(i, j);
          if (sizeX == 1 && sizeY == 1) {
            pg.point(i, j);
          }
          else {
            pg.ellipse(i, j, sizeX, sizeY); // use more LEDs than a point
          }
        }
      }
    }
    // add some random alive cells to increase motion
    for(int r = 0; r < 2; r++) {
      int randI = (int)Math.floor(Math.random() * _w);
      int randJ = (int)Math.floor(Math.random() * _h);
      _grid[randI][randJ] = true;
      setStrokeByLocation(randI, randJ);
      if (sizeX == 1 && sizeY == 1) {
        pg.point(randI, randJ);
      }
      else {
        pg.ellipse(randI, randJ, sizeX, sizeY);
      }
    }
  }
  
  private int oneOrZero(double threshold) {
    return Math.random() < threshold ? 0 : 1;
  }
  
  private void setStrokeByLocation(int i, int j) {
      color c = (i / 8 + _generations / 17 + j / 105 + oneOrZero(0.1)) % 2 == 0 ? c0 : c1;
      pg.stroke(c);
  }
  
  // based on current game state, determine if cell (i, j) will be alive next generation
  private boolean cellWillBeAlive(int i, int j) {
    boolean cellLives = false;
	
    int neighbors = countLivingNeighbors(i, j);
    if(3 == neighbors) {
      cellLives = true;
    }
    else if(_grid[i][j] && 2 == neighbors)
      cellLives = true;
		
    return cellLives;
  }

  // count the number of living cells that are adjacent to cell (i, j)
  private int countLivingNeighbors(int i, int j) {
    int neighborCount = 0;
    for(int x = i - 1; x <= i + 1; x++) {
      int tempX = x;
      if(x < 0 || x >= _w) {
        if(WRAP_HORIZ) {
          x = (x + _w) % _w;
        }
        else continue;
      }
      
      for(int y = j - 1; y <= j + 1; y++) {
        int tempY = y;
        if(tempX == i && tempY == j) {
          continue; // don't check the center square
        }
        if(y < 0 || y >= _h) {
          if(WRAP_VERT) {
            y = (y + _h) % _h;
          }
          else {
            continue;
          }
        }
        if(_grid[x][y]) {
          neighborCount++;
        }
        y = tempY;
      }
      x = tempX;
    }
    
    return neighborCount;
  }

  void draw() {
    pg.beginDraw();
    
    pg.background(0);
    drawGrid();
    generate();
        
    pg.endDraw();
  }
}

class ConwayPlayer extends SetList {
  ConwayPlayer() { }

  ConwayPlayer(SetList setList) {
    super(setList);
  }
  
  void setup() {
    Conway conway = new Conway();

    setCanvas(canvas2, conway);
    wait(20.0);
  }
}
