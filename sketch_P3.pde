Table table;
PVector center;
ArrayList<Song> songs = new ArrayList<Song>();

void setup() {
  size(1000, 1000);
  center = new PVector(width/2, height/2);
  
  table = loadTable("melon.csv", "header");
  println(table.getRowCount() + " total rows in table"); 
  
  for (TableRow row : table.rows()) {
    int date = row.getInt("date_coding");
    int rank = row.getInt("rank");
    int genre = row.getInt("genre_coding");
    int song_id = row.getInt("song_id");
    String artist = row.getString("artist");
    String title = row.getString("title");
    
    //date was coded by angle
    float angle = PI + HALF_PI + (2 * PI/42) * date;
    
    //rank was coded by radius
    float radius = map(rank, 1, 50, 50, width / 2 - 50);
    
    //specific position of ellipse
    float x = center.x + cos(angle)*radius;
    float y = center.y + sin(angle)*radius;
    
    songs.add(new Song(x, y, 5, genre, song_id, artist, title, color(255)));
  }
  
  //for (TableRow row : table.findRows("5440651", "song_id")) {
    //println(row.getString("Date") + ": " + row.getString("rank"));
  //}
}

void draw(){
  background(0);
  for (int i = 0; i < table.getRowCount(); i++){
    songs.get(i).display();
  }
  for (int i = 0; i < table.getRowCount(); i++){
      songs.get(i).update();
  }
  
  if (mousePressed){
    ArrayList<Song> findthissongs = new ArrayList<Song>();
    
    // translucent Rect
    fill(0, 125);
    rectMode(CENTER);
    rect(center.x, center.y, width, height);
    
    for (int i = 0; i < table.getRowCount(); i++){
      if (songs.get(i).overCircle){
       
        int findthis = songs.get(i).song_id;
        println(findthis);
        
        for (TableRow row : table.findRows(str(findthis), "song_id")) {
          
          println(row.getString("Date") + ": " + row.getString("rank"));
          
          int date = row.getInt("date_coding");
          int rank = row.getInt("rank");
          int genre = row.getInt("genre_coding");
          
          //date was coded by angle
          float angle = PI + HALF_PI + (2 * PI/42) * date;
          
          //rank was coded by radius
          float radius = map(rank, 1, 50, 50, width / 2 - 50);
          
          //specific position of ellipse
          float x = center.x + cos(angle)*radius;
          float y = center.y + sin(angle)*radius;
          
          findthissongs.add(new Song(x, y, 5));

        }
      }
    }
    
    stroke(255, 125);
    strokeWeight(2);
    noFill();
    
    beginShape();
    curveVertex(findthissongs.get(0).x, findthissongs.get(0).y);
    for (Song findthissong : findthissongs){
 
      curveVertex(findthissong.x, findthissong.y);
      
    }
    curveVertex(findthissongs.get(findthissongs.size()-1).x, findthissongs.get(findthissongs.size()-1).y);
    endShape();stroke(255, 125);
    strokeWeight(2);
    noFill();
    
    beginShape();
    curveVertex(findthissongs.get(0).x, findthissongs.get(0).y);
    for (Song findthissong : findthissongs){
 
      curveVertex(findthissong.x, findthissong.y);
      
    }
    curveVertex(findthissongs.get(findthissongs.size()-1).x, findthissongs.get(findthissongs.size()-1).y);
    endShape();
    for (Song findthissong : findthissongs){
      findthissong.display();
    }
  }
}
