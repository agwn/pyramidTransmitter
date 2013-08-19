color pornj = color(252, 23, 218);
color disorientOrange = color(255, 128, 0);
color pink = color(255, 128, 128);
DisorientFont disFont;
Bitmap selfPortraitMap;
SineTable sineTable = new SineTable(256);
SineTableNorm sineTableNorm = new SineTableNorm(256);
PhasorTable phasorTable = new PhasorTable(256);
SawTable sawTable = new SawTable(256);

void setupGlobals() {
  disFont = new DisorientFont();
  selfPortraitMap = new Bitmap(SELF_PORTRAIT, 32, 32);
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
