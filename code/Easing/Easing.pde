
float x;
float y;
float targetX, targetY;
float easing = 0.05;

void setup() 
{
  size(500, 500); 
  smooth();
  noStroke();  
}

void draw() 
{ 
  background( 51 );
  
  targetX = mouseX;
  float dx = targetX - x;
  if(abs(dx) > 1) {
    x += dx * easing;
  }
  
  targetY = mouseY;
  float dy = targetY - y;
  if(abs(dy) > 1) {
    y += dy * easing;
  }
  
  ellipse(x, y, 33, 33);
}
