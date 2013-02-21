import ketai.camera.*;

import android.os.Environment;
import java.io.File;

KetaiCamera cam;


void setup() {
  orientation(LANDSCAPE);
  cam = new KetaiCamera(this, 320, 240, 15);
  cam.setCameraID(0);
}

void draw() {
  try{
    image(cam, 0, 0, displayWidth, displayHeight);
  }
  catch(Exception e)
  { println("error");
  }
}

void onCameraPreviewEvent()
{
  cam.read();
}

void exit() {
  cam.stop();
  super.exit();
}

// start/stop camera preview by tapping the screen
void mousePressed()
{
  if(!cam.isStarted()) {
    cam.start();
    return;
  }
  String SDCARD = Environment.getExternalStorageDirectory().getAbsolutePath();
  cam.addToMediaLibrary("image.jpg"); 
  println("saved");
}
