CartesianCoord coord;

void setup() {
  size(displayWidth, displayHeight);
  println(displayHeight + " - " + displayWidth);
  coord = new CartesianCoord();
      
}

void draw() {
  background(0);
  coord.draw();
}

void mouseDragged() {
  coord.updateVector(mouseX, mouseY);
}

void mousePressed() {
  coord.startVector(mouseX, mouseY);
}

void mouseReleased() {
  coord.endVector(mouseX, mouseY);
}

