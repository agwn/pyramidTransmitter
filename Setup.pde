// This should be 127.0.0.1, 58802
String transmit_address = "127.0.0.1";
//String transmit_address = "192.168.111.20";
int transmit_port = 58082;

// Display configuration
int displayWidth = 64;    // 8 columns x 8 pixels
int displayHeight = 210;  // 7 rows x 30 pixels
int FRAMERATE = 60;
int TYPICAL_MODE_TIME = 2048;
LEDDisplay sign;
Serial ctrlPort;
Canvas[] canvases;
Canvas canvas0;
Canvas canvas1;
Canvas canvas2;
Canvas canvas3;

Canvas canvasOut;

void setupPyramid() {
  setupGlobals();
  setupCanvases();
  setupSign();
}

void setupCanvases() {
  canvases = new Canvas[4];
  canvases[0] = new Canvas(64, 0, 474, 210);
  canvases[1] = new Canvas(64, 210, 474, 210);
  canvases[2] = new Canvas(538, 0, 64, 210);
  canvases[3] = new Canvas(538, 210, 64, 210);
  canvas0 = canvases[0];
  canvas1 = canvases[1];
  canvas2 = canvases[2];
  canvas3 = canvases[3];
  canvasOut = new Canvas(0, 0, displayWidth, displayHeight); 
}

void setupSign() {
  sign = new LEDDisplay(this, displayWidth, displayHeight, true, transmit_address, transmit_port);
  sign.bright = 1.0;
  sign.setAddressingMode(LEDDisplay.ADDRESSING_HORIZONTAL_NORMAL);
  //sign.setEnableGammaCorrection(true);
  sign.setEnableCIECorrection(true);
}

void drawWindowBorders() {
  strokeWeight(1);
  stroke(128);
  line(0, 210, width, 210); 
  line(64, 0, 64, 420);
  line(538, 0, 538, 420);
}
