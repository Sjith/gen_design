float circleSize;
boolean gettingBigger;

void setup()
{
  gettingBigger = true;
  circleSize = 1.0;

  size(500, 500);
  noStroke();
} 

void draw()   {
  
  fill(0, 10);
  rect(0, 0, 500, 500);
  
  fill(255, 255);
  
  if(circleSize > 400) {
    gettingBigger = false;
  }

  if(circleSize < 1) {
    gettingBigger = true;
  }

  if(gettingBigger) {
    circleSize += (circleSize/30);
  } else {
    circleSize -= (circleSize/30);
  }

  ellipse( width/2, height/2, circleSize, circleSize );

}

void exit()
{
  println(" we're all done ");
  super.exit();
}
