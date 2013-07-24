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
    pg.background(0);
  }

  Canvas(int x_, int y_, int w_, int h_, String mode) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;

    pg = createGraphics(w, h, mode);
    pg.background(0);
  }

  void sendToOutput() {
    int offset = 0;
    int canvasOutHeight = canvasOut.h;

    pg.beginDraw();
    pg.fill(0, (1.0 - brightness) * 255);
    pg.rect(0, 0, w, h);
    pg.endDraw();


// pgCopy Method is super slow
/*
    PGraphics pgCopy = createGraphics(w, h, P2D);
    pgCopy.beginDraw();
    pgCopy.copy(pg.get(), 0, 0, w, h, 0, 0, w, h);
    pgCopy.fill(0, (1.0 - brightness) * 255);
    pgCopy.rect(0, 0, w, h);
    pgCopy.endDraw();
*/
 
    canvasOut.pg.beginDraw();

    for (int col = 0; col < 8; col++) {
      for (int strip = 0; strip < 8; strip++) {
        canvasOut.pg.blend(pg.get(offset + strip * 3, 0, 1, h),
             0, 0, 1, h,
             strip + col * 8, 0, 1, canvasOutHeight, SCREEN);

        // Part of pgCopy method
        //PImage temp = pgCopy.get(offset + strip * 3, 0, 1, h) ;


// Unrolling shows insignificant improvement
/*
        PImage temp = pg.get(offset + 0 * 3, 0, 1, h) ;
        canvasOut.pg.blend(temp,
             0, 0, 1, h,
             0 + col * 8, 0, 1, canvasOut.h, SCREEN);
        temp = pg.get(offset + 1 * 3, 0, 1, h) ;
        canvasOut.pg.blend(temp,
             0, 0, 1, h,
             1 + col * 8, 0, 1, canvasOut.h, SCREEN);
        temp = pg.get(offset + 2 * 3, 0, 1, h) ;
        canvasOut.pg.blend(temp,
             0, 0, 1, h,
             2 + col * 8, 0, 1, canvasOut.h, SCREEN);
        temp = pg.get(offset + 3 * 3, 0, 1, h) ;
        canvasOut.pg.blend(temp,
             0, 0, 1, h,
             3 + col * 8, 0, 1, canvasOut.h, SCREEN);
        temp = pg.get(offset + 4 * 3, 0, 1, h) ;
        canvasOut.pg.blend(temp,
             0, 0, 1, h,
             4 + col * 8, 0, 1, canvasOut.h, SCREEN);
        temp = pg.get(offset + 5 * 3, 0, 1, h) ;
        canvasOut.pg.blend(temp,
             0, 0, 1, h,
             5 + col * 8, 0, 1, canvasOut.h, SCREEN);
        temp = pg.get(offset + 6 * 3, 0, 1, h) ;
        canvasOut.pg.blend(temp,
             0, 0, 1, h,
             6 + col * 8, 0, 1, canvasOut.h, SCREEN);
        temp = pg.get(offset + 7 * 3, 0, 1, h) ;
        canvasOut.pg.blend(temp,
             0, 0, 1, h,
             7 + col * 8, 0, 1, canvasOut.h, SCREEN);
*/
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
