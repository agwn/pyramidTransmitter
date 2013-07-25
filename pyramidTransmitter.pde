import processing.serial.*;
import processing.opengl.*;
import java.lang.reflect.Method;
import hypermedia.net.*;
import java.io.*;

// *** DEPRECATED!! ***
// If removed, the entire thing breaks.
// If a routine breaks, no worries, it will be reimplemented.
String kbdInput = "";
int lf = int('\n'); // ASCII linefeed
// values set by user input
int[] setVarMin = { 64, 64, 64 };
int[] setVarMax = { 128, 128, 128 };
// values used by program
int[] varMin = { 64, 64, 64 };
int[] varMax = { 128, 128, 128 };
int[] varRange = { 32, 32, 32 };
long modeFrameStart;
int mode = 0;
// Font related
int w = 0;
int x = 64;
void newMode() { }
void newMode(int foo) { }
// *** END DEPRECATED!! ***




// This should be 127.0.0.1, 58802
String transmit_address = "127.0.0.1";
//String transmit_address = "192.168.111.20";
int transmit_port = 58082;

//float bright = 0.10;  // Global brightness modifier
float bright = 1.0;     // For simulation

// Display configuration
int displayWidth = 64;    // 8 columns x 8 pixels
int displayHeight = 210;  // 7 rows x 30 pixels

int FRAMERATE = 60;
int TYPICAL_MODE_TIME = 2048;

CanvasRoutine currentRoutine = null;
LEDDisplay sign;
Serial ctrlPort;
Canvas canvasOut = new Canvas(0, 0, displayWidth, displayHeight);
Canvas canvas1 = new Canvas(64, 0, 474, 210);
Canvas canvas2 = new Canvas(64, 210, 474, 210);

float fadePhase = 0.0;
float fadePhaseInc = 0.005;
SetList setList;

void setup() {
  size(602, 420, P2D);
  frameRate(FRAMERATE);
  setupSign();
  setList = new SetList();
}

void setupSign() {
  sign = new LEDDisplay(this, displayWidth, displayHeight, true, transmit_address, transmit_port);
  sign.setAddressingMode(LEDDisplay.ADDRESSING_HORIZONTAL_NORMAL);
  //sign.setEnableGammaCorrection(true);
  sign.setEnableCIECorrection(true);
}

void draw() {
/*
  canvas1.brightness = fadePhase;
  canvas2.brightness = 1.0 - fadePhase;

  fadePhase += fadePhaseInc;

  if (fadePhase > 1.0) {
    fadePhaseInc *= -1;
    fadePhase = 1.0 - fadePhaseInc;
  }
  if (fadePhase < 0.0) {
    fadePhaseInc *= -1;
    fadePhase = fadePhaseInc;
  }
*/

  setList.update();
  image(canvasOut.pg, 0, 0, canvasOut.w, canvasOut.h);
  sign.sendData();
}
