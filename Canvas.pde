class Canvas {
  int x;
  int y;
  int w;
  int h;
  PGraphics pg;
  float brightness = 1.0;

  Canvas(int x_, int y_, int w_, int h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;

    pg = createGraphics(w, h, P2D);
  }

  void sendToOutput() {
    int offset = 0;
    int canvasOutHeight = canvasOut.h;

    // Apply brightness
    pg.beginDraw();
    pg.fill(0, (1.0 - brightness) * 255);
    pg.rect(0, 0, w, h);
    pg.endDraw();

    canvasOut.pg.beginDraw();

    for (int col = 0; col < 8; col++) {
      for (int strip = 0; strip < 8; strip++) {
        canvasOut.pg.blend(pg.get(offset + strip * 3, 0, 1, h),
             0, 0, 1, h,
             strip + col * 8, 0, 1, canvasOutHeight, SCREEN);
      }

      // Add gaps
      offset += 30 + 30;

      // Add extra gap in middle
      if (col == 3) {
        offset += 30;
      }
    }

    canvasOut.pg.endDraw();
  }

  void clear() {
    pg.beginDraw();
    pg.background(0);
    pg.endDraw();
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
