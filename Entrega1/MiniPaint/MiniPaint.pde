//Alejandro León Pereira UO258774

float anteriorX,anteriorY;

color colores[] = {
      color(255, 255, 255),
      color(0,0,255),
      color(0,255,0),
      color(255,0,0),
      color(255, 255, 0)
};
int inicio,tiempo;
int tam=5;
int actual=0;
PFont arial,times;
void setup() {
  arial=createFont("Arial",25);
  times=createFont("Times New Roman",100);
  size(800,800);
  anteriorX=mouseX;
  anteriorY=mouseY;
  frameRate(60);
  background(color(100, 100, 100));
  textFont(times);
  text("",1000,1000);
  inicio=millis();
}

void draw() {
  fill(92, 92, 92);
  noStroke();
  rect(0,0,900,100);
  fill(colores[actual]);
  ellipse(100,40,tam,tam);
  rect(650,40,30,30);
  stroke(colores[0]);

  if (mouseButton==LEFT && mousePressed  ) {
    stroke(colores[actual]);
    strokeWeight(tam);
    line(anteriorX,anteriorY,mouseX,mouseY);
  }

  anteriorY=mouseY;
  anteriorX=mouseX;

}

void keyPressed () {

    switch(keyCode) {
        case RIGHT: 
            if(actual>=0 && actual<colores.length-1){
                actual+=1;
                stroke(colores[actual]);
            }
            break;
        case LEFT: 
            if(actual>0 && actual<colores.length){
                actual-=1;
                stroke(colores[actual]);
            }
            break;
        case CONTROL:
            saveFrame("captura.png");
    }

    switch(key) {
        case '+': 
            if(tam>=0 && tam<20){
                tam+=5;
                strokeWeight(tam);
            }
            break;
        case '-': 
            if(tam>0 && tam<=20){
                tam-=5;
                strokeWeight(tam);
            }
            break;
    }
    
}