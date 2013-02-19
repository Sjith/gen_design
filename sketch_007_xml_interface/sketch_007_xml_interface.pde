

import ketai.ui.*;
import android.view.MotionEvent;

KetaiGesture gesture;

PVector origin;
float rotationAngle;
int squareSize;

void setup() 
{
  
  orientation(LANDSCAPE);
  gesture = new KetaiGesture(this);
  
    
  //size(displayWidth, displayHeight);
  origin = new PVector(400, 400);
  squareSize = 0;
  rotationAngle = 0;
}

void draw() {
  background(0);
  rotate(rotationAngle);
  rect(0, 0, displayWidth, displayHeight);
  rect( origin.x, origin.y, squareSize, squareSize);  
}

void onDoubleTap(float x, float y) {
  println(" double tap at " + x + " " + y);
  squareSize++;
}

void onTap(float x, float y) {
  println(" tap at " + x + " " + y);
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
  squareSize += d;
}

void onRotate(float x, float y, float ang) {
  println(" rotate at " + x + " " + y + " to angle " + ang);
  rotationAngle+=ang;
}

public boolean surfaceTouchEvent(MotionEvent event) {

  //call to keep mouseX, mouseY, etc updated
  super.surfaceTouchEvent(event);

  //forward event to class for processing
  return gesture.surfaceTouchEvent(event);
}
