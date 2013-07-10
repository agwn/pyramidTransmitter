class Fire extends Routine {
  // This will contain the pixels used to calculate the fire effect
  int[][] fire;

  // Flame colors
  color[] palette;
  float angle;
  int[] calc1, calc2, calc3, calc4, calc5;

  PGraphics pg;

  void setup(PApplet parent) {
    super.setup(parent);

    // Create buffered image for flame effect
    pg = createGraphics(displayWidth, displayHeight, P2D);

    calc1 = new int[displayHeight];
    calc3 = new int[displayHeight];
    calc4 = new int[displayHeight];
    calc2 = new int[displayWidth];
    calc5 = new int[displayWidth];

    colorMode(HSB);

    fire = new int[displayWidth][displayHeight];
    palette = new color[255];

    // Generate the palette
    for (int x = 0; x < palette.length; x++) {
      //Hue goes from 0 to 85: red to yellow
      //Saturation is always the maximum: 255
      //Lightness is 0..255 for x=0..128, and 255 for x=128..255
      palette[x] = color(x/3, 255, constrain(x*3, 0, 255));
    }

    // Precalculate which pixel values to add during animation loop
    // this speeds up the effect by 10fps
    for (int x = 0; x < displayWidth; x++) {
      calc2[x] = (x - 1 + displayWidth) % displayWidth;
      calc5[x] = (x - 2 + displayWidth) % displayWidth;
    }

    for (int y = 0; y < displayHeight; y++) {
      calc1[y] = y % displayHeight;
      calc3[y] = (y - 1 + displayHeight) % displayHeight;
      calc4[y] = (y + 1) % displayHeight;
    }

    colorMode(RGB);
  }

  void draw() {

    // Randomize the left side of the fire buffer
    for (int y = 0; y < displayHeight; y++)
    {
      //fire[0][y] = int(random(0, 190)) ;
      fire[0][y] = int(random(0, 190)) ;
    }

    loadPixels();

    int counter = 0;
    // Do the fire calculations for every pixel, from top to bottom
    for (int x = (displayWidth-1); x >= 0; x--) {
      for (int y = 0; y < displayHeight; y++) {
        // Add pixel values around current pixel
        fire[x][y] =
          ((fire[calc2[x]][calc3[y]]
          + fire[calc2[x]][calc1[y]]
          + fire[calc2[x]][calc4[y]]
          + fire[calc5[x]][calc1[y]]) << 5) / 132; //129;

        // Output everything to screen using our palette colors
        //pixelId = y*displayWidth+x;
        pixels[y*displayWidth+x] = palette[fire[x][y]];

        // Extract the red value using right shift and bit mask 
        // equivalent of red(pg.pixels[x+y*w])
        if ((pg.pixels[counter++] >> 16 & 0xFF) == 128) {
          // Only map 3D cube 'lit' pixels onto fire array needed for next frame
          fire[x][y] = 128;
        }
      }
    }
    updatePixels();
  }
}

