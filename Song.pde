class Song {
  float x, y;
  color currentColor;
  color baseColor = color(#F4F4E9);
  color highlightColor = color(#FEF6D8);
  float diameter;
  int song_id;
  boolean overCircle;
  String artist, title;

  Song(int _date, int _rank, int _song_id, String _artist, String _title){
    
    float angle = PI + HALF_PI + (2 * PI/42) * _date;
    float radius = map(_rank, 1, 50, 50, 1000 / 2 - 30);
    //float radius = map(_rank, 1, 50, 50, width / 2 - 50);
    song_id = _song_id;
    artist = _artist;
    title = _title;
    
    x = center.x + cos(angle)*radius;
    y = center.y + sin(angle)*radius;
    
    currentColor = baseColor;
    diameter = 3;
    
  }

  boolean overCircle(float x, float y, float diameter){
    float distX = x - mouseX;
    float distY = y - mouseY;
    
    if (sqrt(sq(distX) + sq(distY)) < diameter/2) {
      overCircle = true;
      return true;
    } else {
      overCircle = false;
      return false;
    }
  }
  
  void update() { // update when overcircle
    if (overCircle(x, y, diameter)) {
      currentColor = highlightColor;
      diameter = 6;
      
      //display artist and title on the top
      rectMode(CENTER);
      fill(255, 200);
      rect(center.x, 30, width-500, 30);
      
      textAlign(CENTER);
      fill(0);
      text(artist + " - " + title, center.x, 35);
      
    } else {
      diameter = 3;
      currentColor = baseColor;
    }
  }
  
  void update2(){
    currentColor = highlightColor;
    diameter = 5;
    
    //display artist and title on the top
    rectMode(CENTER);
    fill(255, 200);
    rect(center.x, 30, width-500, 30);
    
    textAlign(CENTER);
    fill(0);
    text(artist + " - " + title, center.x, 35);
  
  }
  
  void display(){
    noStroke();
    fill(currentColor);
    ellipse(x, y, diameter, diameter);
  }
}
