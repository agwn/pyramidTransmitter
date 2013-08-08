class SetListTemplate extends SetList {
  SetListTemplate() { }

  SetListTemplate(SetList setList) {
    super(setList);
  }

  void setup() {
    wait(1.0);
  }
}

class PyramidPartyDemo extends SetList {
  PyramidPartyDemo() { }

  PyramidPartyDemo(SetList setList) {
    super(setList);
  }

  void setup() {
    playSetList(new DisorientProtonInto(this));
    playSetList(new PornjscachInkBlotter(this));
    wait(1.0);
  }
}

class PornjscachInkBlotter extends SetList {
  PornjscachInkBlotter() { }

  PornjscachInkBlotter(SetList setList) {
    super(setList);
  }

  void setup() {
    Pxxxls pxxxls = new Pxxxls(15);
    Pxxxls pxxxlFilter = new Pxxxls(100);
    Waves waves = new Waves();
    Mirror mirror = new Mirror();
    Warp warp = new Warp();
    Grid grid = new Grid();
    Trails trails = new Trails();
    Sparkle sparkle = new Sparkle();
    Sparkle sparkle2 = new Sparkle();
    Breather breather = new Breather();
    float waitTime = 30.0;

    pxxxlFilter.setBlendMode(DODGE);

    pxxxlFilter.setPaintMode(pxxxlFilter.BLEND);

    warp.yAmp = 1.0;
    warp.xAmp = 1.0;
    warp.yFreq = 0.17;
    warp.xFreq = 0.24;

    trails.fade = 240;

    sparkle.threshold = 16;
    sparkle.nDots = 1200;
    sparkle.dotToCrossRatio = 0.95;
    sparkle.setBlendMode(sparkle.DIRECT);
    sparkle.c = color(255, 128);

    sparkle2.nDots = 200;

    breather.setBlendMode(MULTIPLY);
    breather.c0 = color(pornj);
    breather.c1 = color(disorientOrange);
    breather.freq = 0.01;

    setCanvas(canvas3, pxxxls);
    pushCanvas(canvas3, warp);
    pushCanvas(canvas3, trails);
    pushCanvas(canvas3, mirror);
    pushCanvas(canvas3, sparkle);
    pushCanvas(canvas3, breather);
    pushCanvas(canvas3, pxxxlFilter);
    pushCanvas(canvas3, sparkle2);
    wait(waitTime);

    setCanvas(canvas3, waves);
    pushCanvas(canvas3, warp);
    pushCanvas(canvas3, trails);
    pushCanvas(canvas3, mirror);
    pushCanvas(canvas3, sparkle);
    pushCanvas(canvas3, breather);
    pushCanvas(canvas3, pxxxlFilter);
    pushCanvas(canvas3, sparkle2);
    wait(waitTime);

    setCanvas(canvas3, pxxxls);
    pushCanvas(canvas3, warp);
    pushCanvas(canvas3, trails);
    pushCanvas(canvas3, sparkle);
    pushCanvas(canvas3, breather);
    pushCanvas(canvas3, trails);
    pushCanvas(canvas3, pxxxlFilter);
    pushCanvas(canvas3, mirror);
    pushCanvas(canvas3, sparkle2);
    wait(waitTime);

    setCanvas(canvas3, pxxxls);
    pushCanvas(canvas3, warp);
    pushCanvas(canvas3, trails);
    pushCanvas(canvas3, mirror);
    pushCanvas(canvas3, sparkle);
    pushCanvas(canvas3, breather);
    pushCanvas(canvas3, trails);
    pushCanvas(canvas3, pxxxlFilter);
    pushCanvas(canvas3, sparkle2);
    wait(waitTime);
  }
}

class DisorientProtonInto extends SetList {
  DisorientProtonInto() { }

  DisorientProtonInto(SetList setList) {
    super(setList);
  }

  void setup() {
    PixelPopping pixelPopping = new PixelPopping(disFont.getBitmap("disorient").getBitmap(true, true, false).getBitPoints());
    PixelPopping pixelPopping2 = new PixelPopping(disFont.getBitmap("disorient").getBitmap(true, false, false).getBitPoints());
    Breather breather = new Breather();
    Sparkle sparkle = new Sparkle();
    Sparkle sparkle2 = new Sparkle();
    ProtonPack protonPack = new ProtonPack();

    pixelPopping.x = 24;
    pixelPopping.y = 26;
    pixelPopping.yPad = 1;
    pixelPopping.pointsPerFrame = 4;

    pixelPopping2.x = 32;
    pixelPopping2.y = 26;
    pixelPopping2.yPad = 1;
    pixelPopping2.pointsPerFrame = 4;

    breather.setBlendMode(MULTIPLY);
    breather.c0 = color(pornj);
    breather.c1 = color(lerpColor(disorientOrange, color(0), 0.7));
    breather.freq = 0.5;

    sparkle.threshold = 16;
    sparkle.nDots = 1200;
    sparkle.dotToCrossRatio = 1.0;
    sparkle.c = color(255, 128);

    sparkle2.threshold = 16;
    sparkle2.nDots = 1200;
    sparkle2.dotToCrossRatio = 1.0;
    sparkle2.c = color(255, 128);

    protonPack.resolution = 1;
    protonPack.freq = -0.25; 
    protonPack.strokeWeight0 = 2;
    protonPack.c0 = color(255, 255, 0, 16);
    protonPack.c1 = color(255, 0, 0, 64);
    protonPack.nCycles = 0.333;

    setCanvas(canvas3, protonPack);
    pushCanvas(canvas3, sparkle);
    fadeIn(5.0, canvas3);

    setCanvas(canvas2, pixelPopping); 
    pushCanvas(canvas2, pixelPopping2);
    pushCanvas(canvas2, breather);
    pushCanvas(canvas2, sparkle2);
    wait(6.0);

    fadeOut(5.0, canvas3);
    wait(6.0);
  }
}

class TechDemo extends SetList {
  TechDemo() { }

  TechDemo(SetList setList) {
    super(setList);
  }

  void setup() {
    WarpSpeedMrSulu warpSpeed = new WarpSpeedMrSulu();
    ProtonPack protonPack = new ProtonPack();
    Pxxxls pxxxls = new Pxxxls(50);
    Waves waves = new Waves();
    Seizure seizure = new Seizure();
    Mirror mirror = new Mirror();

    float w = 5.0;

    setCanvas(canvas0, pxxxls);
    wait(w);
    setCanvas(canvas2, warpSpeed);
    wait(w);
    setCanvas(canvas1, waves);
    wait(w);
    setCanvas(canvas3, protonPack);
    wait(w);
    disableCanvas(canvas0); 
    wait(w);
    disableCanvas(canvas2); 
    wait(w);
    disableCanvas(canvas1); 
    wait(w);
    crossfade(w, canvas3, canvas0);
    crossfade(w, canvas0, canvas1);
    crossfade(w, canvas1, canvas2);
    wait(w);
    pushCanvas(canvas2, waves);
    wait(w);
    pushCanvas(canvas2, protonPack);
    wait(w);
    pushCanvas(canvas2, mirror);
    wait(w);
    pushCanvas(canvas2, pxxxls);
    wait(w);
    disableCanvas(canvas0);
    disableCanvas(canvas1);
    disableCanvas(canvas3);
    setCanvas(canvas2, seizure);
    wait(1.0);
    disableCanvas(canvas2);
  }
}

class Demo extends SetList {
  Demo() { } 

  Demo(SetList setList) {
    super(setList);
  }

  void setup() {
    float w = 10.0;  // Wait time between routines

    WarpSpeedMrSulu warpSpeed = new WarpSpeedMrSulu(100);
    Warp warp = new Warp();
    Mirror mirror = new Mirror();
    Waves waves = new Waves();

    Pxxxls pxxxls = new Pxxxls(50);
    Pxxxls pxxxlFilter = new Pxxxls(50);
    pxxxlFilter.setBlendMode(DODGE);
    pxxxlFilter.setPaintMode(pxxxlFilter.BLEND);

    setCanvas(canvas2, warpSpeed);
    wait(w);
    pushCanvas(canvas2, warp);
    wait(w);
    pushCanvas(canvas2, mirror);
    wait(w);

    setCanvas(canvas2, pxxxls);
    wait(w);
    setCanvas(canvas2, waves);
    wait(w);
    pushCanvas(canvas2, pxxxlFilter);
    wait(w);
    pushCanvas(canvas2, warp);
    wait(w);
    pushCanvas(canvas2, mirror);
    wait(w);
    pushCanvas(canvas2, warpSpeed);
    wait(w);
  }
}

class DebuggingSetList extends SetList {
  DebuggingSetList() { }

  DebuggingSetList(SetList setList) {
    super(setList);
  }

  void setup() {
    PixelPopping pixelPopping = new PixelPopping(disFont.getBitmap("disorient").getBitmap(true, true, false).getBitPoints());
    PixelPopping pixelPopping2 = new PixelPopping(disFont.getBitmap("disorient").getBitmap(true, false, false).getBitPoints());
    Breather breather = new Breather();
    Sparkle sparkle = new Sparkle();
    ProtonPack protonPack = new ProtonPack();

    pixelPopping.x = 24;
    pixelPopping.y = 26;
    pixelPopping.yPad = 1;
    pixelPopping.pointsPerFrame = 4;

    pixelPopping2.x = 32;
    pixelPopping2.y = 26;
    pixelPopping2.yPad = 1;
    pixelPopping2.pointsPerFrame = 4;

    breather.setBlendMode(MULTIPLY);
    breather.c0 = color(pornj);
    breather.c1 = color(lerpColor(disorientOrange, color(0), 0.7));
    breather.freq = 0.5;

    sparkle.threshold = 16;
    sparkle.nDots = 1200;
    sparkle.dotToCrossRatio = 1.0;
    sparkle.c = color(255, 128);

    protonPack.resolution = 1;
    protonPack.freq = -0.25; 
    protonPack.strokeWeight0 = 2;
    protonPack.c0 = color(255, 255, 0, 16);
    protonPack.c1 = color(255, 0, 0, 64);
    protonPack.nCycles = 0.333;

    setCanvas(canvas2, pixelPopping); 
    pushCanvas(canvas2, pixelPopping2);
    pushCanvas(canvas2, breather);
    pushCanvas(canvas2, protonPack);
    pushCanvas(canvas2, sparkle);
    wait(60.0);
    playSetList(new TechDemo(this));
    playSetList(new Demo(this));
  }
}

