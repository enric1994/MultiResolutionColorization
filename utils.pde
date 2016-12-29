//SHOW IMAGE IN NUMBERS
void showMatrix3D(float[][][] mat) {
  int iwidth=mat.length;
  int iheight=mat[1].length;

  pushMatrix();
  background(255);
  textSize(8);
  stroke(2);
  for (int i=0; i<iwidth; i++) {
    for (int j=0; j<iheight; j++) {
      fill(255, 0, 0);
      if (i%20==0 && j%50==0)text(int(mat[i][j][0]), i, j);
      fill(0, 255, 0);
      if (i%20==0 && j%50==0)text(int(mat[i][j][1]), i, j);
      fill(0, 0, 255);
      if (i%20==0 && j%50==0)text(int(mat[i][j][2]), i, j);
    }
  } 
  popMatrix();
}

//SHOW IMAGE IN NUMBERS
void showMatrix2D(float[][] mat, float n) {
  int iwidth=mat.length;
  int iheight=mat[1].length;

  pushMatrix();
  background(50, 100, 150);
  textSize(8);
  stroke(2);
  for (int i=0; i<iwidth; i++) {
    for (int j=0; j<iheight; j++) {

      fill(255, 255, 255);
      text(int(mat[i][j]), i*n, j*n);
    }
  } 
  popMatrix();
}
void drawEllipses(float[][][] mat, float s, int sep) {
  int iwidth=mat.length;
  int iheight=mat[1].length;
  //noStroke();
  for (int i=0; i<iwidth; i++) {
    for (int j=0; j<iheight; j++) {

      fill(mat[i][j][0], mat[i][j][1], mat[i][j][2]);
      ellipse(i*s, j*s, 10, 10);
    }
  }
}
void drawEllipses2D(float[][] mat, float s, int sep) {
  int iwidth=mat.length;
  int iheight=mat[1].length;
  for (int i=0; i<iwidth; i++) {
    for (int j=0; j<iheight; j++) {

      fill(mat[i][j]);
      if (i%sep==1 && j%sep==1 )
        ellipse(i, j, 10, 10);
    }
  }
}

int timer=0;
boolean timer(int t) {
  if (millis()-timer>t) {
    timer=millis();
    return true;
  } else {
    return false;
  }
}
float psnr(float[][][] cm, float[][][] m) {
  int iwidth=m.length;
  int iheight=m[1].length;
  //search biggest pixel
  float biggest=0;
  for (int i=0; i<iwidth-1; i++) {
    for (int j=0; j<iheight-1; j++) {

      if ((m[i][j][0]+m[i][j][1]+m[i][j][2])/3 >biggest)biggest=(m[i][j][0]+m[i][j][1]+m[i][j][2])/3;
    }
  }
  float mse=0;
  for (int i=0; i<iwidth-1; i++) {
    for (int j=0; j<iheight-1; j++) {

      mse=mse+pow((cm[i][j][0]+cm[i][j][1]+cm[i][j][2]-m[i][j][0]-m[i][j][1]-m[i][j][2])/3, 2);
    }
  }
  mse=mse/iwidth*iheight;
  return 10*log(pow(biggest, 2)/mse);
}