import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.os.Bundle;
import android.speech.RecognizerIntent;
import java.util.List;

PFont androidFont;
String [] fontList;
int VOICE_RECOGNITION_REQUEST_CODE = 1234;
 
void setup() {
  orientation(LANDSCAPE);
  fontList = PFont.list();
  androidFont = createFont(fontList[0], 24, true);
  textFont(androidFont);


  PackageManager pm = getPackageManager();
  List<ResolveInfo> activities = pm.queryIntentActivities(
  new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH), 0);
  if (activities.size() != 0) {
    println("we have a recognizer");
  } else {
    println("we DON'T have a recognizer");
  }
}

void draw() {
  
}
 
void mousePressed() {
  Intent intent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
  intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE, "en");
  startActivityForResult(intent, VOICE_RECOGNITION_REQUEST_CODE);
}

void onActivityResult(int requestCode, int resultCode, Intent data) {
  if (requestCode == VOICE_RECOGNITION_REQUEST_CODE && resultCode == RESULT_OK) {
    background(0);
    // Fill the list view with the strings the recognizer thought it could have heard
    ArrayList<String>  matches = data.getStringArrayListExtra(RecognizerIntent.EXTRA_RESULTS);
    String s[] = (String[]) matches.toArray(new String[matches.size()]);
    fill(255);
    for (int i=0; i<s.length; i++) {
      text(s[i], 20, 60 + (i*48));
    }
  }

  super.onActivityResult(requestCode, resultCode, data);
}

