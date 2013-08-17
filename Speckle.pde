class Speckle extends CanvasRoutine {
  float threshold = 0.0;
  float amount = 1.0;
  private int w;
  private int h;

  Speckle() {
    setPaintMode(DIRECT);
  }

  void reinit() {
    w = pg.width;
    h = pg.height;
  }

  void draw() {
    int nPixels = w * h;

    pg.beginDraw();
    pg.loadPixels();

    for (int i = 0; i < nPixels; i++) {
      color c = pg.pixels[i];
      float r = red(c);
      float g = green(c);
      float b = blue(c);
      float a = alpha(c);

      if (r + g + b >= threshold) {
        r = constrain(r + r * random(-amount, amount), 0, 255);
        g = constrain(g + g * random(-amount, amount), 0, 255);
        b = constrain(b + b * random(-amount, amount), 0, 255);
        pg.pixels[i] = color(r, g, b, a);
      }
    }

    pg.updatePixels();
    pg.endDraw();
  }
}
