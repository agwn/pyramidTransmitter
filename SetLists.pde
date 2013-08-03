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
    Canvas c0 = canvases[0];
    Canvas c1 = canvases[1];
    Canvas c2 = canvases[2];
    Canvas c3 = canvases[3];

    WarpSpeedMrSulu warpSpeed = new WarpSpeedMrSulu(100);
    SineColumns sines = new SineColumns();
    Pxxxls pxxxls = new Pxxxls(150);
    Pxxxls pxxxlFilter = new Pxxxls(50);
    pxxxlFilter.setBlendMode(DODGE);
    pxxxlFilter.setPaintMode(pxxxlFilter.BLEND);
    Waves waves = new Waves();
    Seizure seizure = new Seizure();
    Mirror mirror = new Mirror();
    Warp warp = new Warp();
    warp.hAmp = 1.0;
    warp.vAmp = 1.0;
    warp.hCycles = 0.2;
    warp.vCycles = 0.17;
    Grid grid = new Grid();
    Fire fire = new Fire();
    Trails trails = new Trails();

    MoviePlayer moviePlayer = new MoviePlayer(myMovie);
    moviePlayer.setBlendMode(DODGE);
    moviePlayer.setPaintMode(moviePlayer.BLEND);

    float w = 5.0;
    trails.fade = 16;

    //setCanvas(c2, warpSpeed);
    setCanvas(c2, waves);
    pushCanvas(c2, pxxxlFilter);
    pushCanvas(c2, warp);
    pushCanvas(c2, trails);
    pushCanvas(c2, mirror);
    wait(15.0);
  }
}
