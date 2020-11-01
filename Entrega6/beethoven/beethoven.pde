int lado=40;
int espacio=lado/8;

int sourceX=2*lado+espacio;
int sourceY=2*lado+espacio;

int fase=1;
int incremento=0;

int ancho,alto;

int fases[][];
int incrementos[][];

boolean todosAuna=false;

void setup() {
  fullScreen();

  ancho=width/(2*lado+2*espacio);
  alto=height/(2*lado+2*espacio);
  
  if (ancho>alto) ancho=alto;
  
  fases=new int[ancho][alto];
  incrementos=new int[ancho][alto];
  
  for (int y=0;y<alto;y++) {
    for (int x=0;x<ancho;x++) {
      fases[x][y]=(int)random(1,6);
      incrementos[x][y]=(int)random(0,lado*2);
    }
  }
}

void draw() {
  background(0);
  int posX,posY;
  
  posX=sourceX;
  posY=sourceY;
  
  if (todosAuna) {
    incremento++;
    if (incremento>=lado*2) {
      incremento=0;
      fase++;
      fase=fase%6;
    }
  }
  
  for (int y=0;y<alto;y++) {
    for (int x=0;x<ancho;x++) {
      if (!todosAuna) {
        fase=fases[x][y];
        incremento=incrementos[x][y];
      }
      
      celda(posX+x*sourceX,posY+y*sourceY,lado,fase,incremento);
      
      if (!todosAuna) {
        incremento++;
        if (incremento>=lado*2) {
          incremento=0;
          fase++;
          fase=fase%6;
        }
        
        fases[x][y]=fase;
        incrementos[x][y]=incremento;
      }
      
    }
  }

  // saveFrame("frames/pequenos-dependientes-####.png");
  //delay(10);
}

void celda(int posX,int posY,int lado,int fase,int incremento) {
  int colorFondo=255-(int)(incremento/(float)(lado*4)*255);
  
  fill(color(colorFondo));

  beginShape();
  
  

  if (fase==1) {
    vertex(posX-lado,posY+lado);
    vertex(posX-lado+incremento,posY-lado);
    vertex(posX+lado,posY-lado);
    vertex(posX+lado,posY+lado);
  } else if (fase==2) {
    vertex(posX-lado,posY+lado);
    vertex(posX-lado,posY+lado-incremento);
    vertex(posX+lado,posY-lado);
    vertex(posX+lado,posY+lado);
  } else if (fase==3) {
    vertex(posX-lado,posY+lado-incremento);
    vertex(posX-lado,posY-lado);
    vertex(posX+lado,posY-lado);
    vertex(posX+lado,posY+lado);
  } else if (fase==4) {
    vertex(posX-lado,posY-lado);
    vertex(posX+lado,posY-lado);
    vertex(posX+lado,posY+lado);
    vertex(posX+lado-incremento,posY+lado);
  } else if (fase==5) {
    vertex(posX-lado,posY-lado);
    vertex(posX+lado,posY-lado+incremento);
    vertex(posX+lado,posY+lado);
    vertex(posX-lado,posY+lado);
  } else {
    vertex(posX-lado,posY-lado);
    vertex(posX-lado+incremento,posY-lado);
    vertex(posX+lado,posY+lado);
    vertex(posX-lado,posY+lado);
  }

  endShape(CLOSE);
}
