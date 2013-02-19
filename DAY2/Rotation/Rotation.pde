import ketai.sensors.*;

KetaiSensor sensor;
PVector rot;
PVector up; 

void setup() {

  sensor = new KetaiSensor(this);
  sensor.start();
  textAlign(CENTER, CENTER);
  textSize(36);
  
  up = new PVector(0, 1, 0);
  strokeWeight(5);
  rot=new PVector(0,0,0);
}

void draw() {
  background(78, 93, 75);
  PVector result = (rot.sub(up));
  result=result.mult(100);
  line(screenWidth/2, screenHeight/2, result.x, result.y);
}

void onOrientationEvent(float x, float y, float z) {
  rot.set(x, y, z);
}
