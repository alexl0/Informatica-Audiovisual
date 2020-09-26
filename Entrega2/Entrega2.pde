PImage imagenPrincipal;
PImage[] imagenes;

File directorio;
File[] archivos;
short x = 0;
short y = 0;
short posicion = 0;
short imagenGrande = 0;

short izquierda = 0;
short automatico = 0;
short preparado = 0;
short derecha = 0;

void setup()
{
  selectFolder("Selecciona una imagen:", "imagenSeleccionada");
  background(color(211, 211, 211));
  size(800, 600);
}

void imagenSeleccionada(File selection)
{

  if (selection == null)
  {
    println("Window was closed or the user hit cancel.");
  }
  else
  {
    println("User selected " + selection.getAbsolutePath());
    procesarFicheros(selection.getAbsolutePath());
  }
}

void procesarFicheros(String absolutePath)
{
  directorio = new File(dataPath(absolutePath));
  archivos = directorio.listFiles();

  short count = 0;
  short in = 0;
  while(in <= archivos.length - 1){
    String path = archivos[in].getAbsolutePath();
    if (path.toLowerCase().endsWith("jpg"))
      count++;
      in++;
  }

  imagenes = new PImage[count];

short i = 0;
while(i <= archivos.length - 1){
    String path = archivos[i].getAbsolutePath();
    if (path.toLowerCase().endsWith("jpg"))
    {
      println(path);
      imagenes[i] = loadImage(path);
    }
    i++;
}

  preparado = 1;
}

void draw()
{
  imageMode(CORNER);

  if (preparado == 1)
  {
    pintar();
    showimagenPrincipal();
  }
  if (derecha == 1)
  {
    moverDerecha();
    showimagenPrincipal();
    derecha = 0;
  }
  if (izquierda == 1)
  {
    moverIzquierda();
    showimagenPrincipal();
    izquierda = 0;
  }

  if (automatico == 1)
  {
    next();
  }
}

void showimagenPrincipal()
{
  if (posicion == imagenes.length - 1)
    imagenGrande = 0;
  else
    imagenGrande = (short)(posicion + 1);

  imagenPrincipal = imagenes[imagenGrande];
  image(imagenes[imagenGrande], 800 / 5.8, 600 / 2.5, width / 1.5, height / 2);
}

void pintar()
{
  short cont = 0;
  for (short i = posicion; cont < 3; i++)
  {
    image(imagenes[i], x, y, width / 3, height / 3);
    x = (short)(x + width / 3);
    cont++;
  }
  preparado = 0;
  x = 0;
}

void moverDerecha()
{
  short cont = 0;
  x = 0;
  short i = posicion;
  while(cont < 3){
    if (i > imagenes.length - 1)
    {
      i = 0;
    }
    image(imagenes[i], x, y, width / 3, height / 3);
    x = (short)(x + width / 3);
    cont++;
    i++;
  }

}

void moverIzquierda()
{
  short cont = 0;
  x = (short)(800 - width / 3);
  short aux = -1;

  for (short i = posicion; cont <= 2; i--)
  {
    if (i < 0)
    {
      i = (short)(imagenes.length - 1);
      posicion = (short)(i - 1);
    }
    else if (i == imagenes.length)
    {
      i = 0;
      posicion = (short)(imagenes.length - 1);
    }
    image(imagenes[i], x, y, width / 3, height / 3);
    x = (short)(x - width / 3);
    cont++;
    aux = i;
  }
  posicion = aux;
  preparado = 0;
}

void keyPressed()
{

  switch (keyCode)
  {
  case RIGHT:
    posicion++;
    posicion = (posicion > imagenes.length - 1) ? 0 : posicion;
    derecha = 1;
    break;
  case LEFT:
    posicion++;
    if (posicion - 1 < 0)
      posicion = (short)(imagenes.length - 1);
    izquierda = 1;
    break;
  case CONTROL:
    saveFrame("captura.png");
    break;
  }

  switch (key)
  {
  case 'b':
    tint(0, 153, 204);
    image(imagenPrincipal, 800 / 5.8, 600 / 2.5, width / 1.5, height / 2);
    break;
  case 'n':
    tint(255, 255, 255);
    image(imagenPrincipal, 800 / 5.8, 600 / 2.5, width / 1.5, height / 2);
    break;
  case 'p':
    tint(247, 191, 190);
    image(imagenPrincipal, 800 / 5.8, 600 / 2.5, width / 1.5, height / 2);
    break;
  case 'c':
    System.out.println("Modo presentacion activado");
    automatico = 1;
    break;
  case 's':
    System.out.println("Modo presentacion desactivado");
    automatico = 0;
    break;
  }
}

void next()
{
  posicion++;
  if (posicion > imagenes.length - 1)
    posicion = 0;
  moverDerecha();
  showimagenPrincipal();
  derecha = 0;
  delay(3000);
}