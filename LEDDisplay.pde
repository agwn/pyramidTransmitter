import hypermedia.net.*;

/**
 * This class can be added to your sketches to make them compatible with an LED display.
 * Use Sketch..Add File and choose this file to copy it into your sketch.
 *
 * void setup() {
 *   // Constructor takes this, width, height.
 *   Dacwes dacwes = new Dacwes(this, 16, 16);
 *
 *   // Change this depending on how the sign is configured.
 *   dacwes.setAddressingMode(Dacwes.ADDRESSING_VERTICAL_FLIPFLOP);
 *
 *   // Include this to talk to the emulator.
 *   dacwes.setAddress("127.0.0.1");
 *
 *   // The class will scale things for you, but it may not be full brightness
 *   // unless you match the size.
 *   size(320,320);
 * }
 *
 * void draw() {
 *   doStuff();
 *
 *   // Call this in your draw loop to send data to the sign.
 *   dacwes.sendData();
 * }
 *
 **/

// CIE correction table

//static final int CIE16bit[] = 
//{
//  0, 662, 1320, 1974, 2623, 3267, 3908, 4543, 
//  5175, 5802, 6424, 7043, 7657, 8266, 8872, 9473, 
//  10070, 10662, 11251, 11835, 12415, 12990, 13562, 14129, 14693, 15252, 15807, 16358, 16905, 17447, 17986, 18521, 
//  19051, 19578, 20101, 20619, 21134, 21645, 22152, 22654, 23153, 23649, 24140, 24627, 25111, 25590, 26066, 26539, 
//  27007, 27471, 27932, 28389, 28843, 29292, 29738, 30181, 30619, 31054, 31486, 31913, 32338, 32758, 33175, 33589, 
//  33999, 34405, 34808, 35207, 35603, 35996, 36385, 36770, 37153, 37531, 37907, 38279, 38647, 39013, 39375, 39733, 
//  40089, 40441, 40790, 41135, 41478, 41817, 42153, 42486, 42815, 43142, 43465, 43785, 44102, 44416, 44727, 45035, 
//  45340, 45641, 45940, 46236, 46529, 46818, 47105, 47389, 47670, 47948, 48223, 48495, 48764, 49031, 49295, 49555, 
//  49813, 50069, 50321, 50571, 50818, 51062, 51304, 51542, 51778, 52012, 52243, 52471, 52696, 52919, 53140, 53357, 
//  53572, 53785, 53995, 54203, 54408, 54610, 54810, 55008, 55203, 55396, 55586, 55774, 55960, 56143, 56324, 56503, 
//  56679, 56853, 57024, 57194, 57361, 57525, 57688, 57848, 58007, 58163, 58316, 58468, 58618, 58765, 58910, 59053, 
//  59195, 59334, 59471, 59606, 59739, 59870, 59999, 60126, 60251, 60374, 60495, 60614, 60732, 60847, 60961, 61072, 
//  61182, 61290, 61397, 61501, 61604, 61705, 61804, 61902, 61998, 62092, 62184, 62275, 62364, 62451, 62537, 62621, 
//  62704, 62785, 62865, 62943, 63019, 63094, 63167, 63239, 63310, 63379, 63446, 63512, 63577, 63640, 63702, 63763, 
//  63822, 63880, 63937, 63992, 64046, 64099, 64150, 64200, 64249, 64297, 64344, 64389, 64433, 64476, 64518, 64559, 
//  64599, 64637, 64675, 64711, 64747, 64781, 64815, 64847, 64878, 64909, 64938, 64967, 64995, 65024, 65052, 65081, 
//  65109, 65138, 65166, 65195, 65223, 65251, 65280, 65308, 65337, 65365, 65394, 65422, 65451, 65479, 65508, 65535
//};

static final short CIE8bit[] =
{
  0, 2, 5, 7, 10, 12, 15, 17, 20, 22, 25, 27, 29, 32, 34, 37, 39, 41, 43, 46, 48, 50, 52, 55, 57, 59, 61, 63, 66, 68, 70, 72, 
  74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, 98, 99, 101, 103, 105, 107, 109, 110, 112, 114, 116, 117, 119, 121, 
  122, 124, 126, 127, 129, 131, 132, 134, 135, 137, 139, 140, 142, 143, 145, 146, 148, 149, 150, 152, 153, 155, 156, 
  157, 159, 160, 162, 163, 164, 165, 167, 168, 169, 171, 172, 173, 174, 175, 177, 178, 179, 180, 181, 182, 184, 185, 
  186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 204, 205, 206, 207, 
  208, 209, 210, 210, 211, 212, 213, 214, 214, 215, 216, 217, 217, 218, 219, 220, 220, 221, 222, 222, 223, 224, 224, 
  225, 225, 226, 227, 227, 228, 228, 229, 230, 230, 231, 231, 232, 232, 233, 233, 234, 234, 235, 235, 236, 236, 237, 
  237, 238, 238, 238, 239, 239, 240, 240, 241, 241, 241, 242, 242, 242, 243, 243, 243, 244, 244, 244, 245, 245, 245, 
  246, 246, 246, 247, 247, 247, 247, 248, 248, 248, 248, 249, 249, 249, 249, 249, 250, 250, 250, 250, 250, 251, 251, 
  251, 251, 251, 252, 252, 252, 252, 252, 252, 252, 253, 253, 253, 253, 253, 253, 253, 253, 254, 254, 254, 254, 254, 
  254, 254, 254, 254, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255
};

public class LEDDisplay {
  public static final int ADDRESSING_VERTICAL_NORMAL = 1;
  public static final int ADDRESSING_VERTICAL_HALF = 2;
  public static final int ADDRESSING_VERTICAL_FLIPFLOP = 3;
  public static final int ADDRESSING_HORIZONTAL_NORMAL = 4;
  public static final int ADDRESSING_HORIZONTAL_HALF = 5;
  public static final int ADDRESSING_HORIZONTAL_FLIPFLOP = 6;

  PApplet parent;
  UDP udp;
  String address;
  int port;
  int w;
  int h;
  int addressingMode;
  byte buffer[];
  int pixelsPerChannel;
  float gammaValue = 2.5;
  boolean enableGammaCorrection = false;
  boolean enableCIECorrection = false;
  boolean isRGB = false;

  public LEDDisplay(PApplet parent, int w, int h, boolean isRGB, String address, int port) {
    this.parent = parent;
    this.udp = new UDP(parent);
    this.address = address;
    this.port = port;
    this.w = w;
    this.h = h;
    this.isRGB = isRGB;
    int bufferSize = (isRGB ? 3 : 1)*(w*h)+1;
    buffer = new byte[bufferSize];
    this.addressingMode = ADDRESSING_HORIZONTAL_NORMAL;
    // TODO Detect this based on VERTICAL (h/2) vs. HORIZONTAL (w/2)
    this.pixelsPerChannel = 8;

    for (int i=0; i<bufferSize; i++) {
      buffer[i] = 0;
    }
  }

  public void setAddress(String address) {
    this.address = address;
  }

  public void setPort(int port) {
    this.port = port;
  }

  public void setAddressingMode(int mode) {
    this.addressingMode = mode;
  }

  public void setPixelsPerChannel(int n) {
    this.pixelsPerChannel = n;
  }

  public void setGammaValue(float gammaValue) {
    this.gammaValue = gammaValue;
  }

  public void setEnableGammaCorrection(boolean enableGammaCorrection) {
    this.enableGammaCorrection = enableGammaCorrection;
  }

  public void setEnableCIECorrection(boolean enableCIECorrection) {
    this.enableCIECorrection = enableCIECorrection;
  }

  private int getAddress(int x, int y) {
    if (addressingMode == ADDRESSING_VERTICAL_NORMAL) {
      return (x * h + y);
    }
    else if (addressingMode == ADDRESSING_VERTICAL_HALF) {
      return ((y % pixelsPerChannel) + floor(y / pixelsPerChannel)*pixelsPerChannel*w + x*pixelsPerChannel);
    }
    else if (addressingMode == ADDRESSING_VERTICAL_FLIPFLOP) {
      if (y>=pixelsPerChannel) {
        int endAddress = (x+1) * h - 1;
        int address = endAddress - (y % pixelsPerChannel);
        return address;
      }
      else {
        return (x * h + y);
      }
    }
    else if (addressingMode == ADDRESSING_HORIZONTAL_NORMAL) {
      return (y * w + x);
    }
    else if (addressingMode == ADDRESSING_HORIZONTAL_HALF) {
      return ((x % pixelsPerChannel) + floor(x / pixelsPerChannel)*pixelsPerChannel*h + y*pixelsPerChannel);
    }
    else if (addressingMode == ADDRESSING_HORIZONTAL_FLIPFLOP) {
      if (x>=pixelsPerChannel) {
        int endAddress = (y+1) * w - 1;
        int address = endAddress - (x % pixelsPerChannel);
        return address;
      }
      else {
        return (y * h + x);
      }
    }

    return 0;
  }

  public void sendMode(String modeName) {
    byte modeBuffer[] = new byte[modeName.length()+1];

    modeBuffer[0] = 2;
    for (int i = 0; i < modeName.length(); i++) {
      modeBuffer[i+1] = (byte)modeName.charAt(i);
    }

    udp.send(modeBuffer, address, port);
  }

  public void sendData() {
    PImage image = get(0, 0, w, h);

    //if (image.width != w || image.height != h) {
    //  image.resize(w,h);
    //}

    image.loadPixels();
    loadPixels();

    int r;
    int g;
    int b;
    buffer[0] = 1;
    for (int y=0; y<h; y++) {
      for (int x=0; x<w; x++) {
        int loc = getAddress(x, y);

        if (isRGB) {
          r = int(red(image.pixels[y*w+x]));
          g = int(green(image.pixels[y*w+x]));
          b = int(blue(image.pixels[y*w+x]));

          if (enableGammaCorrection) {
            r = (int)(Math.pow(r/256.0, this.gammaValue)*256*bright);
            g = (int)(Math.pow(g/256.0, this.gammaValue)*256*bright);
            b = (int)(Math.pow(b/256.0, this.gammaValue)*256*bright);
          }
          else if (enableCIECorrection) {
            r = (int)(CIE8bit[int(r*bright)]);
            g = (int)(CIE8bit[int(g*bright)]);
            b = (int)(CIE8bit[int(b*bright)]);
          }


          buffer[(loc*3)+1] = byte(r);
          buffer[(loc*3)+2] = byte(g);
          buffer[(loc*3)+3] = byte(b);
        }
        else {
          r = int(brightness(image.pixels[y*w+x]));

          if (enableGammaCorrection) {
            r = (int)(Math.pow(r/256.0, this.gammaValue)*256);
          }

          buffer[(getAddress(x, y)+1)] = byte(r);
        }
      }
    }
    updatePixels();

    udp.send(buffer, address, port);
  }
}

