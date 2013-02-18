PVector clickSpots[] = new PVector[10];
int whichPosition;
float position;
float circleSize;

void setup()
{
  whichPosition = 0;
  circleSize = 20.0;
  position = 0;
  size(500, 500); 
}

void draw()   {
  
  background(0);
  position += 0.05;
  
  for( int i = 0; i < 10; i++) {
    if(clickSpots[i] != null) {
      ellipse( clickSpots[i].x + (100 * cos(position)), clickSpots[i].y + (100 * sin(position)), circleSize, circleSize );
    } 
  }
  
}

void mousePressed() {
  if(whichPosition > 9) whichPosition = 0;
  
  if(clickSpots[whichPosition] == null) {
    clickSpots[whichPosition] = new PVector();
  }
  
  clickSpots[whichPosition].x = mouseX;
  clickSpots[whichPosition].y = mouseY; 
  
  whichPosition++;
}
