class Bitmap {
  int w;
  int h;
  byte[][] data;

  Bitmap(byte[][] data_, int w_, int h_) {
    data = data_;
    w = w_;
    h = h_;
  }

  PImage getAsPImage() {
    PImage img = createImage(w, h, RGB);
    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        if (data[y][x] == 1) {
          img.set(x, y, color(255));
        }
        else {
        }
      }
    }
    return img;
  }

  PImage getAsPImage(boolean isVertical) {
    if (isVertical) {
      PImage img = createImage(h, w, RGB);
      for (int y = 0; y < h; y++) {
        for (int x = 0; x < w; x++) {
          if (data[y][x] == 1) {
            img.set(h - y - 1, x, color(255));
          }
          else {
          }
        }
      }
      return img;
    }
    else {
      return getAsPImage();
    }
  }

  PImage getAsPImage(color c, int wPad, int hPad, boolean isHorizontal) {
    int imgWidth = w + w * wPad;
    int imgHeight = h + h * hPad;
    PImage img;

    if (isHorizontal) {
      img = createImage(imgWidth, imgHeight, ARGB);

      for (int y = 0; y < h; y++) {
        for (int x = 0; x < w; x++) {
          if (data[y][x] == 1) {
            img.set(x * (wPad + 1), y * (hPad + 1), c);
          }
        }
      }
    }
    else {
      img = createImage(imgHeight, imgWidth, ARGB);

      for (int y = 0; y < h; y++) {
        for (int x = 0; x < w; x++) {
          if (data[y][x] == 1) {
            img.set((h - y - 1) * (hPad + 1), x * (wPad + 1), c);
          }
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
  PImage disorient;
  PImage disorientV;

  void reinit() {
    Bitmap b = (Bitmap) disFont.get("disorient");
    //disorient = b.getAsPImage(true);
    disorient = b.getAsPImage(color(255), 0, 2, true);
    disorientV = b.getAsPImage(color(255), 1, 0, false);
  }

  void draw() {
    pg.beginDraw();
    pg.background(0);
    int disWidth = disorient.width;
    int disHeight = disorient.height;
    int disVWidth = disorientV.width;
    int disVHeight = disorientV.height;
    pg.copy(disorient, 0, 0, disWidth, disHeight, 0, 180, disWidth, disHeight); 
    pg.copy(disorientV, 0, 0, disVWidth, disVHeight, 24, 0, disVWidth, disVHeight); 
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
