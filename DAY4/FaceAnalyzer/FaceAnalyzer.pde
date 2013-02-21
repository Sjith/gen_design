/*

 For each face detection, the phone vibrate and make a sound.
 This sketch come with a Ketai.jar modified, to use with Samsung Galaxy Spica i5700.
 You need to activate this permissions:
 
 CAMERA
 VIBRATE
 WRITE_EXTERNAL_STORAGE
 
 
 */


// Ketai library import from the code folder
import edu.uic.ketai.*;
import edu.uic.ketai.inputService.KetaiCamera;

// import some Android class from android SDK
import android.app.Notification;
import android.app.NotificationManager;
import android.content.Context;
import android.net.Uri;

/************************************************************************

--------------------------------  DATAS ---------------------------------

*************************************************************************/

// Class to notify the user of events that happen.
//This is how you tell the user that something has happened in the background.
NotificationManager gNotificationManager;
//A class that represents how a persistent notification is to be presented
//to the user using the NotificationManager. 
Notification gNotification, _gNotification;
// Ketai lib instance
Ketai ketai;
//Immutable URI reference
Uri uri;

PFont font;
long dataCount;

PImage buffer;
int sw, sh;
// vibration sequence
long[] gVibrate = {
  0, 250, 50, 125, 50, 62
};
// audio url
String audio = "/sdcard/media/audio/samples/000.wav";

/************************************************************************

--------------------------------  SETUP ---------------------------------

*************************************************************************/

void setup()
{
  //reduce frameRate cause Spica is cheap CPU 800MHz
  frameRate(15);
  //Create Ketai object
  ketai = new Ketai(this);
  // video size
  sw = 240;
  sh = 160;

  ketai.setCameraParameters(sw, sh, 15);
  ketai.enableCamera();
  ketai.enableFaceAnalyzer();
  // buffer to catch cameraframe
  buffer = createImage(sw, sh, RGB);
  //Get the current data count
  dataCount = ketai.getDataCount();
  orientation(LANDSCAPE);
}
/************************************************************************

--------------------------------  RESUME ---------------------------------

*************************************************************************/

void onResume() {  
  super.onResume();
  Uri sound = uri.parse(audio);
  gNotificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
  // Create our Notification that will do the vibration:
  gNotification = new Notification();
  _gNotification = new Notification();
  // Set the vibration:
  gNotification.vibrate = gVibrate;
  _gNotification.sound = sound;
  println(sound);
}

/************************************************************************

--------------------------------  DRAW ---------------------------------

*************************************************************************/

void draw() {
  background(0);
  // Ketai status
  if (ketai.isCollectingData())
    text("Collecting Data...", 20, 20);
  else
    text("Not Collecting Data...", 20, 20);
  text("Current Data count: " + dataCount, 20, 60);

  // display camera preview without flapping, the best solution I have come up with so far :-/
  if (buffer!=null) {
    image(buffer, width/2, height/2);
  }
}

/************************************************************************

--------------------------------  EVENTS ---------------------------------

*************************************************************************/

void mousePressed()
{
  if (ketai.isCollectingData())
  {
    ketai.stopCollectingData();
    dataCount = ketai.getDataCount();
  }
  else
    ketai.startCollectingData();
}

void keyPressed() {

  if (key == CODED) {
    if (keyCode == DPAD) {
      println("Exporting data...");
      //Export all data and delete all data in DB
      ketai.exportData("test");
      //Update data count
      dataCount = ketai.getDataCount();
      background(0);
    }
  }
}

/*
     The KetaiFaceAnalyzer is a wrapper for the android face detector.  
 If a face is detected, we receive a "face" event including a
 PVector, containing PVector.x and PVector.y coordinates of the point between the eyes
 PVector.z variable stores the distance between the eyes.
 */
 
void onKetaiEvent(String _eventName, Object _data)
{
  if (_eventName.equals("face"))
  {
    if (_data == null || !(_data instanceof PVector)) {
      return;
    }
    else {

      println("face !!");
      vibration();
    }
  }
  else if (_eventName.equals("noface"))
  {
    println("no face!");
  }
}
/************************************************************************

--------------------------------  CAMERA ---------------------------------

*************************************************************************/
void onCameraPreviewEvent(KetaiCamera cam)
{
  cam.read();
  buffer = cam;
}  
/************************************************************************

--------------------------------  ACTION ---------------------------------

*************************************************************************/

void vibration() {
  gNotificationManager.notify(1, gNotification);
  gNotificationManager.notify(1, _gNotification);
}



