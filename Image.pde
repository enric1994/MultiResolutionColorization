class Image {  //<>//
  float[][][] m;
  float [][] ym;
  int iwidth, iheight;
  List<Seed>seeds=new ArrayList();
  Image(float[][][] _m) {
    m=_m;
    ym=RGBToY(); 
    iwidth=m.length;
    iheight=m[1].length;
  }

  //GENERATE MORE SEEDS

  float[][][] colorize() {
    int iwidth=m.length;
    int  iheight=m[1].length;
    float cm[][][]=new float[iwidth][iheight][3];
    for (int i=0; i<iwidth; i++) {
      for (int j=0; j<iheight; j++) {
        cm[i][j][0]=-1;
      }
    }

    println("Seeting starter seeds");
    for (int i=0; i<seeds.size(); i++) {
      cm[seeds.get(i).x][seeds.get(i).y]=seeds.get(i).rgb;
    }
    println("Starting expansion:");
    float th=thf;
    int regeneratedPixels=0;
    int newPixels=0;
    for (int n=0; n<nrep && regeneratedPixels+seeds.size()<iwidth*iheight && th<600; n++) {
     
      println("Repetition: "+n);
      println("Pixels regenerated:"+regeneratedPixels+"/"+iwidth*iheight);
      newPixels=regeneratedPixels;
      for (int i=0; i<iwidth; i++) {
        for (int j=0; j<iheight; j++) {
          if (cm[i][j][0]!=-1) {

            if (i>0) {
              if (abs(ym[i-1][j] - getY(cm[i][j]))<th && cm[i-1][j][0]==-1) {
                cm[i-1][j]=newColor(cm[i][j], ym[i-1][j]);
                regeneratedPixels++;
              }
            }
            if (j>0) {
              if (abs(ym[i][j-1] - getY(cm[i][j]))<th && cm[i][j-1][0]==-1) {
                cm[i][j-1]=newColor(cm[i][j], ym[i][j-1]);
                regeneratedPixels++;
              }
            }          
            if (i<iwidth-1) {
              if (abs(ym[i+1][j] - getY(cm[i][j]))<th && cm[i+1][j][0]==-1) {
                cm[i+1][j]=newColor(cm[i][j], ym[i+1][j]);
                regeneratedPixels++;
              }
            }          
            if (j<iheight-1) {
              if (abs(ym[i][j+1] - getY(cm[i][j]))<th && cm[i][j+1][0]==-1) {
                cm[i][j+1]=newColor(cm[i][j], ym[i][j+1]);
                regeneratedPixels++;
              }
            }
            //Pixels diagonals

            if (i>0 && j>0) {
              if (abs(ym[i-1][j-1] - getY(cm[i][j]))<th && cm[i-1][j-1][0]==-1) {
                cm[i-1][j-1]=newColor(cm[i][j], ym[i-1][j-1]);
                regeneratedPixels++;
              }
            }
            if (j>0 && i <iwidth -1) {
              if (abs(ym[i+1][j-1] - getY(cm[i][j]))<th && cm[i+1][j-1][0]==-1) {
                cm[i+1][j-1]=newColor(cm[i][j], ym[i+1][j-1]);
                regeneratedPixels++;
              }
            }          
            if (i<iwidth-1 && j<iheight-1) {
              if (abs(ym[i+1][j+1] - getY(cm[i][j]))<th && cm[i+1][j+1][0]==-1) {
                cm[i+1][j+1]=newColor(cm[i][j], ym[i+1][j+1]);
                regeneratedPixels++;
              }
            }          
            if (j<iheight-1 && i>0) {
              if (abs(ym[i-1][j+1] - getY(cm[i][j]))<th && cm[i-1][j+1][0]==-1) {
                cm[i-1][j+1]=newColor(cm[i][j], ym[i-1][j+1]);
                regeneratedPixels++;
              }
            }
          }
        }
      }
      if (regeneratedPixels==newPixels)th+=inc+n*ramp;
      println("Treshold incremented to :"+th);
    }
    println("Pixels regenerated: "+regeneratedPixels);
    println("Seeds used :"+seeds.size());
    return cm;
  }
  void getBestSeeds(float[][][] cm, int n) {
    float highestError=0;
    float [][] err=calcError(cm);
    int hi=-1, hj=-1;
    //drawEllipses2D(err,2,2);
    //drawSeeds(32);
    //showMatrix2D(err,64);
    println("Searching the "+n+" worst pixels");

    for (int e=0; e<n; e++) {
      for (int i=0; i<iwidth; i++) {
        for (int j=0; j<iheight; j++) {
          if (highestError<err[i][j] && abs(hi+hj-i-j)>distanceTh) {
            highestError=err[i][j];
            err[i][j]=0;
            hi=i;
            hj=j;
          }
        }
      }
      highestError=0;
      println("Seed generated in position:["+hi+" - "+hj+"]with R:G:B: "+cm[hi][hj][0]+":"+cm[hi][hj][1]+":"+cm[hi][hj][2]);
      seeds.add(new Seed(m[hi][hj], hi, hj));
    }

    println("Seeds before generation: "+seeds.size());
  }

  //CALC ERROR
  float[][] calcError(float[][][]cm) {
    float[][] err=new float[iwidth][iheight];
    for (int x=0; x<iwidth; x++) {
      for (int y=0; y<iheight; y++) {
        for (int c=0; c<3; c++) {
          err[x][y]+=abs((cm[x][y][c]-m[x][y][c])/6);
        }
      }
    }
    return err;
  }
  void drawSeeds(int s) {
    pushMatrix();
    scale(s);
    popMatrix();
    for (int i=0; i<seeds.size(); i++) {
      fill(seeds.get(i).rgb[0], seeds.get(i).rgb[1], seeds.get(i).rgb[2]);
      ellipse(seeds.get(i).x*s, seeds.get(i).y*s, 20, 20);
    }
  }
  float getY(float[] rgb) {
    return 16+(65.738*rgb[0]+129.057*rgb[1]+25.064*rgb[2])/256;
  }
  float [] newColor(float [] c, float y) {
    float cb=128-0.168736*c[0]-0.331264*c[1]+0.5*c[2];
    float cr=128+0.5*c[0]-0.418688*c[1]-0.081312*c[2];

    float[] newColorRGB=new float[3];
    newColorRGB[0]=y+1.402*(cr-128);
    newColorRGB[1]=y-0.344136*(cb-128)-0.714136*(cr-128);
    newColorRGB[2]=y+1.772*(cb-128);
    return newColorRGB;
  }
  //ITU-R BT.601 (TV)
  //RGB TO YCBCR
  float[][] RGBToY() {
    int iwidth=m.length;
    int iheight=m[1].length;
    float yum[][]=new float[iwidth][iheight];
    //kb and kr for ITU-R BT.601 (TV)
    for (int x=0; x<iwidth; x++) {
      for (int y=0; y<iheight; y++) {
        yum[x][y]=0.299*m[x][y][0]+0.587*m[x][y][1]+0.114*m[x][y][2];
      }
    }
    return yum;
  }

  //DOWNSAMPLE
  float[][][] downSample() {
    int iwidth=m.length;
    int iheight=m[1].length;
    float[][][]dm=new float[iwidth/2][iheight/2][3];
    for (int i=0; i<iwidth-1; i++) {
      for (int j=0; j<iheight-1; j++) {
        for (int c=0; c<3; c++) {
          dm[i/2][j/2][c]=m[i][j][c];
        }
      }
    }

    return dm;
  }
  void display() {
    image(matrixToImage(m), 0, 0);
  }
  Seed transferSeed(int i) {
    return new Seed(seeds.get(i).rgb, seeds.get(i).x*2, seeds.get(i).y*2);
  }
  void cleanSeeds() {
    for (int s=0; s<seeds.size(); s++) {
      seeds.get(s).rgb=m[seeds.get(s).x][seeds.get(s).y];
    }
  }
}