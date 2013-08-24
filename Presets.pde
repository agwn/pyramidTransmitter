class Presets {
  CanvasRoutine getMirror() {
    return new Mirror();
  }

  CanvasRoutine getDisor13ntVertical() {
    PixelPopping pixelPopping = new PixelPopping(disFont.getBitmap("disor13nt_3s").getBitmap(true, true, false).getBitPoints());

    pixelPopping.x = 24;
    pixelPopping.y = 6;
    pixelPopping.yPad = 1;
    pixelPopping.pointsPerFrame = 4;

    return pixelPopping;
  }

  CanvasRoutine getBlackBackground() {
    return getBreather(color(0), color(0), 0.0, BLEND);
  }

  CanvasRoutine getBreather(color c0, color c1, float freq, int mode) {
    Breather breather = new Breather();
    breather.c0 = c0;
    breather.c1 = c1;
    breather.freq = freq;
    breather.setBlendMode(mode);

    return breather;
  }

  CanvasRoutine getTrails(int fade) {
    Trails trails = new Trails();
    trails.fade.set(fade);
    return trails;
  }
}

class States extends SetList {
  States() {
  }

  States(SetList setList) {
    super(setList);
  }

  void setDisor13ntColumns(Canvas canvas) {
    Sparkle sparkle = new Sparkle();
    sparkle.threshold = 16;
    sparkle.nDots = 1200;
    sparkle.dotToCrossRatio = 1.0;
    sparkle.c = color(255, 128);

    setCanvas(canvas, presets.getBlackBackground());
    pushCanvas(canvas, presets.getDisor13ntVertical()); 
    pushCanvas(canvas, presets.getMirror());
    pushCanvas(canvas, presets.getBreather(pornj, pink, 0.5, MULTIPLY));
    pushCanvas(canvas, sparkle);
  } 
}

class PornjscachInkBlotter extends SetList {
  Pxxxls pxxxls;
  Pxxxls pxxxlFilter;
  SimpleWave waves;
  Mirror mirror;
  Warp warp;
  Grid grid;
  Trails trails;
  Sparkle sparkle;
  Sparkle sparkle2;
  Breather breather;
 

  PornjscachInkBlotter() {
  }

  PornjscachInkBlotter(SetList setList) {
    super(setList);
  }

  void setup() {
    pxxxls = new Pxxxls(15);
    pxxxlFilter = new Pxxxls(100);
    waves = new SimpleWave();
    mirror = new Mirror();
    warp = new Warp();
    grid = new Grid();
    trails = new Trails();
    sparkle = new Sparkle();
    sparkle2 = new Sparkle();
    breather = new Breather();
    resetParams();
  }

  private void resetParams() {
    pxxxlFilter.setBlendMode(DODGE);
    pxxxlFilter.setPaintMode(pxxxlFilter.BLEND);
    warp.yFreq.set(0.17);
    warp.xFreq.set(0.24);

    trails.fade.set(240);

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
  }

  void setPattern_1(Canvas canvas) {
    setCanvas(canvas, pxxxls);
    pushCanvas(canvas, warp);
    pushCanvas(canvas, trails);
    pushCanvas(canvas, mirror);
    pushCanvas(canvas, sparkle);
    pushCanvas(canvas, breather);
    pushCanvas(canvas, pxxxlFilter);
    pushCanvas(canvas, sparkle2);
  }

  void setPattern_2(Canvas canvas) {
    setCanvas(canvas, waves);
    pushCanvas(canvas, warp);
    pushCanvas(canvas, trails);
    pushCanvas(canvas, mirror);
    pushCanvas(canvas, sparkle);
    pushCanvas(canvas, breather);
    pushCanvas(canvas, pxxxlFilter);
    pushCanvas(canvas, sparkle2);
  }

  void setPattern_3(Canvas canvas) {
    setCanvas(canvas, pxxxls);
    pushCanvas(canvas, warp);
    pushCanvas(canvas, trails);
    pushCanvas(canvas, sparkle);
    pushCanvas(canvas, breather);
    pushCanvas(canvas, trails);
    pushCanvas(canvas, pxxxlFilter);
    pushCanvas(canvas, mirror);
    pushCanvas(canvas, sparkle2);
  }

  void setPattern_4(Canvas canvas) {
    setCanvas(canvas, pxxxls);
    pushCanvas(canvas, warp);
    pushCanvas(canvas, trails);
    pushCanvas(canvas, mirror);
    pushCanvas(canvas, sparkle);
    pushCanvas(canvas, breather);
    pushCanvas(canvas, trails);
    pushCanvas(canvas, pxxxlFilter);
    pushCanvas(canvas, sparkle2);
  }

  void setPattern_5(Canvas canvas) {
    setCanvas(canvas, pxxxls);
    pushCanvas(canvas, warp);
    pushCanvas(canvas, presets.getTrails(63));
    pushCanvas(canvas, mirror);
    pushCanvas(canvas, sparkle);
    pushCanvas(canvas, breather);
    pushCanvas(canvas, presets.getTrails(63));
    pushCanvas(canvas, pxxxlFilter);
    pushCanvas(canvas, sparkle2);
  }

  void setPattern_6(Canvas canvas, float riseTime) {
    Trails trails1 = new Trails();
    Trails trails2 = new Trails();

    trails1.fade.set(255);
    trails2.fade.set(255);
    setCanvas(canvas, pxxxls);
    pushCanvas(canvas, warp);
    pushCanvas(canvas, trails1);
    pushCanvas(canvas, mirror);
    pushCanvas(canvas, sparkle);
    pushCanvas(canvas, breather);
    pushCanvas(canvas, trails2);
    pushCanvas(canvas, pxxxlFilter);
    pushCanvas(canvas, sparkle2);

    line(riseTime, trails1.fade, 2);
    line(riseTime, trails2.fade, 64);
    wait(riseTime);
  }
}
