PImage matrixToImage(float m [][][]) {  //<>//
  int iwidth=m.length;
  int iheight=m[1].length;
  PImage newImage=createImage(iwidth, iheight, RGB);
  newImage.loadPixels(); 
  for (int y = 0; y < iheight; y++) {
    for (int x = 0; x < iwidth; x++) {

      int loc = x+y*iwidth;
      float r = m[x][y][0];
      float g = m[x][y][1];
      float b = m[x][y][2];
      pixels[loc] =  color(r, g, b);
    }
  }
  newImage.pixels=pixels;
  updatePixels();
  //background(0);
  return newImage;
}
PImage matrixToImage2D(float m [][]) { 
  pushMatrix();
  int iwidth=m.length;
  int iheight=m[1].length;
  PImage newImage=createImage(iwidth, iheight, RGB);
  newImage.loadPixels(); 
  for (int y = 0; y < iheight; y++) {
    for (int x = 0; x < iwidth; x++) {

      int loc = x+y*iwidth;
      float yum = m[x][y];
      pixels[loc] =  color(yum, yum, yum);
    }
  }
  newImage.pixels=pixels;
  updatePixels();
  background(0, 100, 0);
  popMatrix();
  return newImage;
}

float[][][] imageToMatrix(PImage img) {
  float [][][]imageMatrix=new float[img.width][img.height][3];

  loadPixels();
  img.loadPixels();
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      
      imageMatrix[x][y][0]=red(img.pixels[x+y*img.width]); 
      imageMatrix[x][y][1]=green(img.pixels[x+y*img.width]); 
      imageMatrix[x][y][2]=blue(img.pixels[x+y*img.width]);
    }
  }

  return imageMatrix;
}