// DNA
// Draws vertical DNA strands with gently shifting colors (our two favorites in the middle :) )
// David Shimel aka keytarmageddon aka dsshimel
// 2013-8-16

public class DNA extends CanvasRoutine {
  GenerateColor genRandomColor = new GenRandomColor();
  boolean overrideColor = false;

  private int _w;		// grid width in number of cells
  private int _h;		// grid height in number of cells
  private Helix[] _helices;
  private int _offset = 0;
  private int _helixWidth;
  private int _panels;
  private double pi = Math.PI;
  private int _modulus;
  private int _barsMovementCoeff = 0;

  private class Helix {
    private color _leftCur;
    private color _rightCur;
    private color _barsCur;
    private color _leftNext;
    private color _rightNext;
    private color _barsNext;
    private int _spacing;
    private double _wavelength;
    private boolean _isDisorient;
    private boolean _sameStrands;
    
    public Helix(int spacing, double wavelength, boolean sameStrands) {
      _sameStrands = sameStrands;
      
      setLeftAndRightCurColors();
      _barsCur = genRandomColor.get();

      setLeftAndRightNextColors();
      _barsNext = genRandomColor.get();
      
      _spacing = spacing;
      _wavelength = wavelength;
      _isDisorient = false;
    }
  
    public Helix(color strandsColor, color barsColor, int spacing, double wavelength) {
      _sameStrands = true;
      _leftCur = strandsColor;
      _rightCur = strandsColor;
      _barsCur = barsColor;
      
      _leftNext = barsColor;
      _rightNext = barsColor;
      _barsNext = strandsColor;
      
      _spacing = spacing;
      _wavelength = wavelength;
      _isDisorient = true;
     }
    
    private void setLeftAndRightCurColors() {
      _leftCur = genRandomColor.get();
      if(_sameStrands) {
        _rightCur = _leftCur;
      }
      else {
        _rightCur = genRandomColor.get();
      }
    }
  
    private void setLeftAndRightNextColors() {
      _leftNext = genRandomColor.get();
      if(_sameStrands) {
        _rightNext = _leftNext;
      }
      else {
        _rightNext = genRandomColor.get();
      }
    }
   
    public double getLeftX(int time, int offset, int panelNum) {
      double amplitude = (_helixWidth - 1) / 2.0;
      int panelCorrection = panelNum * _helixWidth;
      double theCos = Math.cos((2*pi/_wavelength) * (time - offset));
      int cosOffset = 1;
      
      double x = panelCorrection + amplitude * (theCos + cosOffset);

      return Math.round(x);
    }

    public double getRightX(int time, int offset, int panelNum) {
      return (_helixWidth * (panelNum + 1)) - getLeftX(time, offset, panelNum) + (_helixWidth * panelNum) - 1;
    }
    
    private int getLeftColorOffset() {
      
      return (int) Math.round(_leftCur - (_leftCur - _leftNext) * (((double) _offset) / _h));
    }
    
    private int getRightColorOffset() {
      return (int) Math.round(_rightCur - (_rightCur - _rightNext) * (((double) _offset) / _h));
    }
    
    private int getBarsColorOffset() {
      return (int) Math.round(_barsCur - (_barsCur - _barsNext) * (((double) _offset) / _h));
    }
    
    public color getLeftColor() { 
      int lcRed, lcGreen, lcBlue, lnRed, lnGreen, lnBlue;
      lcRed = (_leftCur >> 16) & 0xFF;
      lcGreen = (_leftCur >> 8) & 0xFF;
      lcBlue = (_leftCur >> 0) & 0xFF;
      lnRed = (_leftNext >> 16) & 0xFF;
      lnGreen = (_leftNext >> 8) & 0xFF;
      lnBlue = (_leftNext >> 0) & 0xFF;
      int r = (int) Math.round(lcRed - (lcRed - lnRed) * (((double) _offset) / _h));
      int g = (int) Math.round(lcGreen - (lcGreen - lnGreen) * (((double) _offset) / _h));
      int b = (int) Math.round(lcBlue - (lcBlue - lnBlue) * (((double) _offset) / _h));
      return color(r, g, b);
    }
    public color getRightColor() { 
      int rcRed, rcGreen, rcBlue, rnRed, rnGreen, rnBlue;
      rcRed = (_rightCur >> 16) & 0xFF;
      rcGreen = (_rightCur >> 8) & 0xFF;
      rcBlue = (_rightCur >> 0) & 0xFF;
      rnRed = (_rightNext >> 16) & 0xFF;
      rnGreen = (_rightNext >> 8) & 0xFF;
      rnBlue = (_rightNext >> 0) & 0xFF;
      int r = (int) Math.round(rcRed - (rcRed - rnRed) * (((double) _offset) / _h));
      int g = (int) Math.round(rcGreen - (rcGreen - rnGreen) * (((double) _offset) / _h));
      int b = (int) Math.round(rcBlue - (rcBlue - rnBlue) * (((double) _offset) / _h));
      return color(r, g, b);
    }
    public color getBarsColor() { 
      int bcRed, bcGreen, bcBlue, bnRed, bnGreen, bnBlue;
      bcRed = (_barsCur >> 16) & 0xFF;
      bcGreen = (_barsCur >> 8) & 0xFF;
      bcBlue = (_barsCur >> 0) & 0xFF;
      bnRed = (_barsNext >> 16) & 0xFF;
      bnGreen = (_barsNext >> 8) & 0xFF;
      bnBlue = (_barsNext >> 0) & 0xFF;
      int r = (int) Math.round(bcRed - (bcRed - bnRed) * (((double) _offset) / _h));
      int g = (int) Math.round(bcGreen - (bcGreen - bnGreen) * (((double) _offset) / _h));
      int b = (int) Math.round(bcBlue - (bcBlue - bnBlue) * (((double) _offset) / _h));
      return color(r, g, b);
    }
    public int getSpacing() { return _spacing; }
    public boolean drawBars(int index) { return (index + _barsMovementCoeff*_offset) % _spacing == 0; }
    
    public void changeColors() {
      _leftCur = _leftNext;
      _rightCur = _rightNext;
      _barsCur = _barsNext;

      if(_isDisorient) {
        _leftNext = _barsCur;
        _rightNext = _barsCur;
        _barsNext = _leftCur;
      }
      else {
        setLeftAndRightNextColors();
      }
    }
  } // end Helix class 
  
  // probably doesn't look right if panels != 8
  DNA(int width, int height, int panels) { 
    _w = width;
    _h = height;
    _panels = panels;

    // should be 8 for default inputs
    _helixWidth = _w / _panels; // a.k.a. amplitude

    setModulus();
    
    makeHelices();
  }

  void reinit() {
    setModulus();
    makeHelices(); 
  }
 
 private void setModulus() {
   _modulus = 4 + ((int) Math.floor(Math.random() * 13));
 }
   
 
 private void makeHelices() {
   _helices = new Helix[_panels]; 
   
   for(int i = 0; i < (_panels / 2); i++) {
     double wavelength;
     switch(i) {
       case 0:
         wavelength = _h / 7.0;
         break;
       case 1:
         wavelength = _h / 3.0;
         break;
       case 2:
         wavelength = _h / 2.0;
         break;         
       case 3:
         wavelength = _h / 1.0;
         break;         
       default:
         wavelength = _h / 0.5;
         break;
     }
     int spacingOffset = 3*i + 2;
     boolean sameStrands = i % 2 == 1;

      if(i == _panels / 2 - 1 && overrideColor == false) { // the center panel(s)
         System.out.println(i + ", " + (_panels - i - 1));
        _helices[i] = new Helix(pornj, disorientOrange, spacingOffset, wavelength);
        _helices[_panels - i - 1] = new Helix(disorientOrange, pornj, spacingOffset, wavelength);
      }
      else {
        _helices[i] = new Helix(spacingOffset, wavelength, sameStrands);
        _helices[_panels - i - 1] = new Helix(spacingOffset, wavelength, sameStrands);
      }
    }
 } 
  
  void draw() {
    pg.beginDraw();
    pg.background(0);
    
    drawHelices();
        
    pg.endDraw();
  }
  
  private void drawHelices() {
    for(int panelNum = 0; panelNum < _helices.length; panelNum++) {
      drawHelix(_helices[panelNum], panelNum);
    }
    _offset++;
    if(_offset > _h) {
      _offset = 0;
      changeHelixColors();
      setModulus();
      _barsMovementCoeff = (int)(Math.floor(Math.random() * 12) - 6);
    }
  }
  
  private void changeHelixColors() {
    for(Helix h : _helices) {
      h.changeColors();
    }
  }
  
  private void drawHelix(Helix h, int panelNum) {
    drawBars(h, panelNum);
    drawLeft(h, panelNum);
    drawRight(h, panelNum);
  }
  
  private void drawLeft(Helix h, int panelNum) {
    pg.noStroke();
    pg.stroke(h.getLeftColor());
    for(int t = 0; t < _h; t++) {
      pg.point((float)h.getLeftX(t, _offset, panelNum), (float)t);
    }
  }

  private void drawRight(Helix h, int panelNum) {
    pg.noStroke();
    pg.stroke(h.getRightColor());
    for(int t = 0; t < _h; t++) {
      pg.point((float)h.getRightX(t, _offset, panelNum), (float)t);
    }
  }



  private void drawBars(Helix h, int panelNum) {
    pg.noStroke();
    pg.stroke(h.getBarsColor());
    for(int t = 0; t < _h; t++) {
      if(h.drawBars(t) && (11*t + 13*_offset + 17*panelNum) % _modulus != 0) {
        float xl = (float) h.getLeftX(t, _offset, panelNum);
        float xr = (float) h.getRightX(t, _offset, panelNum);
        pg.line(xl, (float)t, xr, (float)t);
      }
    }
  }  
}

class DNAPlayer extends SetList {
  
  DNAPlayer() { 
  }

  DNAPlayer(SetList setList) {
    super(setList);
  }
  
  void setup() {
    int panels = 8;
    DNA dna = new DNA(64, 210, panels);


    setCanvas(canvas2, dna);
    wait(60.0);
  }
}
