class ShootingStar {
  float middleX, middleY;
  float diameter;
  float radius = diameter/2;
  float startangle;
  float endangle; 
  float angle;
  //float speed = 0.01;
  float x, y;
  float [] xpos, ypos;
  
  float inX, inY, outX, outY;
  
  ShootingStar(float[] inout){
     middleX = (inout[0]+inout[2])/2;
     middleY = (inout[1]+inout[3])/2;
     diameter = dist(inout[0], inout[1], inout[2], inout[3]);
     radius = diameter/2;
     startangle = atan2(inout[1] - middleY, inout[0] - middleX);
     endangle = atan2(inout[3] - middleY, inout[2] - middleY);
     angle = startangle;
     
     xpos = new float[int(diameter * 2/3)];
     ypos = new float[int(diameter * 2/3)];
     
     //xpos = new float[200];
     //ypos = new float[200];
     
     inX = inout[0];
     inY = inout[1];
     outX = inout[2];
     outY = inout[3];
     
     for (int i = 0; i < xpos.length; i++) {
       //angle = map(i, 0, xpos.length, startangle, startangle + PI * 1/3);
       angle = map(i, 0, xpos.length, startangle, startangle + PI);
       xpos[i] = middleX + cos(angle) * radius;
       ypos[i] = middleY + sin(angle) * radius;
     }
  }
  
  void display(){
    
    for (int i = 0; i <xpos.length; i++){
      float starSize = map(i, 0, xpos.length, 4, 0);
      noStroke();
      fill(255, 80);
      ellipse(xpos[i], ypos[i], starSize, starSize);
    }
  }

}
