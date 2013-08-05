class Bitmap {
  int w;
  int h;
  byte[][] data;

  Bitmap(byte[][] data_, int w_, int h_) {
    data = data_;
    w = w_;
    h = h_;
  }

  Bitmap getBitmap(boolean doRotate, boolean xFlip, boolean yFlip) {
    int theWidth = w;
    int theHeight = h;

    if (doRotate) {
      theWidth = h;
      theHeight = w;
    }

    byte[][] newArray = new byte[theHeight][theWidth];

    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        if (doRotate) {
          newArray[x][y] = data[y][x];
        }
        else {
          for (int i = 0; i < data.length; i++) {
            newArray[y][x] = data[y][x];
          }
        }
      }
    }

    // Do flipping
    if (xFlip) {
      for (int y = 0; y < theHeight; y++) {
        for (int x = 0; x < theWidth / 2; x++) {
          byte temp = newArray[y][x];
          newArray[y][x] = newArray[y][theWidth - x - 1];
          newArray[y][theWidth - x - 1] = temp;
        }
      }
    }

    if (yFlip) {
      for (int y = 0; y < theHeight / 2; y++) {
        for (int x = 0; x < theWidth; x++) {
          byte temp = newArray[y][x];
          newArray[y][x] = newArray[theHeight - y - 1][x];
          newArray[theHeight - y - 1][x] = temp;
        }
      }
    }
 
    return new Bitmap(newArray, theWidth, theHeight);
  }

  PImage getAsPImage(color c, int xPad, int yPad) {
    int imgWidth = w + w * xPad;
    int imgHeight = h + h * yPad;
    PImage img;

    img = createImage(imgWidth, imgHeight, ARGB);

    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        if (data[y][x] == 1) {
          img.set(x * (xPad + 1), y * (yPad + 1), c);
        }
      }
    }

    return img;
  }

  void printToConsole() {
    for (int i = 0; i < h; i++) {
      for (int j = 0; j < w; j++) {
        print(data[i][j]);
      }
      println();
    }
    println();
  }
}

class DisorientFont extends HashMap {
  DisorientFont() {
    put("d", new Bitmap(LETTER_D, 10, 8));
    put("i", new Bitmap(LETTER_I, 2, 8));
    put("s", new Bitmap(LETTER_S, 10, 8));
    put("o", new Bitmap(LETTER_O, 10, 8));
    put("r", new Bitmap(LETTER_R, 10, 8));
    put("1", new Bitmap(LETTER_1, 3, 8));
    put("e", new Bitmap(LETTER_E, 10, 8));
    put("n", new Bitmap(LETTER_N, 10, 8));
    put("t", new Bitmap(LETTER_T, 10, 8));
    put("3", new Bitmap(LETTER_3, 10, 8));
    generateBitmap("disorient");
    generateBitmap("disor13nt");
  }

  private void generateBitmap(String s) {
    int bitmapWidth = 0;

    // Get width of new Bitmap
    for (char c : s.toCharArray()) {
      Bitmap b = (Bitmap) get(Character.toString(c));
      bitmapWidth += b.w;
    }

    bitmapWidth += s.length() - 1;

    // Create new Bitmap
    byte[][] newArray = new byte[8][bitmapWidth];
    int offset = 0;

    for (char c : s.toCharArray()) {
      Bitmap b = (Bitmap) get(Character.toString(c));

      for (int y = 0; y < b.h; y++) {
        for (int x = 0; x < b.w; x++) {
          newArray[y][x + offset] = b.data[y][x];
        }
      }
      
      offset += b.w + 1;
    }

    Bitmap newBitmap = new Bitmap(newArray, bitmapWidth, 8);
    put(s, newBitmap);
  }

  void printAllToConsole() {
    Iterator i = this.entrySet().iterator(); 

    while (i.hasNext()) {
      Map.Entry me = (Map.Entry)i.next();
      Bitmap theLetter = (Bitmap) me.getValue();
      theLetter.printToConsole();
    }
  }
}

class DisplayDisorient extends CanvasRoutine {
  PImage img;
  Bitmap bitmap;
  int x;
  int y;
  int orientation = 0;
  color c = color(255);
  int xPad = 0;
  int yPad = 0;
  boolean doRotate = false;
  boolean xFlip = false;
  boolean yFlip = false;
  int w;
  int h;

  DisplayDisorient() {
  }

  void reinit() {
    bitmap = (Bitmap) disFont.get("disorient");
    bitmap = bitmap.getBitmap(doRotate, xFlip, yFlip);
    img = bitmap.getAsPImage(c, xPad, yPad);
    w = pg.width;
    h = pg.height;
  }

  void draw() {
    pg.beginDraw();
    pg.background(0);
    pg.copy(img, 0, 0, img.width, img.height, x, y, img.width, img.height); 
    pg.endDraw();
  }
}

class DisorientScroll extends DisplayDisorient {
  int xSpeed = 0;
  int ySpeed = 0;
  int yLimitBottom;
  int yLimitTop;

  void reinit() {
    super.reinit();
    int yLimitBottom = h;
    int yLimitTop = 0;
  }

  void draw() {
    pg.beginDraw();
    pg.background(0);
    pg.copy(img, 0, 0, img.width, img.height, x, y, img.width, img.height); 

    x += xSpeed;
    if (x >= w) {
      x = -img.width;
    }
    if (x < -img.width) {
      x = w - 1;
    }

    y += ySpeed;
    if (y >= yLimitBottom) {
      y = -img.height + yLimitTop;
    }
    if (y < -img.height + yLimitTop) {
      y = yLimitBottom - 1;
    }

    pg.endDraw();
  }
}

final byte[][] LETTER_D = new byte[][] {
  {1,1,1,1,1,1,1,1,1,0},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,0},
};

final byte[][] LETTER_I = new byte[][] {
  {1,1},
  {1,1},
  {0,0},
  {1,1},
  {1,1},
  {1,1},
  {1,1},
  {1,1},
};

final byte[][] LETTER_S = new byte[][] {
  {0,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,0,0,0,0,0,0,0,0},
  {1,1,1,1,1,1,1,1,1,0},
  {0,1,1,1,1,1,1,1,1,1},
  {0,0,0,0,0,0,0,0,1,1},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,0},
};

final byte[][] LETTER_O = new byte[][] {
  {0,1,1,1,1,1,1,1,1,0},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,1,1,1,1,1,1,1,1},
  {0,1,1,1,1,1,1,1,1,0},
};

final byte[][] LETTER_R = new byte[][] {
  {1,1,1,1,1,1,1,1,1,0},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,1,1,1,1,1,1,1,0},
  {1,1,1,1,1,1,1,1,1,0},
  {1,1,0,0,0,0,0,1,1,1},
  {1,1,0,0,0,0,0,0,1,1},
};

final byte[][] LETTER_E = new byte[][] {
  {0,1,1,1,1,1,1,1,1,0},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,0,0,0,0,0,0,0,0},
  {1,1,1,1,1,1,1,1,1,0},
  {0,1,1,1,1,1,1,1,1,0},
};

final byte[][] LETTER_N = new byte[][] {
  {1,1,1,1,1,1,1,1,1,0},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,0,0,0,0,0,0,1,1},
};

final byte[][] LETTER_T = new byte[][] {
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1},
  {0,0,0,0,1,1,0,0,0,0},
  {0,0,0,0,1,1,0,0,0,0},
  {0,0,0,0,1,1,0,0,0,0},
  {0,0,0,0,1,1,0,0,0,0},
  {0,0,0,0,1,1,0,0,0,0},
  {0,0,0,0,1,1,0,0,0,0},
};

final byte[][] LETTER_1 = new byte[][] {
  {1,1,0},
  {1,1,1},
  {0,1,1},
  {0,1,1},
  {0,1,1},
  {0,1,1},
  {0,1,1},
  {0,1,1},
};

final byte[][] LETTER_3 = new byte[][] {
  {1,1,1,1,1,1,1,1,1,0},
  {1,1,1,1,1,1,1,1,1,1},
  {0,0,0,0,0,0,0,0,1,1},
  {0,0,1,1,1,1,1,1,1,1},
  {0,0,1,1,1,1,1,1,1,1},
  {0,0,0,0,0,0,0,0,1,1},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,0},
};
