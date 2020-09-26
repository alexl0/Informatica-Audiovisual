PImage imagenPrincipal;
PImage[] imagenes;

File dir;
File[] archivos;
int x = 0;
int y = 0;
int indicePrincipal = 0;
int imagenGrande = 0;

int izquierda = 0;
int automatico = 0;
int preparado = 0;
int derecha = 0;

void setup()
{
  selectFolder("Selecciona una imagen:", "imagenSeleccionada");
  background(color(211,211,211));
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
    // Aquí tendrías que procesar el directorio para hacer con el listado de ficheros
    procesarFicheros(selection.getAbsolutePath());
  }
}

void procesarFicheros(String absolutePath)
{
  dir = new File(dataPath(absolutePath));
  archivos = dir.listFiles();

  int count = 0;
  for (int i = 0; i <= archivos.length - 1; i++)
  {
    String path = archivos[i].getAbsolutePath();
    if (path.toLowerCase().endsWith("jpg"))
      count++;
  }

  imagenes = new PImage[count];

  for (int i = 0; i <= archivos.length - 1; i++)
  {
    String path = archivos[i].getAbsolutePath();
    if (path.toLowerCase().endsWith("jpg"))
    {
      println(path);
      imagenes[i] = loadImage(path);
    }
  }
  preparado = 1;
}

void draw()
{
  imageMode(CORNER);

  if (preparado==1)
  {
    pintar();
    pintarBorde(10);
    showimagenPrincipal();
  }
  if (derecha==1)
  {
    moverDerecha();
    showimagenPrincipal();
    pintarBorde(10);
    derecha = 0;
  }
  if (izquierda==1)
  {
    moverIzquierda();
    showimagenPrincipal();
    pintarBorde(10);
    izquierda = 0;
  }

  if (automatico==1)
  {
    next();
  }
}

void showimagenPrincipal()
{
  if (indicePrincipal == imagenes.length - 1)
    imagenGrande = 0;
  else
    imagenGrande = indicePrincipal + 1;

  imagenPrincipal = imagenes[imagenGrande];
  image(imagenes[imagenGrande], 800 / 5.8, 600 / 2.5, width / 1.5, height / 2);
}

void pintarBorde(int frameSize)
{
  noFill();
  int colorBorde = color(255, 0, 0);

  strokeWeight(frameSize);
  stroke(colorBorde);
  x = 0;
  rect(800 / 3, 0, width / 3, height / 3);
}

void pintar()
{
  int cont = 0;
  for (int i = indicePrincipal; cont < 3; i++)
  {
    image(imagenes[i], x, y, width / 3, height / 3);
    x = x + width / 3;
    cont++;
  }
  preparado = 0;
  x = 0;
}

void moverDerecha()
{
  int cont = 0;
  x = 0;
  for (int i = indicePrincipal; cont < 3; i++)
  {
    if (i > imagenes.length - 1)
    {
      i = 0;
    }
    image(imagenes[i], x, y, width / 3, height / 3);
    x = x + width / 3;
    cont++;
  }
}

void moverIzquierda()
{
  int cont = 0;
  x = 800 - width / 3;
  int aux = -1;

  for (int i = indicePrincipal; cont <= 2; i--)
  {
    if (i < 0)
    {
      i = imagenes.length - 1;
      indicePrincipal = i - 1;
    }
    else if (i == imagenes.length)
    {
      i = 0;
      indicePrincipal = imagenes.length - 1;
    }
    image(imagenes[i], x, y, width / 3, height / 3);
    x = x - width / 3;
    cont++;
    aux = i;
  }
  indicePrincipal = aux;
  preparado = 0;
}

void keyPressed()
{

    switch(keyCode) {
        case RIGHT: 
    indicePrincipal++;
    indicePrincipal = (indicePrincipal > imagenes.length - 1) ? 0 : indicePrincipal;
    derecha = 1;
            break;
        case LEFT: 
    indicePrincipal++;
    //System.out.println("Indice pasará a la izq: " + indicePrincipal);
    indicePrincipal = (indicePrincipal - 1 >= 0) ? indicePrincipal : imagenes.length - 1;
    izquierda = 1;
            break;
        case CONTROL:
            saveFrame("captura.png");
            break;
    }

    switch(key) {
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
  indicePrincipal++;
  indicePrincipal = (indicePrincipal > imagenes.length - 1) ? 0 : indicePrincipal;
  moverDerecha();
  showimagenPrincipal();
  pintarBorde(10);
  derecha = 0;
  delay(3000);
}
