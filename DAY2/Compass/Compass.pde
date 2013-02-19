/*

 This sketch come with a Ketai.jar modified, to use with Samsung Galaxy Spica i5700.
 
 */

import edu.uic.ketai.inputService.*;
import android.content.pm.ActivityInfo;

KetaiSensorManager sensorManager;

String[] fontList;
PFont androidFont;
String direction = "";

boolean firstdraw = true;

float azimuth;
float pitch;
float roll;

int[] smoothedDirection = new int[5];
int lastDirectionUpdated = 0;

void setup()
{
  orientation(PORTRAIT);
  ellipseMode(CENTER);
  sensorManager = new KetaiSensorManager(this);
  sensorManager.start();

  fontList = PFont.list();
  androidFont = createFont(fontList[0], 20, true);
  textFont(androidFont);
  
}

void draw()
{
  background(0);

  // Show compass
  showCompass();
  printDirection();
}


void onOrientationSensorEvent(long time, int accuracy, float x, float y, float z)
{
  
  smoothedDirection[lastDirectionUpdated] = (int) x;
  
  lastDirectionUpdated++;
  if(lastDirectionUpdated > 4) 
    lastDirectionUpdated = 0;
  
  
  azimuth = 0;
  for( int i = 0; i < 5; i++) {
    azimuth += smoothedDirection[i];
  }
  azimuth /= 5;
  
  pitch = y;
  roll = z;
}



void showCompass()
{
  int cx = width/2;
  int cy = height/2;
  float radius = 0.8 * cx;

  stroke(255);
  noFill();
  ellipse(cx, cy, radius*2, radius*2);

  if (!firstdraw)
  {
    pushMatrix();
    translate(cx, cy);
    rotate(radians(azimuth));
    line(0, 0, 0, -radius);
    text(direction, -25, -radius-5);
    ellipse(0, 0, 10, 10);
    popMatrix();

    // Display value (in degrees)
    fill(255);
    text(str(int(azimuth)), cx+7, cy+7);
  }

  firstdraw = false;
}


public void mousePressed() { 
  if (sensorManager.isStarted())
    sensorManager.stop(); 
  else
    sensorManager.start(); 
  println("SensorManager isStarted: " + sensorManager.isStarted());
}

void printDirection() {

  if (azimuth < 22) {
    direction = "N";
    println("N");
  }
  else if (azimuth >= 22 && azimuth < 67) {
    direction = "NE";
    println("NE");
  }
  else if (azimuth >= 67 && azimuth < 112) {
    direction = "E";
    println("E");
  }
  else if (azimuth >= 112 && azimuth < 157) {
    direction = "SE";
    println("SE");
  }
  else if (azimuth >= 157 && azimuth < 202) {
    direction = "S";
    println("S");
  }
  else if (azimuth >= 202 && azimuth < 247) {
    direction = "SW";
    println("SW");
  }
  else if (azimuth >= 247 && azimuth < 292) {
    direction = "W";
    println("W");
  }
  else if (azimuth >= 292 && azimuth < 337) {
    direction = "NW";
    println("NW");
  }
  else if (azimuth >= 337) {
    direction = "N";
    println("N");
  }
  else {
    println("");
  }
}

