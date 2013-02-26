PImage img;

int zoom = 12;

void setup()
{
  size(800, 800);
  String location = "http://maps.googleapis.com/maps/api/staticmap?center=Copenhagen,Denmark&zoom=12&size=600x600&sensor=false";
  img = loadImage(location, "jpg");
}

void draw()
{
  if(img != null) {
    image(img, 0, 0, 800, 800);
  }
}
