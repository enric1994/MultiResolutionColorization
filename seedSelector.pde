void seedSelector(PImage im) {

  background(255);
  image(im, 0, 0);

  if (mouseX<im.width && mouseY<im.height) {
    fill(0);
    text(mouseX+"-"+mouseY, mouseX, mouseY);
    color c=get(mouseX, mouseY);
    fill(c);
    rect(0, 500, 3000, 50);
    fill(0);
    text(red(c)+"-"+green(c)+"-"+blue(c), 10, 450);
  }
}
Seed seedPicker(PImage im) {
  float[] cf=new float[3];
  color cc=get(mouseX, mouseY);
  cf[0]=red(cc);
  cf[1]=green(cc);
  cf[2]=blue(cc);
println("Seed added in :"+mouseX+" - "+ mouseY+" with color: "+ cf[0]+" : "+cf[1]+" : "+cf[2]);
  return new Seed(cf, mouseX, mouseY);
}