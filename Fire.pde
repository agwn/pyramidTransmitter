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
    //  size(640, 360, P2D);

    // Create buffered image for 3d cube
    pg = createGraphics(displayWidth, displayHeight, P3D);

    calc1 = new int[displayWidth];
    calc3 = new int[displayWidth];
    calc4 = new int[displayWidth];
    calc2 = new int[displayHeight];
    calc5 = new int[displayHeight];

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
      calc1[x] = x % displayWidth;
      calc3[x] = (x - 1 + displayWidth) % displayWidth;
      calc4[x] = (x + 1) % displayWidth;
    }

    for (int y = 0; y < displayHeight; y++) {
      calc2[y] = (y + 1) % displayHeight;
      calc5[y] = (y + 2) % displayHeight;
    }
    
    colorMode(RGB);
  }

  void draw() {
    angle = angle + 0.05;

//    // Rotating wireframe cube
//    pg.beginDraw();
//    pg.translate(displayWidth >> 1, displayHeight >> 1);
//    pg.rotateX(sin(angle/2));
//    pg.rotateY(cos(angle/2));
//    pg.background(0);
//    pg.stroke(128);
//    pg.scale(25);
//    pg.noFill();
//    pg.box(4);
//    pg.endDraw();

    // Randomize the bottom row of the fire buffer
    for (int x = 0; x < displayWidth; x++)
    {
      fire[x][displayHeight-1] = int(random(0, 190)) ;
    }

    loadPixels();

    int counter = 0;
    // Do the fire calculations for every pixel, from top to bottom
    for (int y = 0; y < displayHeight; y++) {
      for (int x = 0; x < displayWidth; x++) {
        // Add pixel values around current pixel

        fire[x][y] =
          ((fire[calc3[x]][calc2[y]]
          + fire[calc1[x]][calc2[y]]
          + fire[calc4[x]][calc2[y]]
          + fire[calc1[x]][calc5[y]]) << 5) / 131; // 129;

        // Output everything to screen using our palette colors
        pixels[counter] = palette[fire[x][y]];

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

