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
    trails.fade = fade;
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
