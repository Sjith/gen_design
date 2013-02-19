import ketai.ui.*;
import android.view.MotionEvent;


float outer_radius,inner_radius;

float outer_index;
int inner_index;
Point pP;
int index;
int randomValue;


KetaiGesture gesture;
KetaiVibrate vibrate;

PVector origin;
float rotationAngle;
int squareSize;

float x_offset;
float y_offset ;

void setup() {
  size(displayWidth, displayHeight);
  index=0;
  randomValue=(int)random(-10, 10);
  while (randomValue<1 && randomValue>-1)
  {
    randomValue=(int)random(-10, 10);
  }

  outer_radius = 100;
  inner_radius=50;
  outer_index=10;
  inner_index=10;
  background(255, 255, 255);
  frameRate(240);
  pP=new Point(0, 0);
  orientation(LANDSCAPE);
  gesture = new KetaiGesture(this);
  vibrate = new KetaiVibrate(this);

  x_offset = width / 2;
  y_offset = height / 2;

  //size(displayWidth, displayHeight);
  origin = new PVector(400, 400);
  squareSize = 0;
  rotationAngle = 0;
}

void draw() {

  drawOnce();
}
void drawOnce() {

  smooth();
  stroke(0);


  for (int i=0;i<360;i++)
  {
    float inner_angle=radians(i+random(1,10));
    float outer_angle= radians(outer_index);
    float x = sin(inner_angle) * inner_radius + x_offset +sin(outer_angle)*outer_radius;
    float y = cos(inner_angle) * inner_radius + y_offset +cos(outer_angle)*outer_radius;
   
    point(x, y);
    pP=new Point((int)x, (int)y);
  }
  
  outer_index+=20;

}

void onDoubleTap(float x, float y) {
  println(" double tap at " + x + " " + y);
  background(255);
  
}

void onTap(float x, float y) {
  println(" tap at " + x + " " + y);
  x_offset = x;
  y_offset = y;
}

void onLongPress(float x, float y) {
  println(" long press at " + x + " " + y);
  squareSize = 100;
}

void onFlick( float x, float y, float px, float py, float v) {
  println(" flick started at " + x + " " + y);
  println(" and ended at " + px + " " + py + " with speed "+ v);
  origin.x = x;
  origin.y = y;
}

void onPinch(float x, float y, float d) {
  println(" pinch at " + x + " " + y + " with speed of " + d);
  inner_radius=d*10;
}

void onRotate(float x, float y, float ang) {
  println(" rotate at " + x + " " + y + " to angle " + ang);
  //rotationAngle+=ang;
  outer_radius+=ang;
}

public boolean surfaceTouchEvent(MotionEvent event) {

  //call to keep mouseX, mouseY, etc updated
  super.surfaceTouchEvent(event);

  //forward event to class for processing
  return gesture.surfaceTouchEvent(event);
}

class Point {
  float x;
  float y;

  public Point(float x, float y) {
    this.x=x;
    this.y=y;
  }
  public Point(int x, int y) {
    this.x=x;
    this.y=y;
  }
}

