float circleSize;
boolean gettingBigger;

void setup()
{
  gettingBigger = true;
  circleSize = 1.0;
  
  size(500, 500);
  
}

void draw()   {
  
  background(0);
  
  if(circleSize > 400) {
    gettingBigger = false;
  }
  
  if(circleSize < 1) {
    gettingBigger = true;
  }
  
  if(gettingBigger) {
    circleSize += 1.0 + circleSize/20;
  } else {
    circleSize -= 1.0 + circleSize/20;
  }
  
  ellipse( mouseX + circleSize, mouseY + circleSize, circleSize, circleSize );
  ellipse( mouseX - circleSize, mouseY - circleSize, circleSize, circleSize );
  ellipse( mouseX + circleSize, mouseY - circleSize, circleSize, circleSize );
  ellipse( mouseX - circleSize, mouseY + circleSize, circleSize, circleSize );
  
}
