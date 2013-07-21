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
    noLoop();
  }

  public void draw() {}
}
