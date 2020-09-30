
import ddf.minim.*;

Minim minim;
AudioPlayer player;
color c = color(255, 0, 0);
long contador;
long contador2 = 0;
long ancho = 200;
long alto = 200;
double xPelota = 70;
double yPelota = 100;
long anchonuevo = 200;
long altonuevo = 200;
double velocidadX;
double velocidadY;
long contadorFallos;
int fin = 1;
int empezar = 1;
double xPala = ancho / 2;
double yPala = alto - 30;

void setup()
{
  size(400, 400);
  surface.setResizable(true);
  smooth();
  velocidadX = random(2, 5);
  background(169, 169, 169);
  yPelota = random(2, altonuevo / 2);
  xPelota = random(2, anchonuevo - 1);
  velocidadY = random(2, 5);
  contador = 0;
}

void draw()
{

  if (fin == 0)
  {
    noStroke();
    fill(169, 169, 169);
    dibujarPelota();
    rect((float)xPala, (float)yPala, 50, 10);
    textSize(30);
    fill(0, 102, 153);
    text(contadorFallos, anchonuevo - 30, 30);

    if (xPelota <= xPala + 50 && yPelota >= yPala && yPelota <= yPala + 10 && xPelota >= xPala)
    {
      contador++;
      velocidadX = -velocidadX;
      velocidadY = -velocidadY;
      noStroke();
    }

    if (height + 50 < yPelota)
    {
      contadorFallos--;
      xPelota = random(1, anchonuevo - 1);
      yPelota = random(1, altonuevo / 2);
      if (contadorFallos == 0)
      {
        fin = 1;
        contador2 = 0;
        minim.stop();
      }
      clear();
      setup();
    }

    if (contador == 5)
    {
      contador = 0;
      velocidadY += (velocidadY * 50) / 100;
      velocidadX += (velocidadX * 50) / 100;
    }
  }
  if (fin == 1)
  {
    if (empezar == 0)
    {
      textSize(25);
      fill(0, 0, 255);
      text("Gameover", alto / 3, alto / 3, 400, 80);
      text("J – volver a jugar.", alto / 3, alto / 2, 400, 80);
    }
    else
    {
      textSize(25);
      fill(0, 0, 255);
      text("PONG", alto / 2, alto / 3, 200, 80);
      text("Pulse ‘j” para empezar", alto / 2, alto / 1.5, 200, 80);
    }
  }

  if (width != anchonuevo)
  {
    velocidadX = (velocidadX * width) / ancho;
    anchonuevo = width;
    xPala = anchonuevo / 2;
  }
  if (height != altonuevo)
  {
    velocidadY = (velocidadY * height) / alto;
    altonuevo = height;
    yPala = altonuevo - 30;
  }
}

void dibujarPelota()
{
  rect(0, 0, (float)width, (float)height);
  xPelota = xPelota + velocidadX + contador2;
  yPelota = yPelota + velocidadY + contador2;
  stroke(0);
  fill(120);
  if ((xPelota < 0) || (xPelota > width))
  {
    velocidadX = velocidadX * -1;
    noFill();
  }
  if ((yPelota < 0))
  {
    velocidadY = velocidadY * -1 + contador2;
    noFill();
  }
  ellipse((float)xPelota, (float)yPelota, 16 + contador2, 16 + contador2);
}

void keyPressed()
{
  if (key == 'j')
  {
    if (fin == 1)
    {
      fin = 0;
      contadorFallos = 5;
      empezar = 0;
      clear();
      setup();
      minim = new Minim(this);
      player = minim.loadFile("dmc.mp3");
      player.play();
    }
  }
}

void mouseMoved()
{
  if (mouseX < xPala)
    xPala = pmouseX;
  else
    xPala = pmouseX;
}
