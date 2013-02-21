
import ketai.camera.*;

KetaiCamera cam;

void setup() {
  orientation(LANDSCAPE);
  cam = new KetaiCamera(this, 240, 160, 10);
}

void draw() {
  try {
    image(cam, 0, 0, displayWidth, displayHeight);
  }
  catch(Exception e)
  {
    println("error");
  }
}

void onCameraPreviewEvent()
{
  cam.read();
}

void exit() {
  cam.stop();
}

// start/stop camera preview by tapping the screen
void mousePressed()
{
  if (cam.isStarted())
  {
    cam.stop();
  }
  else
    cam.start();
}

