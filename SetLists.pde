class TechDemo extends CanvasRoutineController {
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
