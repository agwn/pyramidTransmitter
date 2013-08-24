class Bitmap {
  int w;
  int h;
  byte[][] data;

  Bitmap(byte[][] data_, int w_, int h_) {
    data = data_;
    w = w_;
    h = h_;
  }

  ArrayList<BitPoint> getBitPoints() {
    ArrayList<BitPoint> bps = new ArrayList<BitPoint>();

    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        if (data[y][x] == 1) {
          bps.add(new BitPoint(x, y, color(255)));
        }
      }
    }

    return bps;
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
          newArray[y][x] = data[y][x];
        }
      }
    }

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

class BitPoint {
  int x;
  int y;
  color c;

  BitPoint (int x_, int y_, color c_) {
    x = x_;
    y = y_;
    c = c_;
  }
}
