class TechDemo extends SetList {
  TechDemo() {
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
  Demo() {
    // Shorter variables for less typing
    Canvas c0 = canvases[0];
    Canvas c1 = canvases[1];
    Canvas c2 = canvases[2];
    Canvas c3 = canvases[3];

    // Global wait time between routine changes
    float w = 10.0;

    WarpSpeedMrSulu warpSpeed = new WarpSpeedMrSulu(100);
    Warp warp = new Warp();
    Mirror mirror = new Mirror();
    Waves waves = new Waves();

    Pxxxls pxxxls = new Pxxxls(50);
    Pxxxls pxxxlFilter = new Pxxxls(50);
    pxxxlFilter.setBlendMode(DODGE);
    pxxxlFilter.setPaintMode(pxxxlFilter.BLEND);


/*
    Part I

    This demonstrates that each canvas is a queue of routines. As routines
    are added to a canvas, they create chain. During the draw phase of
    the SetList loop, the routines are executed in the
    order in which they were added to the canvas.

    This first chain starts with warpSpeed, then adds warp, them mirror.    
*/
    setCanvas(c2, warpSpeed);  // Start warpSpeed routine
    wait(w);                   // Wait
    pushCanvas(c2, warp);      // Push the warp filter onto the canvas queue,
                               // applying the fx to warpSpeed
    wait(w);
    pushCanvas(c2, mirror);    // Push the mirror filter to the canvas queue,
                               // applying to warpSpeed + warp 
    wait(w);

/*
    Part II

    Routines for generating patterns can also be used to filter patterns
    generated earlier in the chain. This is accomplished by setting 

    For example, let's start with the Wave pattern. Then after a pause,
    the pxxxl pattern will be added. If you go back to the top of this
    class, you'll notice that I set the blend mode to DODGE and paint
    mode to BLEND. The change you'll see is that the pixxxls are combined
    inside of the shape of the wave.

    One last point. I add wrap and mirror filters, and shortly after wards add
    the warpSpeed routine. Since the mirror was added before warpSpeed,
    the warpSpeed routine is not mirrored.
*/

    setCanvas(c2, pxxxls);      // Just to show what the pxxls look like
    wait(w);
    setCanvas(c2, waves);      // SetCanvas restarts the canvas queue.
    wait(w);
    pushCanvas(c2, pxxxlFilter);
    wait(w);
    pushCanvas(c2, warp);       // Now it's warped
    wait(w);
    pushCanvas(c2, mirror);     // Now it's mirrored.
    wait(w);
    pushCanvas(c2, warpSpeed);  // Since this comes after the mirror filter,
                                // warpSpeed is not mirrored.
    wait(w);
  }
}

class DebuggingSetList extends SetList {
  DebuggingSetList() {
    WarpSpeedMrSulu warpSpeed = new WarpSpeedMrSulu(20);
    SineColumns sines = new SineColumns();
    Pxxxls pxxxls = new Pxxxls(15);
    Pxxxls pxxxlFilter = new Pxxxls(100);
    Waves waves = new Waves();
    Seizure seizure = new Seizure();
    Mirror mirror = new Mirror();
    Warp warp = new Warp();
    Warp warp2 = new Warp();
    Grid grid = new Grid();
    Fire fire = new Fire();
    Trails trails = new Trails();
    Trails trails2 = new Trails();
    Bursts bursts = new Bursts();
    Sparkle sparkle = new Sparkle();
    Sparkle sparkle2 = new Sparkle();
    MoviePlayer moviePlayer = new MoviePlayer(myMovie);
    Breather breather = new Breather();
    Breather breather2 = new Breather();
    SimpleWave simpleWave = new SimpleWave();
    DisplayDisorient displayDisorient = new DisplayDisorient();
    DisplayDisorient displayDisorient2 = new DisplayDisorient();
    DisorientScroll disorientScroll = new DisorientScroll();
    DisorientScroll disorientScroll2 = new DisorientScroll();
    DisplayImage displayImage = new DisplayImage(selfPortraitMap.getAsPImage(color(255), 0, 0));
    ScrollImage scrollImage = new ScrollImage(selfPortraitMap.getAsPImage(color(255), 0, 4));

    moviePlayer.setBlendMode(DODGE);
    moviePlayer.setPaintMode(moviePlayer.BLEND);
    pxxxlFilter.setBlendMode(DODGE);
    pxxxlFilter.setPaintMode(pxxxlFilter.BLEND);
    warp.hAmp = 1.0;
    warp.vAmp = 1.0;
    warp.hCycles = 0.17;
    warp.vCycles = 0.14;
    trails.fade = 32;
    sparkle.threshold = 16;
    sparkle.nDots = 1200;
    sparkle.dotToCrossRatio = 1.0;
    //sparkle.setBlendMode(sparkle.DIRECT);
    sparkle.c = color(255, 128);
    sparkle2.nDots = 1000;
    sparkle2.threshold = 16;
    sparkle2.setBlendMode(sparkle.DIRECT);
    sines.theStrokeWeight = 2;
    breather.setBlendMode(MULTIPLY);
    breather.c0 = color(pornj, 255);
    breather.c1 = color(disorientOrange, 255);
    breather.phaseInc = 0.025;
    breather2.setBlendMode(MULTIPLY);
    breather2.c0 = color(lerpColor(pornj, color(0), 0.8));
    breather2.c1 = color(lerpColor(disorientOrange, color(0), 0.9));
    breather2.phaseInc = 0.01;
    simpleWave.amp = 0.125;
    simpleWave.spread = 1.5;
    simpleWave.nWaves = 2;
    simpleWave.bias = 0.25;
    simpleWave.theColor = color(255, 180);
    simpleWave.freq = -1.0;

    displayDisorient.x = 24;
    displayDisorient.y = 30; 
    displayDisorient.xPad = 0;
    displayDisorient.doRotate = true;
    displayDisorient.xFlip = true;
    displayDisorient.yPad = 1;

    displayDisorient2.x = 32;
    displayDisorient2.y = 30; 
    displayDisorient2.xPad = 0;
    displayDisorient2.yPad = 1;
    displayDisorient2.doRotate = true;
    displayDisorient2.yFlip = true;

    disorientScroll.x = 24;
    disorientScroll.y = 210;
    disorientScroll.xPad = 0;
    disorientScroll.doRotate = true;
    disorientScroll.xFlip = true;
    disorientScroll.yPad = 2;
    disorientScroll.ySpeed = -4;

    disorientScroll2.x = 32;
    disorientScroll2.y = 210; 
    disorientScroll2.xPad = 0;
    disorientScroll2.yPad = 2;
    disorientScroll2.doRotate = true;
    disorientScroll2.yFlip = true;
    disorientScroll2.ySpeed = 4;

    scrollImage.x = -32;
    scrollImage.y = 50;
    scrollImage.xSpeed = 1;

    setCanvas(canvas2, scrollImage); 
    setCanvas(canvas3, disorientScroll); 
    wait(60.0);
  }
}
