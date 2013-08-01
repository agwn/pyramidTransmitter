import processing.serial.*;
import processing.opengl.*;
import java.lang.reflect.Method;
import hypermedia.net.*;
import java.io.*;
import codeanticode.gsvideo.*;

//TechDemo setList;
TutorialPlayer setList;

void setup() {
  size(602, 420, P2D);
  frameRate(FRAMERATE);
  setupCanvases();
  setupSign();
  setList = new TutorialPlayer();
}

void draw() {
  background(64);
  setList.update();
  image(canvasOut.pg, 0, 0, canvasOut.w, canvasOut.h);
  sign.sendData();
  drawWindowBorders();
}
