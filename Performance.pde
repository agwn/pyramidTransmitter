class Disor13ntSequence extends SetList {
  States states;
  PornjscachInkBlotter pornjscach;

  Disor13ntSequence() {
  }

  Disor13ntSequence(SetList setList) {
    super(setList);
  }

  void setup() {
    states = new States(this);
    pornjscach = new PornjscachInkBlotter(this);
    CloudFractalPresets cloudFractalPresets = new CloudFractalPresets(this);

    lifeSequence();
    intro();
    playSetList(new DoSeizure(this));
    disorientAllTheThings();
    wait(2.0);
    disorientAllTheThingsEnd(15.0);
    snackPack();
    portalGel();
    wait(120.0);
    pornjscach.setPattern_1(canvas2);
    wait(60.0);
    pornjscach.setPattern_2(canvas2);
    wait(60.0);
    pornjscach.setPattern_3(canvas2);
    wait(60.0);
    pornjscach.setPattern_4(canvas2);
    wait(60.0);
//    pornjscach.setPattern_5(canvas2);
//    wait(60.0);
    pornjscach.setPattern_6(canvas2, 60.0);
    wait(60.0);
    fadeOut(20.0, canvas2);
    cloudFractalPresets.doPlasmaClouds(canvas2);
    wait(60.0);
    simpleCircleSequence();
    starBandSequence();
  }

  void lifeSequence() {
    Conway conway = new Conway();
    Snakes snakes = new Snakes();
    DNA dna = new DNA(64, 210, 8);
    Warp warp = new Warp();
    Flash flash = new Flash();
    GenColorSequence colorSequence = new GenColorSequence();
    Trails trails = new Trails();

    dna.generateColor = new GenCampColor();
    snakes.generateColor = new GenCampColor();
    
    colorSequence.colors.add(color(pornj, 64)); 
    colorSequence.colors.add(color(disorientOrange, 64));
    flash.generateColor = colorSequence;

    setParam(warp.yAmp, 0.0);
    setParam(warp.yFreq, 0.0);
    setParam(warp.xAmp, 0.0);
    setParam(warp.xFreq, 0.0);
    setCanvas(canvas2, dna);
    pushCanvas(canvas2, warp);
    wait(1.0);
    line(15.0, warp.xAmp, 0.5);
    line(15.0, warp.xFreq, 4.0);
    wait(16.0);
    setParam(warp.yAmp, 0.02);
    setParam(warp.yFreq, 0.05);
    setParam(warp.xAmp, 0.05);
    setParam(warp.xFreq, 0.111);
    setCanvas(canvas2, conway);
    pushCanvas(canvas2, warp);
    line(15.0, warp.xAmp, 0.45);
    line(15.0, warp.xFreq, 0.05);
    line(15.0, warp.xAmp, 0.6);
    line(15.0, warp.xFreq, 0.05);
    wait(15.0);
    setCanvas(canvas3, snakes);
    setParam(flash.minNextTime, 0.8);
    setParam(flash.maxNextTime, 0.8);
    pushCanvas(canvas3, flash);
    fadeIn(15.0, canvas3);
    fadeOut(15.0, canvas2);
    popCanvas(canvas3);
    setCanvas(canvas2, flash);
    pushCanvas(canvas3, trails);
    trails.fade.set(255.0);
    line(15.0, trails.fade, 16.0);
    wait(30.0);
    disableCanvases();
  }

  void starBandSequence() {
    float waitTime = 20.0;
    float secondsToHoldTheBand = 1.0;
    int PercentBandWidthMin = 15;
    int PercentBandWidthMax = 40;

    StarBand starBand = new StarBand(secondsToHoldTheBand, PercentBandWidthMin, PercentBandWidthMax);
    Warp warp = new Warp();

    warp.yWaveTable = phasorTable;
    setParam(warp.xAmp, 0.0);
    setParam(warp.yAmp, 1.0);
    setParam(warp.xFreq, 0.0);
    setParam(warp.yFreq, 0.25);

    starBand.generateColor = new GenCampColor();

    setCanvas(canvas2, starBand);
    pushCanvas(canvas2, warp);
    pushCanvas(canvas2, presets.getTrails(32));
    pushCanvas(canvas2, presets.getMirror());
    line(waitTime, warp.yFreq, 1.0);
    wait(waitTime);
    line(waitTime, warp.xFreq, 0.25);
    line(waitTime, warp.xAmp, 0.5);
    wait(waitTime);
    line(waitTime, warp.yFreq, 0.0);
    wait(waitTime);
    line(waitTime, warp.xFreq, 0.0);
    line(waitTime, warp.xAmp, 0.0);
    wait(waitTime);
    disableCanvas(canvas2);
  }

  void simpleCircleSequence() {
    SimpleCirclesPresets simpleCirclesPresets = new SimpleCirclesPresets(this);

    simpleCirclesPresets.thePreset(canvas0);
    pushCanvas(canvas0, presets.getBreather(pornj, disorientOrange, 2.333, MULTIPLY));

    setCanvas(canvas2, presets.getBlackBackground());
    wait(60.0);
    pushCanvas(canvas2, presets.getDisor13ntVertical());
    pushCanvas(canvas2, presets.getMirror());
    pushCanvas(canvas2, presets.getBreather(pornj, disorientOrange, 3.0, MULTIPLY));
    pushCanvas(canvas2, presets.getSparkle(1000, 1.0, 1.0, color(255)));
    wait(60.0);
    setCanvas(canvas3, presets.getBreather(pornj, disorientOrange, 3.333, BLEND));
    fadeIn(15.0, canvas3);
    fadeOut(15.0, canvas0);
    fadeOut(15.0, canvas2);
    fadeOut(15.0, canvas3);
  }

  void intro() {
    states.setDisor13ntColumns(canvas2);
    wait(15.0);
    setCanvas(canvas3, presets.getBreather(pornj, disorientOrange, 0.6, BLEND));
    fadeIn(30.0, canvas3);
    wait(15.0);
  }

  void disorientAllTheThings() {
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

    setParam(warp.yFreq, 0.17);
    setParam(warp.xFreq, 0.14);
    trails.fade.set(32);
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
  }

  void disorientAllTheThingsEnd(float time) {
    fadeOut(time * 0.5, canvas2);
    fadeOut(time * 0.5, canvas3);
  }

  void snackPack() {
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

    setParam(warp.xAmp, 0.0);
    setParam(warp.yAmp, 0.0);
    setParam(warp.xFreq, 0.05);
    setParam(warp.yFreq, 0.3);

    setParam(warp2.xFreq, 0.2);
    setParam(warp2.yFreq, 0.0);
    setParam(warp2.xAmp, 1.0);
    setParam(warp2.yAmp, 1.0);
    warp2.xWaveTable = phasorTable;

    breather.c0 = color(pornj);
    breather.c1 = color(disorientOrange);
    breather.freq = 0.333;
    breather.setBlendMode(MULTIPLY);

    setCanvas(canvas0, pxxxls);
    wait(60.0);

    setCanvas(canvas2, protonPack);
    pushCanvas(canvas2, warp);
    pushCanvas(canvas2, sparkle);
    crossfade(15.0, canvas0, canvas2); 
    wait(60.0);

    // Start warping here
    line(30.0, warp.xAmp, 0.0, 2.45);
    line(20.0, warp.yAmp, 0.0, 1.0);

    // Mirror
    wait(60.0);
    pushCanvas(canvas2, mirror);
    wait(60.0);

    line(30.0, warp.xAmp, 2.45, 0.0);
    line(20.0, warp.yAmp, 1.0, 0.0);

    wait(60.0);

    // Fire
    setCanvas(canvas3, fire);
    crossfade(6.0, canvas2, canvas3);
    wait(6.0);

    setCanvas(canvas2, warpSpeed);
    pushCanvas(canvas2, warp2);
    pushCanvas(canvas2, breather);
    fadeIn(15.0, canvas2);

    wait(15.0);
 
    line(20.0, warp2.xFreq, 1.5);

    wait(60.0);

    line(20.0, warp2.xFreq, 0.1);
    fadeOut(20.0, canvas3);

    line(20.0, warp2.yAmp, 1.0);
    line(20.0, warp2.yFreq, 0.5);

    wait(60.0);

    line(20.0, warp2.xFreq, 1.0);

    wait(60.0);

    line(15.0, warp2.xFreq, -1.0);
    line(15.0, warp2.yFreq, 0.0);
    fadeOut(15.0, canvas2);
  }

  void portalGel() {
    Mirror mirror = new Mirror();
    Warp warp = new Warp();
    Trails trails = new Trails();
    Sparkle sparkle = new Sparkle();
    SimpleWave simpleWave = new SimpleWave();
    CanvasRoutine breather = presets.getBreather(pornj, disorientOrange, 0.125, MULTIPLY);

    setParam(warp.yAmp, 0.25);
    setParam(warp.xAmp, 1.5);
    setParam(warp.yFreq, 0.17);
    setParam(warp.xFreq, 0.25);

/*
    warp.yAmp.set(0.25);
    warp.xAmp.set(1.5);
    warp.yFreq.set(0.17);
    warp.xFreq.set(0.24);
*/
    sparkle.nDots = 200;
    sparkle.threshold = 16;

    simpleWave.amp = 0.125;
    simpleWave.spread = 0.5;
    simpleWave.nWaves = 2;
    simpleWave.bias = 0.25;
    simpleWave.theColor = color(255, 180);
    simpleWave.freq = -0.5;

    setCanvas(canvas2, simpleWave);
    pushCanvas(canvas2, breather);
    pushCanvas(canvas2, warp);
    pushCanvas(canvas2, presets.getTrails(64));
    pushCanvas(canvas2, mirror);
    pushCanvas(canvas2, sparkle);
  }
}
