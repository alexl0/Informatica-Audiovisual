import processing.svg.*;

void setup() {
  size(400, 400, SVG, "exportacion.svg");
}

void draw() {
  background(255);
  
  fill(255,0);
  for (int i=0;i<10;i++) {
    triangle(random(width/2-10,width/2+10),random(-10,+10),random(width-10,width+10),random(height-10,height+10),random(-10,+10),random(height-10,height+10));
  }
  
  println("Terminado.");
  exit();
}
