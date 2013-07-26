class RGBRoutine extends CanvasRoutine {
  int color_angle = 0;
  int w;
  int h;

  void reinit() {
    w = pg.width;
    h = pg.height;
  }

  void draw() {
    pg.beginDraw();
    pg.background(0);
    pg.noSmooth();
    float scaling = 1.0;

    for (int row = 0; row < h; row++) {
      for (int col = 0; col < w; col++) {
        float r = (((row)*2 + 100.0*col/w + color_angle +  0)%100)*(varMax[0]/100.0);
        float g = (((row)*2 + 100.0*col/w + color_angle + 33)%100)*(varMax[1]/100.0);
        float b = (((row)*2 + 100.0*col/w + color_angle + 66)%100)*(varMax[2]/100.0);
        pg.stroke(int(scaling*r), int(scaling*g), int(scaling*b));
        pg.point(col, row);
      }
    }

    color_angle = (color_angle+1)%255;
    pg.endDraw();
  }
}

