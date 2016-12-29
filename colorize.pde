Image[] getSeeds(PImage im) {
  println("STARTING SEED EXTRACTION-----------------------------------------------");
  Image[] inputImages;
  float[][][] mat=imageToMatrix(im); 
  int downSampleNumber=int(log(im.width)/log(2))-3;
  println("Number of sub-images: "+ downSampleNumber);
  inputImages=new Image[downSampleNumber+1];
  inputImages[0]=new Image(mat);
  int iwidth=inputImages[0].m.length;
  int iheight=inputImages[0].m[1].length;
  println("Size of the original Image: "+iwidth+" : "+iheight);
  for (int i=1; i<downSampleNumber+1; i++) {
    inputImages[i]=new Image(inputImages[i-1].downSample());
    println("Size of the "+i+"-Image: "+inputImages[i].iwidth+" : "+inputImages[i].iheight);
  }
  for (int y=1; y<inputImages[inputImages.length-1].iheight; y++) {
    for (int x=1; x<inputImages[inputImages.length-1].iwidth; x++) {
      inputImages[inputImages.length-2].seeds.add(new Seed(
        inputImages[inputImages.length-1].m[x][y], 
        x*2, y*2 ));
    }
  }
  //grow seeds and transmit to the next photo
  for (int i=1; i<inputImages.length; i++) {
    inputImages[inputImages.length-i-1].getBestSeeds(inputImages[inputImages.length-i-1].colorize(),seedsPerImage);
    //inputImages[inputImages.length-i-1].cleanSeeds();
    if(inputImages[inputImages.length-i-1].iwidth==inputImages[0].iwidth)break;
    for (int s=0; s<inputImages[inputImages.length -i-1].seeds.size(); s++) {
      inputImages[inputImages.length-i-2].seeds.add(inputImages[inputImages.length-i-1].transferSeed(s));
      inputImages[inputImages.length-i-2].cleanSeeds();

    }
  }
  return inputImages;
}