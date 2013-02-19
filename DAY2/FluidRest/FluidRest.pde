import ketai.sensors.*;

PVector  accelerometer;
KetaiSensor sensor;

// Five moving bodies
Mover[] movers = new Mover[11];

// Liquid
Liquid liquid;

void setup() {
  
  orientation(PORTRAIT);
  size(displayWidth, displayHeight);
  reset();
  // Create liquid object
  liquid = new Liquid(0, displayHeight/2, displayWidth, displayHeight, 0.1);
  
  sensor = new KetaiSensor(this);
  sensor.start();
  accelerometer = new PVector();
}

void draw() {
  background(255);
  
  // Draw water
  liquid.display();

  for (int i = 0; i < movers.length; i++) {
    
    PVector dragForce = liquid.drag(movers[i]);
      // Apply drag force to Mover
    movers[i].applyForce(dragForce);
      
    // Gravity is scaled by mass here!
    PVector gravity = new PVector(accelerometer.x/8, -accelerometer.y/8);
    // Apply gravity
    movers[i].applyForce(gravity);
   
    // Update and display
    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();
  }
  
  fill(0);
  text("click mouse to reset",10,30);
  
}

void mousePressed() {
  reset();
}

// Restart all the Mover objects randomly
void reset() {
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(0.5, 10), 40+i*70, 0);
  }
}

void onAccelerometerEvent(float x, float y, float z) {
  //println( x + " " + y );
  accelerometer.set(x,y,z);
}
