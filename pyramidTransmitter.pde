import processing.serial.*;
import processing.opengl.*;
import java.lang.reflect.Method;
import hypermedia.net.*;
import java.io.*;
import codeanticode.gsvideo.*;

SetList theSetList;
TutorialSimpleSequence foo;

void setup() {
  size(602, 420, P2D);
  frameRate(FRAMERATE);
  setupPyramid();

  //theSetList = new PresetTesting();
  theSetList = new Disor13ntSequence();
}

void draw() {
  background(64);
  theSetList.update();
  image(canvasOut.pg, 0, 0, canvasOut.w, canvasOut.h);
  sign.sendData();
  drawWindowBorders();
}
