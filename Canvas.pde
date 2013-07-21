public class CanvasFrame extends Frame {
  FullCanvas canvas;

  public CanvasFrame(FullCanvas targetCanvas) {
    setBounds(100, 100, 480, 210);
    canvas = targetCanvas;
    add(canvas);
    canvas.init();
    show();
  }
}

public class FullCanvas extends PApplet {
  public void setup() {
    size(480, 210);  // 16 meters * 30 LEDs x 7 meters * 30 LEDs
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
    c.fill(255);
    c.stroke(255);
    c.line(0, 0, c.width, c.height);
    c.popStyle();
  }
}
