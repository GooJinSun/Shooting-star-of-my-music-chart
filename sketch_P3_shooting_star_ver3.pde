import processing.pdf.*;

// set for interaction
boolean songPressed = false;
int status = 0;
int pressedSong;

Table table;
PVector center;
ArrayList<Song> songs = new ArrayList<Song>();

//same songs in and out array
ArrayList <float[]> sameSongs = new ArrayList <float[]>();

//not have same song
ArrayList<Song> siglesongs = new ArrayList<Song>();

//twinkle stars
int[] starX = new int[300];
int[] starY = new int[300];
color[] starColor = new color[300];
int starSize = (int)random(2, 3);

//shooting stars
ArrayList <ShootingStar> shootingstars = new ArrayList<ShootingStar>();
float findthis[];

int [] showlist = {28, 2, 191, 217, 743, 245, 436, 118, 11, 376, 346, 652, 
  563, 657, 637, 63, 118, 234, 291, 338, 336, 338, 418, 210, 234, 289, 236, 211, 212, 
  436, 424, 470, 490, 450, 593, 557, 587, 615, 653, 683, 704, 
  718, 719, 710, 763, 771, 783, 785, 784, 
  793, 799, 821, 830, 21, 22, 11, 94, 82, 134, 189, 166, 192, 
  849, 843, 845, 849, 851, 858, 856, 857, 863, 866, 750, 779, 749, 
  877, 887, 881, 889, 882, 894, 890, 898, 896, 895, 893, 
  904, 905, 911, 913, 917, 919, 921, 925, 882, 889, 833, 888, 828, 899, 
  938, 942, 949, 950, 952, 956, 958, 962, 956, 965, 
  972, 971, 976, 985, 980, 981, 995, 992, 998, 
  1004, 1017, 1021, 1029, 1025, 1020, 1022, 
  1037, 1039, 1030, 1049, 1041, 1062, 1063, 1074, 1070, 1071, 1065, 
  1076, 1080, 1087, 1138, 1139, 1142, 1148, 1157};


void setup() {
  fullScreen();
  //size(1000, 1000);
  center = new PVector(width/2, height/2);
  table = loadTable("melon.csv", "header");

  //set for twinkle stars
  for (int i = 0; i < starX.length; i++) {
    starX[i] =(int)random(width);
    starY[i] = (int)random(height);
    starColor[i] = color((int)random(100, 255));
  }

  // set for all songs
  for (TableRow row : table.rows()) {
    int date = row.getInt("date_coding");
    int rank = row.getInt("rank");
    int song_id = row.getInt("song_id");
    String artist = row.getString("artist");
    String title = row.getString("title");

    songs.add(new Song(date, rank, song_id, artist, title));
  }

  ////set for all songs of a specific genre
  //for (TableRow row : table.findRows(str(10), "genre_coding")) {
  //  int date = row.getInt("date_coding");
  //  int rank = row.getInt("rank");
  //  int song_id = row.getInt("song_id");;
  //  songs.add(new Song(date, rank, song_id));
  //}

  //set for shooting stars
  for (int i = 0; i < songs.size(); i++) {
    ArrayList<Song> findSongs = new ArrayList<Song>();
    int findthis = songs.get(i).song_id;
    for (TableRow row : table.findRows(str(findthis), "song_id")) {
      int date = row.getInt("date_coding");
      int rank = row.getInt("rank");
      int song_id = row.getInt("song_id");    
      String title = row.getString("title");
      String artist = row.getString("artist");

      findSongs.add(new Song(date, rank, song_id, artist, title));
    }

    if (findSongs.size() > 1) {
      float inX = findSongs.get(0).x;
      float inY = findSongs.get(0).y;
      float outX = findSongs.get(findSongs.size()-1).x;
      float outY = findSongs.get(findSongs.size()-1).y;

      float [] inout = new float[4];
      inout[0] = inX;
      inout[1] = inY;
      inout[2] = outX;
      inout[3] = outY;
      sameSongs.add(inout);

      ShootingStar newShootingStar = new ShootingStar(inout);
      shootingstars.add(newShootingStar);
    } else {
    }
  }
}

void draw() {

  switch(status) {

    //default
  case 0:
    background(#0F1A2D);

    //twinkle stars
    stroke(#0F1A2D);
    strokeWeight(0.5);
    for (int i = 0; i < starX.length; i++) {
      fill(random(50, 255));
      if (random(10) < 1) {
        starColor[i] = (int)random(0, 255);
      }
      fill(starColor[i]);
      ellipse(starX[i], starY[i], starSize, starSize);
    }

    //song display
    for (int i = 0; i < songs.size(); i++) {
      songs.get(i).display();
    }

    for (int i = 0; i < songs.size(); i++) {
      songs.get(i).update();
    }

    for (int i = 0; i < showlist.length; i++) {
      shootingstars.get(showlist[i]).display();
    }

    break;

    //specific song is pressed
  case 1: 

    background(#0F1A2D);

    //twinkle stars
    stroke(#0F1A2D);
    strokeWeight(0.5);
    for (int i = 0; i < starX.length; i++) {
      fill(random(50, 255));
      if (random(10) < 1) {
        starColor[i] = (int)random(0, 255);
      }
      fill(starColor[i]);
      ellipse(starX[i], starY[i], starSize, starSize);
    }

    //song display
    for (int i = 0; i < songs.size(); i++) {
      songs.get(i).display();
    }

    for (int i = 0; i < showlist.length; i++) {
      shootingstars.get(showlist[i]).display();
    }



    fill(#0F1A2D, 125);
    rectMode(CENTER);
    rect(center.x, center.y, width, height);

    songs.get(pressedSong).update2();
    println(pressedSong);

    //set for shooting stars
    ArrayList<Song> findSongs = new ArrayList<Song>();
    ShootingStar shootingStar;

    int findthis = songs.get(pressedSong).song_id;

    for (TableRow row : table.findRows(str(findthis), "song_id")) {
      int date = row.getInt("date_coding");
      int rank = row.getInt("rank");
      int song_id = row.getInt("song_id");   
      String artist = row.getString("artist");
      String title = row.getString("title");

      findSongs.add(new Song(date, rank, song_id, artist, title));
    }

    stroke(255, 125);
    strokeWeight(2);
    noFill();

    beginShape();
    curveVertex(findSongs.get(0).x, findSongs.get(0).y);
    for (Song findthissong : findSongs) {

      curveVertex(findthissong.x, findthissong.y);
    }
    curveVertex(findSongs.get(findSongs.size()-1).x, findSongs.get(findSongs.size()-1).y);
    endShape();
    stroke(255, 125);

  default:       // Default executes if the case labels

    break;
  }
}

void mousePressed() {

  if (status == 1) {
    status = 0;
    pressedSong = 0;
  } else {
    int i = 0;
    status = 0;
    songPressed = false;

    while (i < songs.size()) {
      if (songs.get(i).overCircle) {
        break;
      }
      i++;
    }

    if (i == 2100) {

      songPressed = false;
      status = 0;
    } else {
      pressedSong = i;
      status = 1;
      songPressed = true;
    }

    println(songPressed);
    println(status);
  }
}
