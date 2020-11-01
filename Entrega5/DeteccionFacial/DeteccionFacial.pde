import java.awt.Rectangle;
import gab.opencv.*;
import processing.video.*;

Rectangle[] faces;
Movie movie;
OpenCV opencv;

void setup()
{
  movie = new Movie(this, "video.mp4");
  size(640, 360);
  opencv = new OpenCV(this, 640, 360);
  movie.play();
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
}

void movieEvent(Movie m)
{
  m.read();
}

void draw()
{
  if (movie.width > 0 || movie.height > 0)
  {
    image(movie, 0, 0, movie.width, movie.height);
    opencv.loadImage(movie);
    faces = opencv.detect();
    strokeWeight(1);
    noFill();
    int i = 0;
    while (i < faces.length)
    {
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
      i++;
    }
  }
}
