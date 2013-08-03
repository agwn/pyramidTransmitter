color pornj = color(252, 23, 218);
color disorientOrange = color(255, 128, 0);


int sineTableSize = 256;
float sineTableSizeInv = 1.0 / sineTableSize;
float[] sineTable;

void setupGlobals() {
  initSineTable();
}

void initSineTable() {
  sineTable = new float[sineTableSize];

  for (int i = 0; i < sineTableSize; i++) {
    sineTable[i] = sin(i * sineTableSizeInv * TWO_PI);
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
