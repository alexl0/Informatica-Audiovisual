import processing.svg.*;

//Nota media de los alumnos (0-10) (para la felizidad de las caras)
float notaMedia = 5;

void setup()
{
    size(1000, 800, SVG, "exportacion.svg");
    print("Introduzca la nota media de los alumnos [0 - 10]: ");
}

void draw()
{

    background(255);

    fill(255, 0);

    int x, y = 0;
    float ancho, alto = 0;

    //posiciones de las caras
    for (int i = 1; i < 10; i++)
    {
        for (int j = 1; j < 10; j++)
        {
            x = j * 100;
            y = i * 100;
            ancho = random(65, 90);
            alto = random(80, 95);
            //cara
            ellipse(x, y, ancho, alto);
            //boca
            curve(
                x - ancho / 3, y + alto / (notaMedia + 2.5),
                random(x - ancho / 5, x + ancho / 5), random(y + alto / 5, y + alto / 4),
                random(x - ancho / 5, x + ancho / 5), random(y + alto / 5, y + alto / 4),
                x + ancho / 3, y + alto / (notaMedia + 2.5));

            //ojo izquierdo
            //parte ojo
            float tristezaOjo = random(y - alto / 7, y - alto / 9);
            float altoOjo = (notaMedia + 2.5);

            if (tristezaOjo > y - alto / (notaMedia + 2.5))
            {
                //Ojos cerrados
                //izquierdo
                curve(
                    x - ancho / 3, y - alto / altoOjo,
                    random(x - ancho / 3, x - ancho / 4), tristezaOjo,
                    random(x - ancho / 5, x - ancho / 6), tristezaOjo,
                    x + ancho / 3, y - alto / altoOjo);
                //derecho
                curve(
                    x + ancho / 3, y - alto / altoOjo,
                    random(x + ancho / 3, x + ancho / 4), tristezaOjo,
                    random(x + ancho / 5, x + ancho / 6), tristezaOjo,
                    x - ancho / 3, y - alto / altoOjo);
            }
            else
            {
                //Ojos abiertos

                //color
                color col = color(84, 42, 14); //brown
                float r = random(1, 4);
                if (r >= 1 && r < 2)
                    col = color(84, 42, 14); //brown
                if (r >= 2 && r < 3)
                    col = color(82, 140, 158); //blue
                if (r >= 3 && r <= 4)
                    col = color(25, 163, 55); //green

                //izquierdo
                float tamOjoIzq = random(ancho / 5, ancho / 6);
                float xOjoIzq = random(x - ancho / 4, x - ancho / 5);
                float yOjoIzq = random(y - alto / 7, y - alto / 9);
                ellipse(xOjoIzq, yOjoIzq, tamOjoIzq, tamOjoIzq);
                //retina
                pushStyle(); // Start a new style
                strokeWeight(random(1, 1.5));
                stroke(col);
                fill(0);
                float posRetinaX = random(-tamOjoIzq / 8, tamOjoIzq / 8);
                float posRetinaY = random(-tamOjoIzq / 8, tamOjoIzq / 8);
                ellipse(xOjoIzq + posRetinaX, yOjoIzq + posRetinaY, tamOjoIzq / 2, tamOjoIzq / 2);
                popStyle(); // Restore original style

                //derecho
                float tamOjoD = random(ancho / 5, ancho / 6);
                float xOjoD = random(x + ancho / 4, x + ancho / 5);
                float yOjoD = random(y - alto / 7, y - alto / 9);
                ellipse(xOjoD, yOjoD, tamOjoD, tamOjoD);
                //retina
                pushStyle(); // Start a new style
                strokeWeight(random(1, 1.5));
                stroke(col);
                fill(0);
                ellipse(xOjoD + posRetinaX, yOjoD + posRetinaY, tamOjoD / 2, tamOjoD / 2);
                popStyle(); // Restore original style
                //triangle(random(width/2-10,width/2+10),random(-10,+10),random(width-10,width+10),random(height-10,height+10),random(-10,+10),random(height-10,height+10));
            }
        }
    }

    println("Terminado.");
    exit();
}

void keyPressed()
{
    if ((float(key) == (float)float(key)) && float(key) >= 0 && float(key) <= 10)
    { //Si es un digito y es una nota
        notaMedia = float(key);
        print("Dato: " + key);
    }
    else
        print("Dato erróneo");
}
