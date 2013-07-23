class Canvas {
  int x;
  int y;
  int w;
  int h;

  Canvas(int x_, int y_, int w_, int h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
  }
}

public class CanvasFrame extends Frame {
  FullCanvas canvas;

  public CanvasFrame(FullCanvas targetCanvas) {
    setBounds(100, 100, 580, 310);
    canvas = targetCanvas;
    add(canvas);
    canvas.init();
    show();
  }
}


public class FullCanvas extends PApplet {
  public void setup() {
    // 16 meters * 30 LEDs - outer padding x 7 meters * 30 LEDs
    size(474, 210);  
    frameRate(FRAMERATE);
    smooth();
    noLoop();
  }

  public void draw() {}
}


class FullCanvasTest extends Routine {
  FullCanvas c;
  int posX = 0;
  int posY = 0;

  FullCanvasTest(FullCanvas fullCanvas) {
    c = fullCanvas;
  }

  void draw() {
    c.pushStyle();
    c.fill(0);
    c.noStroke();
    c.rect(0, 0, c.width, c.height);
    c.fill(255, 0, 0);
    c.stroke(255, 0, 0);
    c.strokeWeight(10);
    c.line(0, c.height, c.width, 0);
    c.line(0, 0, c.width, c.height);
    c.popStyle();
  }
}
