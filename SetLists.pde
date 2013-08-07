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
    Breather breather = new Breather();
    Warp warp = new Warp();
    Sparkle sparkle = new Sparkle();
    ProtonPack protonPack = new ProtonPack();

    pixelPopping.x = 24;
    pixelPopping.y = 30;
    pixelPopping.yPad = 1;
    pixelPopping.pointsPerFrame = 4;
    breather.setBlendMode(MULTIPLY);
    breather.c0 = color(pornj, 255);
    breather.c1 = color(lerpColor(pornj, color(0), 0.7));
    breather.freq = 2.0;
    sparkle.threshold = 16;
    sparkle.nDots = 1200;
    sparkle.dotToCrossRatio = 1.0;
    sparkle.c = color(255, 128);
    warp.yFreq = 1.0;
    warp.yAmp = 0.125;
    warp.xFreq = 0.5;
    warp.xAmp = 0.1;
    protonPack.resolution = 1;
    protonPack.freq = -0.25; 
    protonPack.strokeWeight0 = 2;
    protonPack.c0 = color(255, 255, 0, 16);
    protonPack.c1 = color(255, 0, 0, 64);
    protonPack.nCycles = 0.333;

    setCanvas(canvas2, pixelPopping); 
    pushCanvas(canvas2, breather);
    pushCanvas(canvas2, protonPack);
    pushCanvas(canvas2, sparkle);
    wait(60.0);
    playSetList(new Testing123(this));
    playSetList(new TechDemo(this));
    playSetList(new Demo(this));
  }
}

class Testing123 extends SetList {
  Testing123() { }

  Testing123(SetList setList) {
    super(setList);
  }

  void setup() {
    WarpSpeedMrSulu warpSpeed = new WarpSpeedMrSulu(20);
    setCanvas(canvas3, warpSpeed);
    wait(1.0);
  }
}
