import processing.serial.*;
import processing.opengl.*;
import java.lang.reflect.Method;
import hypermedia.net.*;
import java.io.*;
import codeanticode.gsvideo.*;

SetList setList;

// Step 1. Create set list variable
PyramidPartyDemo pyramidPartyDemo;
TutorialNoisePlayer tutorialNoise;
TutMovingLinesSet tutMovingLines;
TutorialSimpleSequence tutorialSimpleSequence;
TechDemo techDemo;
Demo demo;
DebuggingSetList debuggingSetList;
DisorientProtonIntro disorientProtonIntro;
UncertainSetList uncertainSetList;
Tester tester;

void setup() {
  size(602, 420, P2D);
  frameRate(FRAMERATE);
  setupPyramid();

  // Step 2. Instantiate set list.
  pyramidPartyDemo = new PyramidPartyDemo();
  tutorialNoise = new TutorialNoisePlayer();  
  tutMovingLines = new TutMovingLinesSet();
  tutorialSimpleSequence = new TutorialSimpleSequence();
  techDemo = new TechDemo();
  demo = new Demo();
  debuggingSetList = new DebuggingSetList();
  disorientProtonIntro = new DisorientProtonIntro();
  uncertainSetList = new UncertainSetList();
  tester = new Tester();

  // Step 3. Set active player to set list
  //setList = pyramidPartyDemo;
  //setList = uncertainSetList;
  setList = tester;
}

void draw() {
  background(64);
  setList.update();
  image(canvasOut.pg, 0, 0, canvasOut.w, canvasOut.h);
  sign.sendData();
  drawWindowBorders();
}
