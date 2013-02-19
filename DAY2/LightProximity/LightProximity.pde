import ketai.sensors.*;
KetaiSensor sensor;
PVector magneticField, accelerometer;
float light, proximity;

void setup() {
  sensor = new KetaiSensor(this);
  sensor.start();
  sensor.list();
  orientation(LANDSCAPE);
  textAlign(CENTER, CENTER);
  textSize(28);
}

void draw() {
  background(78, 93, 255);
  text(proximity, 20, 20);
  
}

void onLightEvent(float v) {
  light = v;
}

void onProximityEvent(float v) {
  proximity = v;
}
