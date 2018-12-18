class Song {
  float x, y;
  color currentColor, highlightColor;
  float diameter;
  int song_id;

  Song(int _date, int _rank, int _song_id){
    float angle = PI + HALF_PI + (2 * PI/42) * _date;
    float radius = map(_rank, 1, 50, 50, width / 2 - 50);
    song_id = _song_id;
    
    x = center.x + cos(angle)*radius;
    y = center.y + sin(angle)*radius;

    currentColor = color(#F4F4E9);
    diameter = 3;
  }

  void display(){
    noStroke();
    fill(currentColor);
    ellipse(x, y, diameter, diameter);
  }
}
