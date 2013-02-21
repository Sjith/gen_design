import ketai.camera.*;

KetaiCamera cam;

// image displays on the screen, cam isonly here to give pixels to algorithms
PImage temp;
int numPixels;
int[] previousFrame;

void setup() {
  orientation(LANDSCAPE);
  cam = new KetaiCamera(this, 320, 240, 15);
  cam.setCameraID(1);
  noStroke();
  
  temp = createImage(cam.width, cam.height, RGB);
  numPixels = cam.width * cam.height;
  // for containing pixels from the previous frame
  previousFrame = new int[numPixels];
  
}

void draw() {
 
  image(cam, 0, 0, 0, 0);
  
  temp.loadPixels();
  int movementSum = 0; // Amount of movement in the frame
  for (int i = 0; i < numPixels; i++) { // For each pixel in the video frame...
    color currColor = cam.pixels[i];
    color prevColor = previousFrame[i];
    // Extract the red, green, and blue components from current pixel
    int currR = (currColor >> 16) & 0xFF; // Like red(), but faster
    // Extract red, green, and blue components from previous pixel
    int prevR = (prevColor >> 16) & 0xFF;
    // Compute the difference of the red, green, and blue values
    int diffR = abs(currR - prevR);
    // Add these differences to the running tally
    movementSum += diffR;
    // Render the difference image to the screen
    temp.pixels[i] = color(diffR);
    // The following line is much faster, but more confusing to read
    // Save the current color into the 'previous' buffer
    previousFrame[i] = currColor;
  }
  // To prevent flicker from frames that are all black (no movement),
  // only update the screen if the image has changed.
  if (movementSum > 0) {

    temp.updatePixels();
    image(temp, 0, 0, 640, 480);
    println(movementSum); // Print the total amount of movement to the console
  }
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
