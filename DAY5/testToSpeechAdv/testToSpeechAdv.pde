import android.content.Context;
import android.speech.tts.TextToSpeech;
import android.speech.tts.TextToSpeech.OnInitListener;
import android.speech.tts.TextToSpeech.Engine;
import android.speech.RecognizerIntent;
import android.content.Intent;
import android.content.pm.ResolveInfo;
import android.os.Bundle;

import org.json.*;
import java.util.Locale;
import java.lang.reflect.Field;

// We implement directly the texttospeech listener into the processing PApplet class
public class testToSpeechAdv extends PApplet implements TextToSpeech.OnInitListener 
{

  int VOICE_RECOGNITION_REQUEST_CODE = 1234;
  private TextToSpeech mTts;
  int MY_DATA_CHECK_CODE = 0;
  PFont ourFont;

  void setup() {
    ourFont = createFont("Arial", 60,true);
    textFont(ourFont);
  }

  void draw() {
  }

  public void onCreate(Bundle savedInstance) {
    super.onCreate(savedInstance);
    initTTS();
  }
  
  private void initTTS() {
    Intent checkIntent = new Intent();
    checkIntent.setAction(TextToSpeech.Engine.ACTION_CHECK_TTS_DATA);
    startActivityForResult(checkIntent, MY_DATA_CHECK_CODE);
    
    background(0);
    text( "Ready", 0, 0);
    
  }

  protected void checkFields(Intent data) throws ClassNotFoundException, NoSuchFieldException {
    Class ic = Class.forName("android.content.Intent");
      Field[] f = ic.getDeclaredFields();
      for( int i = 0; i < f.length; i++) {
        println(f[i].getName());
      }
  }

  protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    if (requestCode == MY_DATA_CHECK_CODE) {
      
      if (resultCode == TextToSpeech.Engine.CHECK_VOICE_DATA_PASS) {
        mTts = new TextToSpeech(this, this);
      } 
    }
    if (requestCode == VOICE_RECOGNITION_REQUEST_CODE && resultCode == RESULT_OK) {
        background(0);
        // Fill the list view with the strings the recognizer thought it could have heard
        ArrayList<String>  mats = data.getStringArrayListExtra(RecognizerIntent.EXTRA_RESULTS);
        String toTranslate = mats.toArray(new String[mats.size()])[0];
        
        println(toTranslate);
        
        toTranslate = join(toTranslate.split(" "), "+");
        String req = "https://www.googleapis.com/language/translate/v2?q="+toTranslate+"&target=es&key=AIzaSyDqH0QP5inu8n9TZGhFIxicN2syc0WgmsU";
        
        println(req);
        
        String[] result = loadStrings(req);
        
        println( result );
        
        for( int i = 0; i < result.length; i++) {
          if(result[i].indexOf("translatedText") != -1) {
            String substr = result[i].split(":")[1];
            substr = substr.replace("\"", "");
            substr = substr.replace(",", "");
            println(substr);
            speak(substr);
          }
        }
      } 
  }

  void speak(String toSpeak) {
    background(0);
    text( "Saying:" + toSpeak, 0, 0);
    mTts.speak(toSpeak, TextToSpeech.QUEUE_FLUSH, null);
  }

  void mousePressed() {
    background(0);
    text( "Doing voice!", 0, 0);
    Intent intent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
    intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, RecognizerIntent.LANGUAGE_MODEL_FREE_FORM);
    intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE, "en");
    startActivityForResult(intent, VOICE_RECOGNITION_REQUEST_CODE);
  }

  public void onInit(int status) {
    if (status == TextToSpeech.SUCCESS) {
      int result = mTts.setLanguage(new Locale("it"));
      
      if (result == TextToSpeech.LANG_MISSING_DATA) {
        println(" LANGUAGE MISSING "); 
      } else if (result == TextToSpeech.LANG_NOT_SUPPORTED) {
        println(" LANGUAGE NOT SUPPORTED "); 
      } 
    } else {
      // Initialization failed.
      println("Could not initialize TextToSpeech.");
    }
  }
}

