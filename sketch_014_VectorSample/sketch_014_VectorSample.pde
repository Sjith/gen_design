PVector v;

void setup() {
  noLoop();
  v = new PVector(5, 10, 0);
}

void draw() {
  ellipse(v.x, v.y, 12, 12);
  v.mult(0);
  ellipse(v.x, v.y, 24, 24);
}
