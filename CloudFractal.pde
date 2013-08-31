// Cloud Fractal
// Draws a random displacement fractal/terrain map using two colors.
// based on http://stackoverflow.com/a/5532726
// David Shimel aka keytarmageddon aka dsshimel
// 2013-8-16

import java.util.Random;

public class CloudFractal extends CanvasRoutine {
  protected int _w;   // grid width in number of cells
  protected int _h;   // grid height in number of cells
  protected float[][] _grid, _nextGrid;      // Plasma fractal grid
  protected float _roughness;
  protected Random _rand;
  protected float _minGridValue, _maxGridValue, _minNextGridValue, _maxNextGridValue;
  protected int PATTERN_LENGTH = 120;
  protected color _color1 = pornj;
  protected color _color2 = disorientOrange;
  protected int _c1Red, _c1Green, _c1Blue, _c2Red, _c2Green, _c2Blue;
  protected double _exponent;
  protected boolean _choppy;
  protected int _choppiness = 1;
  protected int _generations = 0;
    
  CloudFractal(Random rand, float roughness, int width, int height, double exponent) { 
    _roughness = roughness / width;
    _w = width;
    _h = height;
    _grid = new float[_w][_h];
    _nextGrid = new float[_w][_h];    
    _rand = (rand == null) ? new Random() : rand;
    _exponent = exponent;
    _choppy = true;
    initialize();
  }
 
  void reinit() {
    chooseColors();
  } 

  protected float checkExtremes(float value, boolean isNext) {
    if(isNext) {
      if(value < _minNextGridValue) {
        _minNextGridValue = value;
      }
      if(value > _maxNextGridValue) {
        _maxNextGridValue = value;
      }
      return value;
    }
    else {
      if(value < _minGridValue) {
        _minGridValue = value;
      }
      if(value > _maxGridValue) {
        _maxGridValue = value;
      }
      return value;
    }
  }
  
  protected float getInitCornerPoint(boolean isNext) {
    float result = _rand.nextFloat() - 0.5;
    checkExtremes(result, isNext);
    
    return result;
  }
  
  protected void resetExtremes() {
    _minGridValue = Float.MAX_VALUE;
    _maxGridValue = -Float.MAX_VALUE;
    
    _minNextGridValue = Float.MAX_VALUE;
    _maxNextGridValue = -Float.MAX_VALUE;
  }
  
  public void initialize() {
    resetExtremes();
    constructFractals();
  }
  
  protected void constructFractals() {
    constructFractal(_grid, false);
    constructFractal(_nextGrid, true); 
  }
  
  protected void constructFractal(float[][] grid, boolean isNext) {
    int xh = _w - 1;
    int yh = _h - 1;
    
    // set the corner points
    grid[0][0] = getInitCornerPoint(isNext);
    grid[0][yh] = getInitCornerPoint(isNext);
    grid[xh][0] = getInitCornerPoint(isNext);
    grid[xh][yh] = getInitCornerPoint(isNext);

    //generate the fractal
    generate(grid, 0, 0, xh, yh, isNext);    
  }
  
  void draw() {
    pg.beginDraw();
    
    //System.out.println("min: " + _minGridValue + ", max: " + _maxGridValue);
    
    if(_choppy) {
      if(_generations % _choppiness == 0) {
        generate(_grid, 0, 0, _w - 1, _h - 1, false);
        for(int i = 0; i < _w; i++) {
          for(int j = 0; j < _h; j++) {
            pg.stroke(getPointColor(i, j));
            pg.point(i, j);
          }  
        }
        resetExtremes();
        chooseRoughness();
        chooseExponent();
      }
    }
    else { 
      for(int i = 0; i < _w; i++) {
        for(int j = 0; j < _h; j++) {
          pg.stroke(getInterpolatedColor(i, j, (_generations % PATTERN_LENGTH) / (double) PATTERN_LENGTH));
          pg.point(i, j);
        }
      }
    }
    
    if(_generations % PATTERN_LENGTH == 0) {
      chooseColors();
      _choppy = Math.random() < 0.75;
      if(!_choppy) {
        constructFractals();
      }
      chooseChoppiness();
      chooseExponent();
    }
    
    _generations++;
    pg.endDraw();
  }
  
  protected float chooseRoughness() {
    _roughness = 0.1 + (float)Math.random();
    return _roughness;
  }
  
  protected double chooseExponent() {
    if(_choppy) {    
      _exponent = Math.random() * 0.5;
    }
    else {
        _exponent = 0;
    }
    return _exponent;
  }
  
  protected double chooseChoppiness() {
    if(_choppy) {
      _choppiness = 1 + (int) Math.floor(Math.random() * 10);
    }
    else {
      // more choppy if coming from a smooth iteration
      _choppiness = 1 + (int) Math.floor(Math.random() * 3);
    }
       
    return _choppiness;
  }
  
  protected int getRandomInt(int range) {
    return (int) Math.floor(Math.random() * range);
  }
  
  protected int getRandomSingleColor() {
    int result = getRandomInt(64);
    result += flipCoin() ? 192 : 0;
    return result;
  }
  
  protected boolean flipCoin() {
    return Math.random() < 0.5;
  }
  
  protected void chooseColors() {
    if(Math.random() < 0.5) {
      _color1 = pornj;
      _color2 = disorientOrange;
    }
    else {
      // make really nice contrasting colors? I hope so
      int r = getRandomSingleColor();
      int g = getRandomSingleColor();
      int b = getRandomSingleColor();   
      _color1 = color(r, g, b);
      _color2 = color(255 - r, 255 - g, 255 - b);
    }
    
    _c1Red = (_color1 >> 16) & 0xFF;
    _c1Green = (_color1 >> 8) & 0xFF;
    _c1Blue = (_color1 >> 0) & 0xFF;
    _c2Red = (_color2 >> 16) & 0xFF;
    _c2Green = (_color2 >> 8) & 0xFF;
    _c2Blue = (_color2 >> 0) & 0xFF;
  }
  
  protected int getLinearInterpolation(int leftVal, int rightVal, double parameter) {
    return (int) Math.round(leftVal - (leftVal - rightVal) * parameter);
  }
  
  protected double calculateParameter(int i, int j, boolean isNext) {
    double minVal, maxVal;
    float gridValue;
    if(isNext) {
      minVal = _minNextGridValue;
      maxVal = _maxNextGridValue;
      gridValue = _nextGrid[i][j];
      //System.err.println("next i: " + i + ", j: " + j + ", val: " + gridValue);
    }
    else {
      minVal = _minGridValue;
      maxVal = _maxGridValue;
      gridValue = _grid[i][j];
    }    
    
    double range = maxVal - minVal;
    gridValue -= minVal;
    
    double parameter = (double) gridValue / range;
    parameter = 2 * (parameter - 0.5);

    if(parameter < 0) {
      parameter = -parameter;
      parameter = Math.pow(parameter, _exponent);
      parameter = -parameter;
    }
    else {
      parameter = Math.pow(parameter, _exponent);
    }    
    parameter = (parameter / 2) + 0.5;

    return parameter;
  }
  
  protected int getColorValue(int i, int j, char rgb, boolean isNext) {    
    switch(rgb) {
      case 'r':
        return getLinearInterpolation(_c1Red, _c2Red, calculateParameter(i, j, isNext));
      case 'g':
        return getLinearInterpolation(_c1Green, _c2Green, calculateParameter(i, j, isNext));
      case 'b':
        return getLinearInterpolation(_c1Blue, _c2Blue, calculateParameter(i, j, isNext));
      default:
        return 0;
    }
  }
  
  protected color getPointColor(int i, int j) {
    int r, g, b;
    r = getColorValue(i, j, 'r', false);
    g = getColorValue(i, j, 'g', false);
    b = getColorValue(i, j, 'b', false);
    //System.err.println("i: " + i + ", j: " + j + ", r: " + r + ", g: " + g + ", b: " + b);
    return color(r, g, b);
  }
  
  protected color getInterpolatedColor(int i, int j, double step) {
    int r1, g1, b1, r2, g2, b2;
    int r, g, b;
    r1 = getColorValue(i, j, 'r', false);
    g1 = getColorValue(i, j, 'g', false);
    b1 = getColorValue(i, j, 'b', false);
    r2 = getColorValue(i, j, 'r', true);
    g2 = getColorValue(i, j, 'g', true);
    b2 = getColorValue(i, j, 'b', true);
    //System.err.println("i: " + i + ", j: " + j + ", r1: " + r1 + ", g1: " + g1 + ", b1: " + b1 + ", r2: " + r2 + ", g2: " + g2 + ", b2: " + b2);
    r = getLinearInterpolation(r1, r2, step);
    g = getLinearInterpolation(g1, g2, step);
    b = getLinearInterpolation(b1, b2, step);
    
    //System.err.println(step);
    
    return color(r, g, b);
  }
    
  // generate the fractal
  protected void generate(float[][] grid, int xl, int yl, int xh, int yh, boolean isNext) {    
    int xm = (xl + xh) / 2;
    int ym = (yl + yh) / 2;
    if ((xl == xm) && (yl == ym)) return;

    grid[xm][yl] = 0.5f * (grid[xl][yl] + grid[xh][yl]);
    grid[xm][yh] = 0.5f * (grid[xl][yh] + grid[xh][yh]);
    grid[xl][ym] = 0.5f * (grid[xl][yl] + grid[xl][yh]);
    grid[xh][ym] = 0.5f * (grid[xh][yl] + grid[xh][yh]);

    float v = roughen(0.5f * (grid[xm][yl] + grid[xm][yh]), xl + yl, yh + xh);
    grid[xm][ym] = v;
    grid[xm][yl] = checkExtremes(roughen(grid[xm][yl], xl, xh), isNext);
    grid[xm][yh] = checkExtremes(roughen(grid[xm][yh], xl, xh), isNext);
    grid[xl][ym] = checkExtremes(roughen(grid[xl][ym], yl, yh), isNext);
    grid[xh][ym] = checkExtremes(roughen(grid[xh][ym], yl, yh), isNext);

    generate(grid, xl, yl, xm, ym, isNext);
    generate(grid, xm, yl, xh, ym, isNext);
    generate(grid, xl, ym, xm, yh, isNext);
    generate(grid, xm, ym, xh, yh, isNext);
  }
    
    // Add a suitable amount of random displacement to a point
    protected float roughen(float v, int l, int h) {
        return v + _roughness * (float) (_rand.nextGaussian() * (h - l));
    }
}

class CloudFractalPlayer extends SetList {
  
  CloudFractalPlayer() { 
  }

  CloudFractalPlayer(SetList setList) {
    super(setList);
  }
  
  void setup() {
    double exp = 0.3;
    CloudFractal cloudFractal = new CloudFractal(null, 0.9, 64, 210, exp);

    setCanvas(canvas2, cloudFractal);
    wait(60.0);
  }
}

public class CloudFractalPlasma extends CloudFractal {
  private GenerateColor generateColor = new GenColorSequence();

  CloudFractalPlasma(Random rand, float roughness, int width, int height, double exponent) { 
    super(rand, roughness, width, height, exponent);
    GenColorSequence gcs = new GenColorSequence();
    gcs.colors.add(pornj);
    gcs.colors.add(disorientOrange);
    generateColor = gcs;
    chooseColors();
    constructNextFractal();
  }

  void setFreq(float f) {
    PATTERN_LENGTH = (int) (FRAMERATE / f);
  }
  
  protected void constructNextFractal() {
    for (int i = 0; i < _w; i++) {
      for (int j = 0; j < _h; j++) {
        _grid[i][j] = _nextGrid[i][j];
      }
    }

    constructFractal(_nextGrid, true); 
  }  

  void draw() {
    pg.beginDraw();
    drawRoutine();
    pg.endDraw();
  }

  protected void drawRoutine() {
    for(int i = 0; i < _w; i++) {
      for(int j = 0; j < _h; j++) {
        pg.stroke(getInterpolatedColor(i, j, (PATTERN_LENGTH - _generations) / (double) PATTERN_LENGTH));
        pg.point(i, j);
      }
    }

    if(_generations < 0) {
      chooseColors();
      constructNextFractal();
      _generations = PATTERN_LENGTH;
    }
   
    _generations--; 
  }
  
  protected void chooseColors() {
    _color1 = generateColor.get();
    _color2 = generateColor.get();

    _c1Red = (_color1 >> 16) & 0xFF;
    _c1Green = (_color1 >> 8) & 0xFF;
    _c1Blue = (_color1 >> 0) & 0xFF;
    _c2Red = (_color2 >> 16) & 0xFF;
    _c2Green = (_color2 >> 8) & 0xFF;
    _c2Blue = (_color2 >> 0) & 0xFF;
  }
}

class CloudFractalPresets extends SetList {
  CloudFractalPresets() {
  }

  CloudFractalPresets(SetList setList) {
    super(setList);
  }

  void setup() {
  }

  void doPlasmaClouds(Canvas canvas) {
    GenColorSequence gcs = new GenColorSequence();
    CloudFractalPlasma cloudFractalPlasma = new CloudFractalPlasma(null, 0.9, 64, 210, 0.3);

    gcs.colors.add(color(pornj, 128));
    gcs.colors.add(color(0));
    gcs.colors.add(color(disorientOrange, 128));
    gcs.colors.add(color(0));
    cloudFractalPlasma.generateColor = gcs;
    cloudFractalPlasma.setFreq(5);

    setCanvas(canvas, cloudFractalPlasma);
  }

  void doPlasmaCloudsMore(Canvas canvas) {
    double exp = 0.3;
    CloudFractalPlasma cloudFractalPlasma = new CloudFractalPlasma(null, 0.9, 64, 210, exp);
    CloudFractalPlasma cloudFractalPlasma2 = new CloudFractalPlasma(null, 0.9, 64, 210, exp);

    GenColorSequence gcs = new GenColorSequence();
    gcs.colors.add(pornj);
    gcs.colors.add(color(0));
    gcs.colors.add(pornj);
    gcs.colors.add(color(0));
    gcs.colors.add(pornj);
    gcs.colors.add(color(0));
    gcs.colors.add(pornj);
    gcs.colors.add(color(0));
    gcs.colors.add(pornj);
    gcs.colors.add(color(0));
    gcs.colors.add(pornj);
    gcs.colors.add(color(0));
    gcs.colors.add(disorientOrange);
    gcs.colors.add(color(0));
    gcs.colors.add(disorientOrange);
    gcs.colors.add(color(0));
    gcs.colors.add(disorientOrange);
    gcs.colors.add(color(0));
    gcs.colors.add(disorientOrange);
    gcs.colors.add(color(0));
    gcs.colors.add(disorientOrange);
    gcs.colors.add(color(0));
    gcs.colors.add(disorientOrange);
    gcs.colors.add(color(0));

    GenColorSequence gcs2 = new GenColorSequence();
    gcs2.colors.add(pink);
    gcs2.colors.add(color(0));

    cloudFractalPlasma.generateColor = gcs;
    cloudFractalPlasma.setFreq(5);
    cloudFractalPlasma2.generateColor = gcs2;
    cloudFractalPlasma2.setFreq(3);

    setCanvas(canvas, cloudFractalPlasma);
    pushCanvas(canvas, cloudFractalPlasma2);
  }
}

