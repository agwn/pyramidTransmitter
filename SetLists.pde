class SetListTemplate extends SetList {
  SetListTemplate() {
  }

  SetListTemplate(SetList setList) {
    super(setList);
  }

  void setup() {
    wait(1.0);
  }
}

class PyramidPartyDemo extends SetList {
  PyramidPartyDemo() {
  }

  PyramidPartyDemo(SetList setList) {
    super(setList);
  }

  void setup() {
    playSetList(new DisorientProtonIntro(this));
    playSetList(new DoSeizure(this));
    playSetList(new DisorientAllTheThings(this));
    playSetList(new Other(this));
    playSetList(new PortalGel(this));
    playSetList(new PornjscachInkBlotter(this));
  }
}

class Other extends SetList {
  Other() {
  }

  Other(SetList setList) {
    super(setList);
  }

  void setup() {
    Pxxxls pxxxls = new Pxxxls(100);
    ProtonPack protonPack = new ProtonPack();
    Sparkle sparkle = new Sparkle();
    Mirror mirror = new Mirror();
    Warp warp = new Warp();
    Warp warp2 = new Warp();
    Fire fire = new Fire();
    WarpSpeedMrSulu warpSpeed = new WarpSpeedMrSulu(200);
    Breather breather = new Breather();

    protonPack.strokeWeight0 = 3;
    protonPack.strokeWeight1 = 3;
    protonPack.freq = 0.333;
    protonPack.nCycles = 0.5;

    sparkle.nDots = 100;

    warp.xFreq.set(0.45);
    warp.yFreq.set(0.333);
    warp.xAmp.set(0.65);
    warp.yAmp.set(0.633);

    warp.xFreq.set(0.1);
    warp.yFreq.set(0.3);
    warp.xAmp.set(0.45);
    warp.yAmp.set(1.0);

    breather.c0 = color(pornj);
    breather.c1 = color(disorientOrange);
    breather.freq = 0.333;
    breather.setBlendMode(MULTIPLY);

    setCanvas(canvas0, pxxxls);
    wait(30.0);

    setCanvas(canvas2, protonPack);
    pushCanvas(canvas2, sparkle);
    crossfade(5.0, canvas0, canvas2); 
    wait(15.0);

    pushCanvas(canvas2, warp);
    pushCanvas(canvas2, mirror);
    wait(30.0);

    setCanvas(canvas3, fire);
    crossfade(5.0, canvas2, canvas3);
    wait(10.0);

    setCanvas(canvas2, warpSpeed);
    pushCanvas(canvas2, warp);
    pushCanvas(canvas2, breather);
    fadeIn(10.0, canvas2);
    wait(15.0);

    fadeOut(5.0, canvas3);
    wait(20.0);
    fadeOut(5.0, canvas2);
  }
}

class PornjscachInkBlotter extends SetList {
  PornjscachInkBlotter() {
  }

  PornjscachInkBlotter(SetList setList) {
    super(setList);
  }

  void setup() {
    Pxxxls pxxxls = new Pxxxls(15);
    Pxxxls pxxxlFilter = new Pxxxls(100);
    //Waves waves = new Waves();
    SimpleWave waves = new SimpleWave();
    Mirror mirror = new Mirror();
    Warp warp = new Warp();
    Grid grid = new Grid();
    Trails trails = new Trails();
    Sparkle sparkle = new Sparkle();
    Sparkle sparkle2 = new Sparkle();
    Breather breather = new Breather();
    //float waitTime = 30.0;
    float waitTime = 1.0;

    pxxxlFilter.setBlendMode(DODGE);

    pxxxlFilter.setPaintMode(pxxxlFilter.BLEND);

    warp.yFreq.set(0.17);
    warp.xFreq.set(0.24);

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

class DisorientProtonIntro extends SetList {
  DisorientProtonIntro() {
  }

  DisorientProtonIntro(SetList setList) {
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

class DoSeizure extends SetList {
  DoSeizure() {
  }

  DoSeizure(SetList setList) {
    super(setList);
  }

  void setup() {
    Seizure seizure = new Seizure();
    setCanvas(canvas2, seizure);
    wait(0.25);
  }
}

class DisorientAllTheThings extends SetList {
  DisorientAllTheThings() {
  }

  DisorientAllTheThings(SetList setList) {
    super(setList);
  }

  void setup() {
    Waves waves = new Waves();
    Warp warp = new Warp();
    Trails trails = new Trails();
    Trails trails2 = new Trails();
    Sparkle sparkle = new Sparkle();
    Sparkle sparkle2 = new Sparkle();
    Breather breather = new Breather();
    Breather breather2 = new Breather();
    SimpleWave simpleWave = new SimpleWave();
    DisplayDisorient displayDisorient = new DisplayDisorient();
    DisplayDisorient displayDisorient2 = new DisplayDisorient();
    ScrollDisorient disorientScroll = new ScrollDisorient();
    ScrollDisorient disorientScroll2 = new ScrollDisorient();

    warp.yFreq.set(0.17);
    warp.xFreq.set(0.14);
    trails.fade = 32;
    sparkle.threshold = 16;
    sparkle.nDots = 1200;
    sparkle.dotToCrossRatio = 1.0;
    sparkle.c = color(255, 128);
    sparkle2.nDots = 1000;
    sparkle2.threshold = 16;
    sparkle2.setBlendMode(sparkle.DIRECT);
    breather.setBlendMode(MULTIPLY);
    breather.c0 = color(pornj, 255);
    breather.c1 = color(disorientOrange, 255);
    breather.freq = 0.25;
    breather2.setBlendMode(MULTIPLY);
    breather2.c0 = color(lerpColor(pornj, color(0), 0.8));
    breather2.c1 = color(lerpColor(disorientOrange, color(0), 0.9));
    breather2.freq = 0.333;
    simpleWave.amp = 0.125;
    simpleWave.spread = 1.5;
    simpleWave.nWaves = 2;
    simpleWave.bias = 0.25;
    simpleWave.theColor = color(255, 180);
    simpleWave.freq = -1.0;

    ArrayList dsa = new ArrayList();

    for (int i = 0; i < 8; i++) {
      ScrollDisorient ds = new ScrollDisorient();
      ds.xPad = 0;
      ds.yPad = 2;
      ds.x = i * 8;
      ds.y = 210;
      if (i < 4) {
        ds.yLimitTop = 180 - i * 60;
      }
      else {
        ds.yLimitTop = 180 - (7 - i) * 60;
      }
      ds.yLimitBottom = 210;
      ds.doRotate = true;

      if (i % 2 == 0) {
        ds.xFlip = true;
        ds.ySpeed = -4;
      }
      else {
        ds.yFlip = true;
        ds.ySpeed = 4;
      }

      dsa.add(ds);
    }

    setCanvas(canvas2, simpleWave);
    pushCanvas(canvas2, warp);
    pushCanvas(canvas2, sparkle2);
    pushCanvas(canvas2, trails);
    pushCanvas(canvas2, breather2);

    setCanvas(canvas3, (ScrollDisorient) dsa.get(0));

    for (int i = 1; i < 8; i++) {
      pushCanvas(canvas3, (ScrollDisorient) dsa.get(i));
    }

    pushCanvas(canvas3, breather);
    pushCanvas(canvas3, sparkle);
    wait(30.0);
  }
}

class PortalGel extends SetList {
  PortalGel() {
  }

  PortalGel(SetList setList) {
    super(setList);
  }

  void setup() {
    Mirror mirror = new Mirror();
    Warp warp = new Warp();
    Trails trails = new Trails();
    Sparkle sparkle2 = new Sparkle();
    Breather breather = new Breather();
    SimpleWave simpleWave = new SimpleWave();

    warp.yAmp.set(0.25);
    warp.xAmp.set(1.5);
    warp.yFreq.set(0.17);
    warp.xFreq.set(0.24);

    trails.fade = 64;

    sparkle2.nDots = 200;
    sparkle2.threshold = 16;

    breather.setBlendMode(MULTIPLY);
    breather.c0 = color(pornj);
    breather.c1 = color(disorientOrange);
    breather.freq = 0.125;

    simpleWave.amp = 0.125;
    simpleWave.spread = 0.5;
    simpleWave.nWaves = 2;
    simpleWave.bias = 0.25;
    simpleWave.theColor = color(255, 180);
    simpleWave.freq = -0.5;

    setCanvas(canvas2, simpleWave);
    pushCanvas(canvas2, breather);
    pushCanvas(canvas2, warp);
    pushCanvas(canvas2, trails);
    pushCanvas(canvas2, mirror);
    pushCanvas(canvas2, sparkle2);
    wait(30.0);
  }
}




class TechDemo extends SetList {
  TechDemo() {
  }

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
  Demo() {
  } 

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
  DebuggingSetList() {
  }

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

class UncertainSetList extends SetList {
  UncertainSetList() {
  }

  UncertainSetList(SetList setList) {
    super(setList);
  }

  void setup() {
    // PlantFractal demo
    {
      int secondsToHoldTheBand = 6;
      int PercentBandWidthMin = 2;
      int PercentBandWidthMax = 15;
        PlantFractal plantFractal = new PlantFractal(1);
        setCanvas(canvas0, plantFractal); 
        wait(18.0);
    }

    // StarBand demo
    {
      int secondsToHoldTheBand = 6;
      int PercentBandWidthMin = 2;
      int PercentBandWidthMax = 15;
      StarBand starBand = new StarBand(secondsToHoldTheBand, PercentBandWidthMin, PercentBandWidthMax);

      for (int i = 0; i < 3; i++) { 
        setCanvas(canvas0, starBand); 
        wait(3.0);
        fadeOut(3.0, canvas0);
      }
    }

    // Simple Circles demo
    {
      float secondsPerOneTravel = 6;
      SimpleCircles simpleCircles = new SimpleCircles(secondsPerOneTravel);

      Breather breather = new Breather();
      breather.c0 = color(pornj);
      breather.c1 = color(disorientOrange);
      breather.freq = 0.333;
      breather.setBlendMode(MULTIPLY);

      setCanvas(canvas0, simpleCircles); 
      pushCanvas(canvas0, breather);
      wait(18.0);

      fadeOut(5.0, canvas0);
    }

    // HeartBeat demo
    {
      Trails trails = new Trails();

      int maxHeartsPow = 5; // 2^5=32

      for (int i=0; i<maxHeartsPow; i++) {
        int numberOfHearts = (int)pow(2, i);
        float secondsPerOneBeat = 3.0f/numberOfHearts; // as number of hears grow, speed goes up!
        DisorientHeartBeat heart = new DisorientHeartBeat(numberOfHearts, secondsPerOneBeat);

        setCanvas(canvas2, heart  ); 
        pushCanvas(canvas2, trails);
        wait(9.0);
      }
    }
  }
}

class Tester extends SetList {
  Tester() {
  }

  Tester(SetList setList) {
    super(setList);
  }

  void setup() {
    ArrayList<BitPoint> disorientBitPoints = disFont.getBitmap("disorient_3s").getBitmap(true, true, false).getBitPoints();

    Energize energize = new Energize(disorientBitPoints);
    Mirror mirror = new Mirror();
    Sparkle sparkle = new Sparkle();
    CrazyBars crazyBars = new CrazyBars();
    Warp warp = new Warp();

    energize.x = 24;
    energize.y = 9;
    energize.yPad = 1;
    energize.pointsPerFrame = 2;
    energize.frames = 20;
    energize.cStart = color(disorientOrange, 0);
    energize.cEnd = pornj;
    energize.verticalToHorizontalRatio = 0.5;
    energize.size = 8;
    sparkle.nDots = 900;
    sparkle.dotToCrossRatio = 0.99;

    crazyBars.setBlendMode(OVERLAY);

    setCanvas(canvas2, energize);
    pushCanvas(canvas2, crazyBars);
    pushCanvas(canvas2, mirror);
    wait(1.0);
    popCanvas(canvas2);
    wait(1.0);
    pushCanvas(canvas2, mirror);
    wait(1.0);
    popCanvas(canvas2);
    wait(1.0);
    pushCanvas(canvas2, mirror);
    wait(1.0);
    popCanvas(canvas2);
    wait(1.0);
  }
}
