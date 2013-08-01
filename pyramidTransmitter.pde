import processing.serial.*;
import processing.opengl.*;
import java.lang.reflect.Method;
import hypermedia.net.*;
import java.io.*;
import codeanticode.gsvideo.*;

CanvasRoutineController activePlayer;

// Step 1. Create set list variable
TutorialNoisePlayer tutorialNoise;
Demo demo;

void setup() {
  size(602, 420, P2D);
  frameRate(FRAMERATE);
  setupPyramid();

  // Step 2. Instantiate set list.
  tutorialNoise = new TutorialNoisePlayer();
  demo = new Demo();

  // Step 3. Set active player to set list
  activePlayer = tutorialNoise;
}

void draw() {
  background(64);
  activePlayer.update();
  image(canvasOut.pg, 0, 0, canvasOut.w, canvasOut.h);
  sign.sendData();
  drawWindowBorders();
}
