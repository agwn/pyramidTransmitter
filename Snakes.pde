// Snaaaaaaaakes
// depending on how you set the lengths, this could also be piiiiiiipes, woooooorms or fliiiiiiiies
// David Shimel aka keytarmageddon aka dsshimel
// 2013-8-16

public class Snakes extends CanvasRoutine {
  private int _w;		// grid width in number of cells
  private int _h;		// grid height in number of cells
  boolean WRAP_HORIZ = true;		// grid is endless along the horizontal axis
  boolean WRAP_VERT = true;		// grid is endless along the vertical axis
  int INIT_SNAKES = 1;
  int MAX_SNAKES = 450;
  private LinkedList<Snake> _snakes; 
  private int MIN_LENGTH = 10;  // min and max snake lengths
  private int MAX_LENGTH = 100; // max will be MAX_LENGTH - 1 actually
  private final int[] DIRECTIONS = {0, 1, 2, 3};
  private int _generations = 0;	// the number of generations run so far
  private int FREQUENCY = 10; // add a snake every FREQUENCY generations

  private class Snake {
    private LinkedList<PVector> _segments;
    private color _bodyColor;
    private color _headColor = color(255);
    private int _initDirection;
    
    public Snake() {
      _bodyColor = getRandomDisorientColor();

      _segments = new LinkedList<PVector>();
      PVector head = getRandomPoint();
      _segments.add(head);
                  
      _initDirection = getRandomDirection();
      for(int s = 1; s < getRandomLength(); s++) {
        _segments.add(getDirectedPoint(_initDirection, head));
      }
    }
    
    private int getRandomLength() {
      return (int) Math.floor((Math.random() * (MAX_LENGTH - MIN_LENGTH)) + MIN_LENGTH);
    }
    
    private PVector getRandomPoint() {
      int x = (int) Math.floor(Math.random() * _w);
      int y = (int) Math.floor(Math.random() * _h);
      return new PVector(x, y);
    }
    
    private color getRandomDisorientColor() {
      return flipCoin() ? pornj : disorientOrange;
    }
    
    private boolean flipCoin() {
      return Math.random() < 0.5;
    }
    
    public PVector removeTail() {
      // occasionally change the snake's color
      if(Math.random() < 0.03) {
        _bodyColor = getRandomDisorientColor();
      }
      return _segments.removeLast();
    }
    
    // make the snakes more likely to go in their initial direction
    // so they don't bunch up into coils
    private int getRandomDirection() {
      if(flipCoin()) {
        return _initDirection;
      }
       return DIRECTIONS[(int) Math.floor(Math.random() * 4)];
    }
    
    public PVector addHead() {
      PVector newHead = getDirectedPoint(getRandomDirection(), _segments.getFirst());
      
      _segments.addFirst(newHead);
      return newHead;
    }
    
    private PVector getDirectedPoint(int d, PVector p) {
      return adjustPointByDirection(d, p.get()); // copy and adjust p
    }
    
    private PVector adjustPointByDirection(int d, PVector p) {
      int x = (int)p.x;
      int y = (int)p.y;
      switch(d) {
          case 0:
            y--;
            if(WRAP_VERT) {
              if (y < 0) {
                y = _h - 1;
              }
            }
            break;
          case 1:
            y++;
            if(WRAP_VERT) {
              if (y > _h - 1) {
                y = 0;
              }
            }
            break;
          case 2:
            x--;
            if(WRAP_HORIZ) {
              if (x < 0) {
                x = _w - 1;
              }
            }
            break;
          case 3:
            x++;
            if(WRAP_HORIZ) {
              if (x > _w - 1) {
                x = 0;
              }
            }
            break;
        }
        p.set((float)x, (float)y, 0);
        return p;
    }
    
    public LinkedList<PVector> getSegments() { return _segments; }
    public color getBodyColor() { return _bodyColor; }
    public color getHeadColor() { return _headColor; }
  }
  
  Snakes(int width, int height) { 
    _w = width;
    _h = height;
    populateSnakes();
  } 
  
  private void populateSnakes() {
    _snakes = new LinkedList<Snake>();
    for(int i = 0; i < INIT_SNAKES; i++) {
      _snakes.add(new Snake());
    }
  }
  
  void draw() {
    pg.beginDraw();
    pg.background(0);
    
    drawSnakes();
    _generations++;
    if(_generations % FREQUENCY == 0) {
      _snakes.add(new Snake());
    }
    if(_snakes.size() > MAX_SNAKES) {
      pg.background(255); // blow up the snakes
      populateSnakes(); // reset once snakes are at CRITICAL MASS
    }
        
    pg.endDraw();
  }
  
  private void drawSnakes() {
    for(Snake snake : _snakes) {
      drawSnake(snake);
    } 
  }
  
  private void drawSnake(Snake snake) {
    // remove the tail
    pg.stroke(0);
    PVector tail = snake.removeTail();
    pg.point(tail.x, tail.y);
    
    // add a head, thus moving the snake
    snake.addHead();
    
    // draw the segments . . . 

    boolean first = true;
    for(PVector segment : snake.getSegments()) {
      if(first) {
        pg.noStroke();
        pg.stroke(snake.getHeadColor());
      }
      else {
        pg.noStroke();
        pg.stroke(snake.getBodyColor());
      }
      pg.point(segment.x, segment.y);
      first = false;
    }
  }
}

class SnakesPlayer extends SetList {
  
  SnakesPlayer() { 
  }

  SnakesPlayer(SetList setList) {
    super(setList);
  }
  
  void setup() {
    Snakes snakes = new Snakes(64, 210);

    setCanvas(canvas2, snakes);
    wait(60.0);
  }
}
