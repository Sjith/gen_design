GraphsXVF g;

int padding = 20;

void setup() {
  
  size(800, displayHeight);
  int d = displayHeight / 3;
  
  g = new GraphsXVF(padding, 80, d * 3 - d / 2 , d * 2 - d / 2, d * 1 - d / 2, 800 - 2 * padding);
  g.m = 40.0; //mass
  g.d = 10.0; //damper
  g.k = 7.0; //spring
}

void draw() {
  
  background(0);
  g.draw();
  
  g.position(mouseX, mouseY);
  
}

