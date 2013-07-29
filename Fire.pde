class Fire extends CanvasRoutine {
  // This will contain the pixels used to calculate the fire effect
  int[][] fire;

  // Flame colors
  color[] palette;
  float angle;
  int[] calc1, calc2, calc3, calc4, calc5;

  PGraphics pgTemp;

  int w;
  int h;
  
  void reinit() {
    w = pg.width;
    h = pg.height;
    pgTemp = createGraphics(w, h, P2D);

    calc1 = new int[w];
    calc3 = new int[w];
    calc4 = new int[w];
    calc2 = new int[h];
    calc5 = new int[h];

    colorMode(HSB);

    fire = new int[w][h];
    palette = new color[255];

    // Generate the palette
    for (int x = 0; x < palette.length; x++) {
      //Hue goes from 0 to 85: red to yellow
      //Saturation is always the maximum: 255
      //Lightness is 0..255 for x=0..128, and 255 for x=128..255
      palette[x] = color(x/3.5, 255, constrain(x*3, 0, 255));
      //palette[x] = color(constrain(135+x/2, 0, 255), 255, constrain(x*3, 0, 255));
    }

    // Precalculate which pixel values to add during animation loop
    // this speeds up the effect by 10fps
    for (int x = 0; x < w; x++) {
      calc1[x] = x % w;
      calc3[x] = (x - 1 + w) % w;
      calc4[x] = (x + 1) % w;
    }

    for (int y = 0; y < h; y++) {
      calc2[y] = (y + 1) % h;
      calc5[y] = (y + 2) % h;
    }
    
    colorMode(RGB);
  }

  void draw() {
    pgTemp.background(0);
    angle = angle + 0.05;

    // Randomize the bottom row of the fire buffer
    for (int x = 0; x < w; x++)
    {
      fire[x][h-1] = int(random(0, 190)) ;
    }

    pgTemp.loadPixels();

    int counter = 0;
    // Do the fire calculations for every pixel, from top to bottom
    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        // Add pixel values around current pixel

        fire[x][y] =
          ((fire[calc3[x]][calc2[y]]
          + fire[calc1[x]][calc2[y]]
          + fire[calc4[x]][calc2[y]]
          + fire[calc1[x]][calc5[y]]) << 5) / (128+(abs(x-displayWidth/2))/4); // 129;
        // Output everything to screen using our palette colors
        pgTemp.pixels[counter] = palette[fire[x][y]];

        // Extract the red value using right shift and bit mask 
        // equivalent of red(pgTemp.pixels[x+y*w])
        if ((pgTemp.pixels[counter++] >> 16 & 0xFF) == 128) {
          // Only map 3D cube 'lit' pixels onto fire array needed for next frame
          fire[x][y] = 128;
        }
      }
    }
    pgTemp.updatePixels();
    pg.copy(pgTemp.get(), 0, 0, w, h, 0, 0, w, h);
  }
}
