class GenerateColor {
  color get() {
    return color(0, 0);
  }
}

class GenRandomColor extends GenerateColor {
  color get() {
    return color(random(256), random(256), random(256));
  }
}

class GenLerpColor extends GenerateColor {
  color c0;
  color c1;

  GenLerpColor() {
    c0 = color(255);
    c1 = color(0);
  }

  color get() {
    return lerpColor(c0, c1, random(1.0));
  }
}

class GenCampColor extends GenLerpColor {
  GenCampColor() {
    c0 = pornj;
    c1 = disorientOrange;
  }
}

