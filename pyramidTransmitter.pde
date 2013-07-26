import processing.serial.*;
import processing.opengl.*;
import java.lang.reflect.Method;
import hypermedia.net.*;
import java.io.*;

// This should be 127.0.0.1, 58802
String transmit_address = "127.0.0.1";
//String transmit_address = "192.168.111.20";
int transmit_port = 58082;

//float bright = 0.10;  // Global brightness modifier
float bright = 1.0;  // For simulation

// Display configuration
int displayWidth = 2*32;
int displayHeight = 30*7;
//int displayWidth = 60;
//int displayHeight = 24;

boolean VERTICAL = false;
int FRAMERATE = 30;
int TYPICAL_MODE_TIME = 2048;

Routine drop = new Seizure();
Routine backupRoutine = null;

int w = 0;
int x = displayWidth;
PFont font;
int ZOOM = 1;

long modeFrameStart;
int mode = 0;

int direction = 1;
int position = 0;
Routine currentRoutine = null;

LEDDisplay sign;

PGraphics fadeLayer;
int fadeOutFrames = 0;
int fadeInFrames = 0;

Serial ctrlPort;

String kbdInput = "";
int lf = int('\n'); // ASCII linefeed

// defining limits for use input
final int PWM_MIN_VAL = 0;
final int PWM_MAX_VAL = 0xff;
final int PWM_DEF_VAL = int(((PWM_MAX_VAL+PWM_MIN_VAL)/2.0));

final float rOffset = PWM_DEF_VAL/float(PWM_MAX_VAL);
final float gOffset = PWM_DEF_VAL/float(PWM_MAX_VAL);
final float bOffset = PWM_DEF_VAL/float(PWM_MAX_VAL);

// modulating background color
//float oSpeed = .000075;
float oSpeed = 0.00025;

// values set by user imput
int[] setVarMin = {
  64, 64, 64
};
int[] setVarMax = {
  128, 128, 128
};

// values used by program
int[] varMin = {
  64, 64, 64
};
int[] varMax = {
  128, 128, 128
};
int[] varRange = {
  32, 32, 32
};

Routine[] enabledRoutines = new Routine[] {
  new Fire(),
  //new ColorTest(), 
  //new RGBRoutine(),

  new Warp(new WarpSpeedMrSulu(), true, true, 0.3, 0.2), 
  //new WarpSpeedMrSulu(), 
  //new RGBRoutine(), 
  //new Warp(new RGBRoutine(), true, true, 0.15, 0.2), 
  //new RainbowColors(), 
  //new Warp(new RainbowColors(), true, true, 0.5, 0.5), 
  new Warp(null, true, false, 0.3, 0.3), 
  //new Waves(), 
  //new ColorDrop(), 
  //new Warp(new ColorDrop(), true, true, 0.5, 0.5), 
  //new Bursts(), 
  new Warp(new Bursts(), true, true, 0.2, 0.2), 
  //new Chase(), 
  new Warp(new Chase(), true, true, 0.3, 0.3), 
  new Greetz(), 
  new FFTDemo(), 
  new DropTheBomb(), 
  new Fire(),
};


void setup() {
  size(displayWidth, displayHeight);

  frameRate(FRAMERATE);

  sign = new LEDDisplay(this, displayHeight, displayWidth, true, transmit_address, transmit_port);
  sign.setAddressingMode(LEDDisplay.ADDRESSING_HORIZONTAL_NORMAL);
  //sign.setEnableGammaCorrection(true);
  sign.setEnableCIECorrection(true);

  setMode(0);

  // configure serial input
  String[] list = Serial.list();
  delay(20);
  println("Serial Ports List:");
  println(list);

  // The first serial port on my mac is the Arduino so I just open that.
  // Consult the output of println(Serial.list()); to figure out which you
  // should be using.
  if (false /*Serial.list().length > 0*/) {
    //ctrlPort = new Serial(this, Serial.list()[0], 38400);
    ctrlPort = new Serial(this, "COM51", 38400);
    //ctrlPort = new Serial(this, "/dev/ttyUSB0", 38400);

    // Fire a serialEvent() when when a linefeed comes in to the serial port.
    ctrlPort.bufferUntil('\n');
    ctrlPort.write(lf);
  }
  for (Routine r : enabledRoutines) {
    r.setup(this);
  }

  drop.setup(this);
}

void setFadeLayer(int g) {
  fadeLayer = createGraphics(displayWidth, displayHeight, P2D);
  fadeLayer.beginDraw();
  fadeLayer.stroke(g);
  fadeLayer.fill(g);
  fadeLayer.rect(0, 0, displayWidth, displayHeight);
  fadeLayer.endDraw();
}

void setMode(int newMode) {
  currentRoutine = enabledRoutines[newMode];

  mode = newMode;
  modeFrameStart = frameCount;
  println("New mode " + currentRoutine.getClass().getName());

  currentRoutine.reset();
}

void newMode() {
  int newMode = mode;
  String methodName;

  fadeOutFrames = FRAMERATE;
  setFadeLayer(240);
  if (enabledRoutines.length > 1) {
    while (newMode == mode) {
      newMode = int((mode+1)%(enabledRoutines.length-2));
    }
  }

  setMode(newMode);
}


void newMode(int mode) {
  int newMode = mode;
  String methodName;

  fadeOutFrames = FRAMERATE;
  setFadeLayer(240);
  if ((mode >= 0) && (mode < enabledRoutines.length)) {
    newMode = mode;
  }
  else {
    if (enabledRoutines.length > 1) {
      while (newMode == mode) {
        newMode = int((mode+1)%(enabledRoutines.length-2));
      }
    }
  }

  setMode(newMode);
}

void handleInput(String s) {
  // Removes whitespace before and after string
  s = trim(s);
  //println("received: "+s+" len: "+s.length());
  if (s.length() > 0) {
    // validate and process input
    switch (s.charAt(0)) {
    case 'm': // mode change
      if (s.length() > 1) {
        // mode change
        if ('c' == s.charAt(1) && !switching_mode) {
          newMode();
          switching_mode = true;
        }
        else if (/*('0' <= s.charAt(1)) && (s.charAt(1) <='9') &&*/ (int(s.substring(1)) < enabledRoutines.length) && !switching_mode) {
          //println("int: "+int(s.substring(1)));
          if (mode != (s.charAt(1)-'0')) {
            mode = s.charAt(1)-'0';
            newMode(mode);
            switching_mode = true;
          } // else already in that mode
        }
        else {
          println("Invalid mode selected");
        }
      }
      break;

    case 'b':  // button pressed
      if (s.length() > 1) {
        char buttonID = s.charAt(1);
        switch (buttonID) {
        case '0':
          // do something
          if (!switching_mode) {
            newMode();
            switching_mode = true;
          }
          break;
        case '1':
          // drop the bomb
          if (!switching_mode) {
            newMode(enabledRoutines.length-1);
            switching_mode = true;
          }
          break;
        case '2':
          // reset to mode 0
          if (!switching_mode) {
            newMode(0);
            switching_mode = true;
          }
          break;
        default:
          // complain
          break;
        }
      }
      break;

    case 'v': // set parameter
      if (s.length() > 9) {
        if (s.substring(0, 3).equals("var")) { // setting a variable
          int varID = int(s.substring(3, 4));

          if (s.substring(4, 7).equals("max")) {
            //println("var"+varID+" max: "+s.substring(7, 10));
            varMax[varID] = setVarMax[varID] = int(s.substring(7, 10));
          }
          else if (s.substring(4, 7).equals("min")) {
            //println("var"+varID+" min: "+s.substring(7, 10));
            varMin[varID] = setVarMin[varID] = int(s.substring(7, 10));
          }
          varRange[varID] = (int)((setVarMax[varID] - setVarMin[varID])/2);
        }
      }
      break;
    default:
      println("Invalid command!");
      break;
    }
  }
}


// Buffer a string until a linefeed is encountered then process as control command.
void keyPressed() {
  if (key < 255) {
    kbdInput += str(key);
    if (key == lf) {
      print("from KB: " + kbdInput);
      handleInput(kbdInput);

      kbdInput = "";
    }
  }
}


// Process a line of text from the serial port.
void serialEvent(Serial ctrlPort) {
  // Reads input until it receives a new line character
  String inString = ctrlPort.readStringUntil('\n');
  if (inString != null) {
    // Removes whitespace before and after string
    inString = trim(inString);
    // validate and parse string
    //println("from SP: " + inString);
    handleInput(inString);
  }
}

void updateColor() {
  float tm = oSpeed * millis();

  /*
  // modulate between bounds
   varMin[0] = (int)constrain(setVarMin[0]+(varRange[0]*(sin(tm)/2+rOffset)), PWM_MIN_VAL, PWM_MAX_VAL);
   varMax[0] = (int)constrain(setVarMax[0]+(varRange[0]*(sin(tm)/2+rOffset)), PWM_MIN_VAL, PWM_MAX_VAL);
   varMin[1] = (int)constrain(setVarMin[1]+(varRange[1]*(sin(tm+TWO_PI/3)/2+gOffset)), PWM_MIN_VAL, PWM_MAX_VAL);
   varMax[1] = (int)constrain(setVarMax[1]+(varRange[1]*(sin(tm+TWO_PI/3)/2+gOffset)), PWM_MIN_VAL, PWM_MAX_VAL);
   varMin[2] = (int)constrain(setVarMin[2]+(varRange[2]*(sin(tm+2*TWO_PI/3)/2+bOffset)), PWM_MIN_VAL, PWM_MAX_VAL);
   varMax[2] = (int)constrain(setVarMax[2]+(varRange[2]*(sin(tm+2*TWO_PI/3)/2+bOffset)), PWM_MIN_VAL, PWM_MAX_VAL);
   */

  // modulate across full range
  varMin[0] = (int)constrain(setVarMin[0]+(PWM_DEF_VAL*(sin(tm)/2+rOffset)), PWM_MIN_VAL, PWM_MAX_VAL);
  varMax[0] = (int)constrain(setVarMax[0]+(PWM_DEF_VAL*(sin(tm)/2+rOffset)), PWM_MIN_VAL, PWM_MAX_VAL);
  varMin[1] = (int)constrain(setVarMin[1]+(PWM_DEF_VAL*(sin(tm+TWO_PI/3)/2+gOffset)), PWM_MIN_VAL, PWM_MAX_VAL);
  varMax[1] = (int)constrain(setVarMax[1]+(PWM_DEF_VAL*(sin(tm+TWO_PI/3)/2+gOffset)), PWM_MIN_VAL, PWM_MAX_VAL);
  varMin[2] = (int)constrain(setVarMin[2]+(PWM_DEF_VAL*(sin(tm+2*TWO_PI/3)/2+bOffset)), PWM_MIN_VAL, PWM_MAX_VAL);
  varMax[2] = (int)constrain(setVarMax[2]+(PWM_DEF_VAL*(sin(tm+2*TWO_PI/3)/2+bOffset)), PWM_MIN_VAL, PWM_MAX_VAL);
}

boolean switching_mode = false; // if true, we already switched modes, so don't do it again this frame (don't freeze the display if someone holds the b button)
int seizure_count = 10;  // Only let seizure mode work for a short time.

void draw() {
  // update color offsets
  updateColor();

  // should test if mode switch is actually done?
  switching_mode = false;

  if (fadeOutFrames > 0) {
    fadeOutFrames--;


    if (fadeOutFrames == 0) {
      fadeInFrames = FRAMERATE;
    }
  }
  else if (currentRoutine != null) {
    currentRoutine.draw();
  }
  else {
    println("Current method is null");
  }

  if (fadeInFrames > 0) {
    setFadeLayer(240 - fadeInFrames * (240 / FRAMERATE));
    blend(fadeLayer, 0, 0, displayWidth, displayHeight, 0, 0, displayWidth, displayHeight, MULTIPLY);
    fadeInFrames--;
  }

  if (currentRoutine.isDone) {
    currentRoutine.isDone = false;
    //newMode();
  }

  sign.sendData();
}

