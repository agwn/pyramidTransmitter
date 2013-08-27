class WaveTable {
  protected int size;
  protected float inverse;
  protected float[] data;

  WaveTable(int size_) {
    size = size_;
    inverse = 1.0 / size;
    data = new float[size]; 
    generate();
  }

  void generate() { }

  int getSize() {
    return size;
  }

  float[] getData() {
    return data;
  }
}

class SineTable extends WaveTable {
  SineTable(int size) {
    super(size);
  }

  void generate() {
    for (int i = 0; i < size; i++) {
      data[i] = sin((float) i * inverse * TWO_PI);
    }
  }
}

class SineTableNorm extends WaveTable {
  SineTableNorm(int size) {
    super(size);
  }

  void generate() {
    for (int i = 0; i < size; i++) {
      data[i] = sin((float) i * inverse * TWO_PI) * 0.5 + 0.5;
    }
  }
}

class SawTable extends WaveTable {
  SawTable(int size) {
    super(size);
  }

  void generate() {
    for (int i = 0; i < size; i++) {
      data[i] = ((float) i / size) * 2.0 - 1.0;
    }
  }
}

class PhasorTable extends WaveTable {
  PhasorTable(int size) {
    super(size);
  }

  void generate() {
    for (int i = 0; i < size; i++) {
      data[i] = (float) i / size;
    }
  }
}
