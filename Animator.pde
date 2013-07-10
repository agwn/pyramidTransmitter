/**
 * Display an animation based on a set of PNG images
 */
class Animator extends Routine {
  boolean loaded = false;

  Animation anim;
  String m_name;
  int m_frameDivider;
  float m_xVelocity;
  float m_yVelocity;
  float m_xOffset;
  float m_yOffset;

  // Create an animation routine using the specificed name
  Animator(String name, int frameDivider, float xVelocity, float yVelocity, float xOffset, float yOffset) {
    m_name = name;
    m_frameDivider = frameDivider;
    m_xVelocity = xVelocity;
    m_yVelocity = yVelocity;
    m_xOffset = xOffset;
    m_yOffset = yOffset;
  }

  void reset() {
    if (!loaded) {
      anim = new Animation(m_name, m_frameDivider);
      loaded=true;
    }
  }

  void draw() {
    background(0);

    float frame_mult = 3;  // speed adjustment

    long frame = frameCount;

    // Draw four images, in case we are wrapping
    float xNominal = (frame*m_xVelocity + m_xOffset)%width;
    float yNominal = (frame*m_yVelocity + m_yOffset)%height;

    image(anim.update(), xNominal, yNominal);
    image(anim.update(), xNominal - width, yNominal);
    image(anim.update(), xNominal - width, yNominal - height);
    image(anim.update(), xNominal, yNominal - height);

    if (frame > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    }
  }
}

class Animation {
  PImage[] frames;
  int frameNumber;
  int frameDivider;
  PGraphics canvas;

  Animation(String _name, int _frameDivider) {

    canvas = createGraphics(width, height, P2D);
    frameNumber = 0;
    frameDivider = _frameDivider;
    load(_name);
  }

  /*
  void load(String name) {
   File dir = new File(savePath("data/" + name));
   String[] numFiles = dir.list();
   println(numFiles.length);
   frames = new PImage[numFiles.length];
   for (int i=0; i<frames.length; i++) {
   println("Loading " + name + "/frame" + (i+1) + ".png");
   frames[i] = loadImage(name + "/frame" + (i+1) + ".png");
   //frames[i].filter(INVERT);
   }
   }
   */

  void load(String name) {
    int filesCounter=0;
    File dataFolder = new File(sketchPath, "data/"+name);
    String[] allFiles = dataFolder.list();
    try {
      for (int j=0;j<allFiles.length;j++) {
        if (allFiles[j].toLowerCase().endsWith("png")) {
          filesCounter++;
        }
      }
    }
    catch(Exception e) {
    }
    frames = new PImage[filesCounter];
    for (int i=0; i<frames.length; i++) {
      println("Loading " + name + "/frame" + (i+1) + ".png");
      frames[i] = loadImage(name + "/frame" + (i+1) + ".png");
      //frames[i].filter(INVERT);
    }
  }

  PImage update() {
    if (frameCount % frameDivider == 0) {
      frameNumber++;
      if (frameNumber >= frames.length) {
        frameNumber = 0;
      }
    }
    canvas.beginDraw();
    if (frames[frameNumber].width==width&&frames[frameNumber].height==height) {
      canvas.image(frames[frameNumber], 0, 0);
    }
    else if (frames[frameNumber].width<width&&frames[frameNumber].height<height) {
      canvas.image(frames[frameNumber], 0, 0, width, height);
    }
    else {
      canvas.loadPixels();
      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          int loc1 = x + (y * width);
          int loc2 = (x*(round(float(frames[frameNumber].width)/float(width)))) + ((y*(round(float(frames[frameNumber].height)/float(height)))) * frames[frameNumber].width);
          try {
            canvas.pixels[loc1] = frames[frameNumber].pixels[loc2];
          }
          catch(Exception e) {
          }
        }
      }
    }
    canvas.updatePixels();
    canvas.endDraw();
    return canvas;
  }
}
