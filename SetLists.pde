class TechDemo extends SetList {
  TechDemo() { }

  TechDemo(SetList setList) {
    super(setList);
  }

  void setup() {
    WarpSpeedMrSulu warpSpeed = new WarpSpeedMrSulu();
    SineColumns sines = new SineColumns();
    Pxxxls pxxxls = new Pxxxls(50);
    Waves waves = new Waves();
    Seizure seizure = new Seizure();
    Mirror mirror = new Mirror();

    float w = 5.0;
    Canvas c0 = canvases[0];
    Canvas c1 = canvases[1];
    Canvas c2 = canvases[2];
    Canvas c3 = canvases[3];

    setCanvas(c0, pxxxls);
    wait(w);
    setCanvas(c2, warpSpeed);
    wait(w);
    setCanvas(c1, waves);
    wait(w);
    setCanvas(c3, sines);
    wait(w);
    disableCanvas(c0); 
    wait(w);
    disableCanvas(c2); 
    wait(w);
    disableCanvas(c1); 
    wait(w);
    crossfade(w, c3, c0);
    crossfade(w, c0, c1);
    crossfade(w, c1, c2);
    wait(w);
    pushCanvas(c2, waves);
    wait(w);
    pushCanvas(c2, sines);
    wait(w);
    pushCanvas(c2, mirror);
    wait(w);
    pushCanvas(c2, pxxxls);
    wait(w);
    disableCanvas(c0);
    disableCanvas(c1);
    disableCanvas(c3);
    setCanvas(c2, seizure);
    wait(1.0);
    disableCanvas(c2);
  }
}

class Demo extends SetList {
  Demo(SetList setList) {
    super(setList);
  }

  Demo() { } 

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
    PointPopping pointPopping = new PointPopping(disFont.getBitmap("disorient").getBitmap(true, true, false).getBitPoints());
    Breather breather = new Breather();
    Sparkle sparkle = new Sparkle();

    pointPopping.x = 24;
    pointPopping.y = 30;
    pointPopping.yPad = 1;
    pointPopping.pointsPerFrame = 4;
    breather.setBlendMode(MULTIPLY);
    breather.c0 = color(pornj, 255);
    breather.c1 = color(lerpColor(pornj, color(0), 0.7));
    breather.phaseInc = 0.025;
    sparkle.threshold = 16;
    sparkle.nDots = 1200;
    sparkle.dotToCrossRatio = 1.0;
    sparkle.c = color(255, 128);

    setCanvas(canvas2, pointPopping); 
    pushCanvas(canvas2, breather);
    pushCanvas(canvas2, sparkle);
    wait(6.0);
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
    disableCanvases();
  }
}
