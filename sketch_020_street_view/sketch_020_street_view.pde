

//import com.google.api.translate.Language;
//import com.google.api.translate.Translate;


import edu.uic.ketai.inputService.*;
import android.content.pm.ActivityInfo;

PImage imgs[]=new PImage[12];

float azimuth;
float pitch;
float roll;

int[] smoothedDirection = new int[5];
int lastDirectionUpdated = 0;

KetaiSensorManager sensorManager;

void setup() 
{
  orientation(PORTRAIT);
  size(800, 600);
  sensorManager = new KetaiSensorManager(this);

  String apikey = "AIzaSyDqH0QP5inu8n9TZGhFIxicN2syc0WgmsU";
  for (int i=0;i<12;i++) {
    try {

      imgs[i] = requestImage( "http://maps.googleapis.com/maps/api/streetview?size=800x600&location=55.682366,12.593576&heading="+i*30+"&fov=30&pitch=-10&sensor=false&key="+apikey);
    }
    catch(Exception e)
    {
      println(e);
    }
  }
  sensorManager.start();
}

void draw() {
  if (imgs != null)
  {
    try{
      image(imgs[floor(azimuth/30)], 0, 0);
    }
    catch(Exception e)
    {
      println("DRAW:"+e);
    }
  }
}

void onOrientationSensorEvent(long time, int accuracy, float x, float y, float z)
{

  smoothedDirection[lastDirectionUpdated] = (int) x;

  lastDirectionUpdated++;
  if (lastDirectionUpdated > 4) 
    lastDirectionUpdated = 0;


  azimuth = 0;
  for ( int i = 0; i < 5; i++) {
    azimuth += smoothedDirection[i];
  }
  azimuth /= 5;

  pitch = y;
  roll = z;
}

