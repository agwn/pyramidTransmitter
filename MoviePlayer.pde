GSMovie myMovie;

class MoviePlayer extends CanvasRoutine {
  int w;
  int h;
  GSMovie movie;

  MoviePlayer(GSMovie movie_) {
    movie = movie_;
  }

  void reinit() {
    w = pg.width;
    h = pg.height; 
  }

  void draw() {
    pg.beginDraw();
    pg.image(movie, 0, 0, w, h);
    pg.endDraw();
  }
}

void movieEvent(GSMovie m) {
    m.read();
}

void setupMyMovie() {
  myMovie = new GSMovie(this, "station.mov");
  myMovie.loop();
  myMovie.frameRate(FRAMERATE);
}
