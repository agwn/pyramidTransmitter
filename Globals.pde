color pornj = color(252, 23, 218);
color disorientOrange = color(255, 128, 0);

int sineTableSize = 256;
float sineTableSizeInv = 1.0 / sineTableSize;
float[] sineTable;
float sineTableNormSizeInv = 1.0 / sineTableSize;
float[] sineTableNorm;
DisorientFont disFont;
Bitmap selfPortraitMap;

void setupGlobals() {
  initSineTable();
  disFont = new DisorientFont();
  selfPortraitMap = new Bitmap(SELF_PORTRAIT, 32, 32);
}

void initSineTable() {
  sineTable = new float[sineTableSize];
  sineTableNorm = new float[sineTableSize];

  for (int i = 0; i < sineTableSize; i++) {
    sineTable[i] = sin(i * sineTableSizeInv * TWO_PI);
    sineTableNorm[i] = sin(i * sineTableNormSizeInv * TWO_PI) * 0.5 + 0.5;
  }
}


// ----------------------------------------------------------------------
// DEPRECATED!!
/*
These are being phased out.
If removed right now, the entire thing breaks.
If a routine breaks, no worries, it will be reimplemented.
*/

String kbdInput = "";
int lf = int('\n'); // ASCII linefeed
// values set by user input
int[] setVarMin = { 64, 64, 64 };
int[] setVarMax = { 128, 128, 128 };
// values used by program
int[] varMin = { 64, 64, 64 };
int[] varMax = { 128, 128, 128 };
int[] varRange = { 32, 32, 32 };
long modeFrameStart;
int mode = 0;
// Font related
int w = 0;
int x = 64;
void newMode() { }
void newMode(int foo) { }
// *** END DEPRECATED!! ***
