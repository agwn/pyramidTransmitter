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

class GenCampColor extends GenerateColor {
  color get() {
    float r = random(1.0);

    if (r < 0.333) {
      return lerpColor(pornj, disorientOrange, random(1.0));
    }
    else if (r < 0.666) {
      return lerpColor(pink, disorientOrange, random(1.0));
    }

    return lerpColor(pornj, pink, random(1.0));
  }
}

class GenWarpSpeedColor extends GenerateColor {
  int[] varMin = { 64, 64, 64 };
  int[] varMax = { 128, 128, 128 };

  color get() {
    float r = random(varMax[0] >> 2, varMax[0]);
    float g = random(varMax[1] >> 2, varMax[1]);
    float b = random(varMax[2] >> 2, varMax[2]);
    float bright = random(0.5, 2);

    r = constrain(bright * ((long) r), 0, 255);
    g = constrain(bright * ((long) g), 0, 255);
    b = constrain(bright * ((long) b), 0, 255);

    return color(r, g, b);
  }
}

class GenColorSequence extends GenerateColor {
  ArrayList colors;
  private int index = 0;

  GenColorSequence() {
    colors = new ArrayList();
  }

  color get() {
    color c;
    int size = colors.size();

    if (index >= size) {
      index = 0;
    }
    if (index < size && size != 0) {
      c = (color)(Integer) colors.get(index);
    }
    else {
      return color(0, 0);
    }

    index++;    
    return c;
  }
}
