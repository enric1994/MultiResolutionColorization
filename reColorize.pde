float[][][] reColorize(Image[] inputImages) {
  println("STARTING ReColorization-----------------------------------------------");
  int iwidth=inputImages[0].m.length;
  int iheight=inputImages[0].m[1].length;
   float[][][] routputImage=new float[iwidth][iheight][3];
  for (int i=1; i<inputImages.length; i++) {
    float[][][] outputImage=inputImages[inputImages.length-i-2].colorize();
    routputImage=outputImage;
    if(outputImage.length==iwidth)break;
    for (int y=0; y<inputImages[inputImages.length-i].iheight; y++) {
      for (int x=0; x<inputImages[inputImages.length-i].iwidth; x++) {
        inputImages[inputImages.length-i-2].seeds.add(new Seed(
          outputImage[x][y], 
          x*2, y*2 ));
      }
    }
  }
  
  return routputImage;
}