PShape icono;

void setup() {
  fullScreen();
  icono=loadShape("basura.svg");
}

void draw() {
  background(255);
  
  int x,y,lado;
  x=y=0;
  lado=50;
  
  for (int i=0;i<5;i++) {
    shape(icono,x,y,lado,lado);
    x=y=lado;
    lado=lado*2;
  }
}
