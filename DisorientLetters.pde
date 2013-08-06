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

  Bitmap getBitmap(String s) {
    return (Bitmap) get(s);
  }

  private void generateBitmap(String s) {
    int bitmapWidth = 0;

    // Get width of new Bitmap
    for (char c : s.toCharArray()) {
      Bitmap b = getBitmap(Character.toString(c));
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

class DisplayDisorient extends DisplayImage {
  DisplayDisorient() { }

  void reinit() {
    super.reinit();
    Bitmap bitmap = disFont.getBitmap("disorient");
    bitmap = bitmap.getBitmap(doRotate, xFlip, yFlip);
    img = bitmap.getAsPImage(c, xPad, yPad);
  }
}

class DisorientScroll extends ScrollImage {
  void reinit() {
    super.reinit();
    Bitmap bitmap = (Bitmap) disFont.get("disorient");
    bitmap = bitmap.getBitmap(doRotate, xFlip, yFlip);
    img = bitmap.getAsPImage(c, xPad, yPad);
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
