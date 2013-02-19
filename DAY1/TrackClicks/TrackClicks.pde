ClickLocation clickSpots[] = new ClickLocation[10];
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
  
  for( int i = 0; i < 10; i++) {
    if(clickSpots[i] != null) {
      clickSpots[i].rotation += 0.05;
      ellipse( 
        clickSpots[i].location.x + (100 * cos(clickSpots[i].rotation)), 
        clickSpots[i].location.y + (100 * sin(clickSpots[i].rotation)), 
        circleSize, circleSize
        );
    } 
  }
  
}

void mousePressed() {
  if(whichPosition > 9) whichPosition = 0;
  
  if(clickSpots[whichPosition] == null) {
    clickSpots[whichPosition] = new ClickLocation();
  }
  
  clickSpots[whichPosition].location.x = mouseX;
  clickSpots[whichPosition].location.y = mouseY; 
  
  whichPosition++;
}
