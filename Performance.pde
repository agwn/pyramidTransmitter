class Disor13ntSequence extends SetList {
  Disor13ntSequence() {
  }

  Disor13ntSequence(SetList setList) {
    super(setList);
  }

  void setup() {
    States states = new States(this);

    states.setDisor13ntColumns(canvas2);
    wait(100.0);
  }
}
