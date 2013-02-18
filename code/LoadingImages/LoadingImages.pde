PImage image;
int fillAmount;

void setup() {
  size(600, 600);
  image = loadImage("http://ciid.dk/root_ciidwww/wp-content/uploads/2011/12/girls.jpg");
}

void mousePressed()
{
  if( mouseX > 100 && mouseX < 500 ) {
    if(mouseY > 200 && mouseY < 400 ) {
      fillAmount = 255;
    }
  }
}

void draw() {
  background(0);
  if (image != null) { // make sure it's there!
    
    tint(255, fillAmount);  // Display at half opacity
    image(image, 0, 0);
    
    if(fillAmount > 0) {
      fillAmount-=2;
    }
  }
}

