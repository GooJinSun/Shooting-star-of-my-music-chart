class Song {
  float x, y;
  color [] cols = {#093663, #074081, #0868AC, #2A8CBD, #4EB3D3, #7CCCC3, #A8DDB5, #CCEAC5, #DFF3DB, #F7FCF0, #F7FCF0};
  //color [] cols = {#EBDBCE, #D29F8B, #DBC6AB, #9E786C, #C5A9A6, #C5A9A6, #EBDBCE, #D29F8B, #DBC6AB, #9E786C,#C5A9A6};
  
  color currentColor, baseColor, highlightColor;
  float diameter;
  boolean overCircle;
  int song_id;
  String artist, title;
  
  
  Song(float _x, float _y, float _diameter, int _genre, int _song_id, String _artist, String _title, color _highlightColor){
    x = _x;
    y = _y;
    baseColor = cols[_genre];
    highlightColor = _highlightColor;
    currentColor = baseColor;
    diameter = _diameter;
    song_id = _song_id;
    artist = _artist;
    title = _title;
    overCircle = false;
  }
  
  Song(float _x, float _y, float _diameter){
    x = _x;
    y = _y;
    currentColor = color(255);
    diameter = _diameter;
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
  
  void update() {
    if (overCircle(x, y, diameter)) {
      currentColor = highlightColor;
      diameter = 8;
      
      //display artist and title on the bottom
      rectMode(CENTER);
      fill(255);
      rect(center.x, height-30, width, 30);
      
      textAlign(CENTER);
      fill(0);
      text(artist + " - " + title, center.x, height-25);
      
    } else {
      currentColor = baseColor;
      diameter = 5;
    }
  }
  
  void display(){
    noStroke();
    fill(currentColor);
    ellipse(x, y, diameter, diameter);
  }
}
