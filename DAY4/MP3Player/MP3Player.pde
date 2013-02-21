import apwidgets.*;

APMediaPlayer player;

boolean audioPaused;

void setup() {

  player = new APMediaPlayer(this); //create new PMediaPlayer
  player.setMediaFile("skeletonKey.mp3"); //set the file (files are in data folder)
  player.start(); //start play back
  player.setLooping(true); //restart playback end reached
  player.setVolume(1.0, 1.0); //Set left and right volumes. Range is from 0.0 to 1.0

  audioPaused = false;

}

void draw() {

  background(0); //set black background
  text(player.getDuration(), 10, 10); //display the duration of the sound
  text(player.getCurrentPosition(), 10, 30); //display how far the sound has played

}

void mousePressed() {  
  if(!audioPaused) {
    audioPaused = true;
    player.pause(); //pause player
  } else {
    audioPaused = false;
    player.start(); //start play back
  }
}

// dont keep playing when you leave the app
public void onPause() {

  if(player!=null) { //must be checked because or else crash when return from landscape mode
    player.pause(); //release the player
  }

  super.onPause(); //call onDestroy on super class
}

//The MediaPlayer must be released when the app closes
public void exit() {

  if(player!=null) { //must be checked because or else crash when return from landscape mode
    player.release(); //release the player

  }
  super.exit(); //call onDestroy on super class
  
}
