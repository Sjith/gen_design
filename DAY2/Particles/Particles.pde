// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com


import ketai.sensors.*;

PVector  accelerometer;
KetaiSensor sensor;

ParticleSystem ps;

void setup() {
  
  orientation(PORTRAIT);
  size(displayWidth,displayHeight);
  ps = new ParticleSystem(new PVector(width/2,displayHeight/2));
  
  sensor = new KetaiSensor(this);
  sensor.start();
  accelerometer = new PVector();
  accelerometer.set(1, 1, 1);
}

void draw() {
  
  background(255);
  
  // Apply gravity force to all Particles
  PVector gravity = new PVector(0,0.1);
  ps.applyForce(accelerometer);
  
  ps.addParticle();
  ps.run();
}

void onAccelerometerEvent(float x, float y, float z) {
  //println( x + " " + y );
  accelerometer.set(x/10,y/10, 1);
}
