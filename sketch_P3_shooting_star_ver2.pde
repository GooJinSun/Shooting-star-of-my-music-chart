import processing.pdf.*;

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
ShootingStar sample1;
float findthis[];

void setup() {
  size(1000, 1000);
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
    
    songs.add(new Song(date, rank, song_id));
  }
  
  ////set for all songs of a specific genre
  //for (TableRow row : table.findRows(str(8), "genre_coding")) {
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
      findSongs.add(new Song(date, rank, song_id));
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
  //beginRecord(PDF, "scheme_rank.pdf"); 
}

void draw() {
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

  //// rank circle
  //for (int i = 1; i <= 50; i++) {
  //  float diameter = map(i, 1, 50, 100, width-100);
  //  noFill();
  //  strokeWeight(1);
  //  stroke(150);
  //  ellipse(center.x, center.y, diameter, diameter);
  //}
  
  // rank circle for scheme
  //noFill();
  //strokeWeight(4);
  //stroke(255);
  //ellipse(center.x, center.y, 100, 100);
  //ellipse(center.x, center.y, width-100, width-100);
  
  // //date line
  //for (int i = 1; i <= 42; i++){
  //  float angle = PI + HALF_PI + (2 * PI/42) * i;
  //  float firstX = center.x + cos(angle)*50;
  //  float firstY = center.x + sin(angle)*50;
  //  float secondX = center.x + cos(angle)*(width/2 - 50);
  //  float secondY = center.x + sin(angle)*(width/2 - 50);
  //  strokeWeight(0.5);
  //  stroke(255);
  //  line(firstX, firstY, secondX, secondY);
  //}
  
  //song display
   for (int i = 0; i < songs.size(); i++){
     songs.get(i).display();
   }
   
   //// show all shooting stars
   //for(int i = 0; i < shootingstars.size(); i++ ){
   //  shootingstars.get(i).display();
   //}

  //shooting star display(final)
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
  
  for (int i = 0; i < showlist.length; i++) {
    shootingstars.get(showlist[i]).display();
    
    ///set for final data display
    //fill(#0F1A2D);
    //rectMode(CENTER);
    //rect(shootingstars.get(showlist[i]).inX, shootingstars.get(showlist[i]).inY, 20, 10);
    
    //fill(255, 0, 0);
    //textSize(10);
    //textAlign(CENTER);
    //text(showlist[i], shootingstars.get(showlist[i]).inX, shootingstars.get(showlist[i]).inY +2);
    //endRecord();
  }
}

  //for (int i = 200; i < 300; i ++) {
  //  shootingstars.get(i).display();

  //  fill(#0F1A2D);
  //  rectMode(CENTER);
  //  rect(shootingstars.get(i).inX, shootingstars.get(i).inY, 20, 10);

  //  fill(255, 255, 0);
  //  textSize(10);
  //  textAlign(CENTER);
  //  text(i, shootingstars.get(i).inX, shootingstars.get(i).inY + 2);
  //}
