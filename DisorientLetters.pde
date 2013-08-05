class Bitmap {
  int w;
  int h;
  int[][] data;

  Bitmap(int[][] data_, int w_, int h_) {
    data = data_;
    w = w_;
    h = h_;
  }

  PImage getAsPImage() {
    PImage img = createImage(w, h, RGB);
    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        if (data[y][x] == 1) {
          img.pixels[y * h + x] = color(255);
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

void initDisorientLetters() {
  letterMap = new HashMap();
  letterMap.put("d", new Bitmap(LETTER_D, 10, 8));
  letterMap.put("i", new Bitmap(LETTER_I, 2, 8));
  letterMap.put("s", new Bitmap(LETTER_S, 10, 8));
  letterMap.put("o", new Bitmap(LETTER_O, 10, 8));
  letterMap.put("r", new Bitmap(LETTER_R, 10, 8));
  letterMap.put("e", new Bitmap(LETTER_E, 10, 8));
  letterMap.put("t", new Bitmap(LETTER_T, 10, 8));
  letterMap.put("1", new Bitmap(LETTER_1, 3, 8));
  letterMap.put("3", new Bitmap(LETTER_3, 10, 8));

  Iterator i = letterMap.entrySet().iterator(); 

/*
  while (i.hasNext()) {
    Map.Entry me = (Map.Entry)i.next();
    Bitmap theLetter = (Bitmap) me.getValue();;
    theLetter.printToConsole();
  }
*/
}

final int[][] LETTER_D = new int[][] {
  {1,1,1,1,1,1,1,1,1,0},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,0},
};

final int[][] LETTER_I = new int[][] {
  {1,1},
  {1,1},
  {0,0},
  {1,1},
  {1,1},
  {1,1},
  {1,1},
  {1,1},
};

final int[][] LETTER_S = new int[][] {
  {0,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,0,0,0,0,0,0,0,0},
  {1,1,1,1,1,1,1,1,1,0},
  {0,1,1,1,1,1,1,1,1,1},
  {0,0,0,0,0,0,0,0,1,1},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,0},
};

final int[][] LETTER_O = new int[][] {
  {0,1,1,1,1,1,1,1,1,0},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,1,1,1,1,1,1,1,1},
  {0,1,1,1,1,1,1,1,1,0},
};

final int[][] LETTER_R = new int[][] {
  {1,1,1,1,1,1,1,1,1,0},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,1,1,1,1,1,1,1,0},
  {1,1,1,1,1,1,1,1,1,0},
  {1,1,0,0,0,0,0,1,1,1},
  {1,1,0,0,0,0,0,0,1,1},
};

final int[][] LETTER_E = new int[][] {
  {0,1,1,1,1,1,1,1,1,0},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,0,0,0,0,0,0,1,1},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,0,0,0,0,0,0,0,0},
  {1,1,1,1,1,1,1,1,1,0},
  {0,1,1,1,1,1,1,1,1,0},
};

final int[][] LETTER_T = new int[][] {
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1},
  {0,0,0,0,1,1,0,0,0,0},
  {0,0,0,0,1,1,0,0,0,0},
  {0,0,0,0,1,1,0,0,0,0},
  {0,0,0,0,1,1,0,0,0,0},
  {0,0,0,0,1,1,0,0,0,0},
  {0,0,0,0,1,1,0,0,0,0},
};

final int[][] LETTER_1 = new int[][] {
  {1,1,0},
  {1,1,1},
  {0,1,1},
  {0,1,1},
  {0,1,1},
  {0,1,1},
  {0,1,1},
  {0,1,1},
};

final int[][] LETTER_3 = new int[][] {
  {1,1,1,1,1,1,1,1,1,0},
  {1,1,1,1,1,1,1,1,1,1},
  {0,0,0,0,0,0,0,0,1,1},
  {0,0,1,1,1,1,1,1,1,1},
  {0,0,1,1,1,1,1,1,1,1},
  {0,0,0,0,0,0,0,0,1,1},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,0},
};
