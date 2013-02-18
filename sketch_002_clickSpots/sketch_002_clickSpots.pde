final static int POINTS_NUM=4;
PPoint clickSpots[];
int whichPosition;
float position;
float circleSize;
int timing=0;
boolean mouseClick;


void setup()
{
  size(displayWidth, displayHeight);
  clickSpots= new PPoint[POINTS_NUM];
  whichPosition = 0;
  circleSize = 20.0;
  position = 0;
  mouseClick=true;
  println(clickSpots);
}

void draw() {

  background(0);
  position += 0.05;

  for ( int i = 0; i < POINTS_NUM; i++) {
    if (clickSpots[i] != null) {
      clickSpots[i].update();
      clickSpots[i].draw();
    }
  }
  timing++;
  if (mousePressed)
  {
    if (mouseClick)
    {
      for ( int i = 0; i < POINTS_NUM; i++) {
        if (clickSpots[i] != null) {
          println(clickSpots);
        }
      }
      if (whichPosition < POINTS_NUM) {
        clickSpots[whichPosition]=new PPoint(mouseX, mouseY, (int)random(10, 100), timing);
        whichPosition++;
      }
      else
      {
      }
    }
    else
    {
    }
  }
  else {
    if (!mouseClick)
    {
      //mouseReleased
    }
    else
    {
    }
  }
}

