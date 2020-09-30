import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer player;
color c = color(255, 0, 0);
long cont;
long anchoPantalla = 200;
long altoPantalla = 200;
double xPelota = 70;
double yPelota = 100;
long nuevoAnchoPantalla = 200;
long nuevoAltoPantalla = 200;
double xspeed;
double yspeed;
long contFallos;
int parar = 1;
String text;
int primero = 1;
double xPala = anchoPantalla / 2;
double yPala = altoPantalla - 30;


void setup()
{
  size(400, 400);
  surface.setResizable(true);
  smooth();
  background(169, 169, 169);
  xspeed = random(2, 5);
  yspeed = random(2, 5);
  cont = 0;
  xPelota = random(2, nuevoAnchoPantalla - 1);
  yPelota = random(2, nuevoAltoPantalla / 2);
}

void draw()
{

  if (parar==0)
  {
    noStroke();
    fill(169, 169, 169);
    dibujarPelota();
    dibujarPala();
    dibujarMarcador();

    if (xPelota <= xPala + 50 && yPelota >= yPala && yPelota <= yPala + 10 && xPelota >= xPala)
    {
      cont++;
      xspeed = -xspeed;
      yspeed = -yspeed;
      noStroke();
    }

    if (height + 50 < yPelota)
    {
      contFallos--;
      xPelota = random(1, nuevoAnchoPantalla - 1);
      yPelota = random(1, nuevoAltoPantalla / 2);
      System.out.println("Has perdido");
      if (contFallos == 0)
      {
        finalizarPartida();
        minim.stop();
      }
      clear();
      setup();
    }

    if (cont == 5)
    {
      xspeed += (xspeed * 50) / 100;
      yspeed += (yspeed * 50) / 100;
      cont = 0;
    }
  }
  if (parar==1)
  {
    if (primero==0)
    {
      textSize(25);
      fill(211,211,211);
      text = "Has perdido. Pulsa J para continuar.";
      text(text, altoPantalla / 3, altoPantalla / 3, 200, 80);
    }
    else
    {
      textSize(25);
      fill(0, 0, 255);
      text("PONG", altoPantalla / 2, altoPantalla / 3, 200, 80);
      text("Pulsa 'J' para continuar.", altoPantalla / 2, altoPantalla / 1.5, 200, 80);
    }
  }

  if (width != nuevoAnchoPantalla)
  {
    xspeed = (xspeed * width) / anchoPantalla;
    nuevoAnchoPantalla = width;
    xPala = nuevoAnchoPantalla / 2;
  }
  if (height != nuevoAltoPantalla)
  {
    yspeed = (yspeed * height) / altoPantalla;
    nuevoAltoPantalla = height;
    yPala = nuevoAltoPantalla - 30;
  }
}



void dibujarPelota()
{
  rect(0, 0, (float)width, (float)height);
  // Add the current speed to the location.
  xPelota = xPelota + xspeed;
  yPelota = yPelota + yspeed;
  stroke(0);
  fill(120);
  // Check for bouncing
  if ((xPelota > width) || (xPelota < 0))
  {
    xspeed = xspeed * -1;
    noFill();
  }
  if ((yPelota < 0))
  {
    yspeed = yspeed * -1;
    noFill();
  }
  // Display at x,y location
  ellipse((float)xPelota, (float)yPelota, 16, 16);
}
void comprobarFuera()
{
  if (xPelota > nuevoAnchoPantalla || yPelota < nuevoAltoPantalla)
  {
    xPelota = random(1, nuevoAnchoPantalla - 1);
    yPelota = random(1, nuevoAltoPantalla / 2);
  }
}

void finalizarPartida()
{
  parar = 1;
}

void keyPressed()
{
  if (key == 'j')
  {
    if (parar==1)
    {
      contFallos = 5;
      parar = 0;
      primero = 0;
      clear();
      setup();
      minim = new Minim(this);
      player = minim.loadFile("dmc.mp3");
      player.play();
    }
  }
}
void dibujarPala()
{
  rect((float)xPala, (float)yPala, 50, 10);
}

void dibujarMarcador()
{
  textSize(30);
  fill(0, 102, 153);
  text(contFallos, nuevoAnchoPantalla - 30, 30);
}
void mouseMoved()
{
  if (mouseX > xPala)
    xPala = pmouseX;
  else
    xPala = pmouseX;
}
