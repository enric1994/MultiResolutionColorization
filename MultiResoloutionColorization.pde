final float thf=0.1;
final float nrep=20000;
final float ramp=0.001;
final float inc=0.5;
final int seedsPerImage=50;
final int distanceTh=0;
import java.util.List;
float[][][] tmp;
boolean go;
List<Seed>seeds=new ArrayList();
PImage myImage;
String state;
int p;
void setup() {
  background(255);
  state="select seeds";
  surface.setResizable(true);
  myImage=loadImage("lena512.jpg");
  size(512, 512);  
  Image[] outputImages=getSeeds(myImage);
  background(255);
  float[][][] recolorizedImage=reColorize(outputImages);
  image(matrixToImage(recolorizedImage), 0, 0);
  save("finalLena.png");
}