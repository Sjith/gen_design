import ketai.camera.*;

KetaiCamera cam;

void setup() {
  orientation(LANDSCAPE);
  cam = new KetaiCamera(this, 320, 240, 15);
  cam.setCameraID(1);
  noStroke();
}

void draw() {
  image(cam, 0, 0, displayWidth, displayHeight);
 
  int brightestX = 0; // X-coordinate of the brightest video pixel
  int brightestY = 0; // Y-coordinate of the brightest video pixel
  float brightestValue = 0; // Brightness of the brightest video pixel

  int index = 0;
  for (int y = 0; y < cam.height; y++) {
    for (int x = 0; x < cam.width; x++) {
      // Get the color stored in the pixel
      int pixelValue = cam.pixels[index];
      // Determine the brightness of the pixel
      float pixelBrightness = brightness(pixelValue);
      // If that value is brighter than any previous, then store the
      // brightness of that pixel, as well as its (x,y) location
      if (pixelBrightness > brightestValue) {
        brightestValue = pixelBrightness;
        brightestY = y;
        brightestX = x;
      }
      index++;
    }
  }
  int x = (int)map(brightestX, 0, cam.width, 0, displayWidth);
  int y = (int)map(brightestY, 0, cam.height, 0, displayHeight);
  fill(255, 204, 0, 128);
  ellipse(x, y, 50, 50);
}

void onCameraPreviewEvent() {
  
  cam.read();
}

// start/stop camera preview by tapping the screen
void mousePressed() {
  
  if (cam.isStarted())
  {
    cam.stop();
  }
  else
    cam.start();
}

void exit() {
  cam.stop();
}
