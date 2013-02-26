
import android.content.Context;
import android.speech.tts.TextToSpeech;
import android.speech.tts.TextToSpeech.OnInitListener;
import android.speech.tts.TextToSpeech.Engine;
import android.speech.RecognizerIntent;
import android.content.Intent;
import android.content.pm.ResolveInfo;
import android.os.Bundle;
import java.util.Locale;

// We implement directly the texttospeech listener into the processing PApplet class
public class TTS_Simple extends PApplet implements TextToSpeech.OnInitListener 
{

  // we need this for an obscure reason;
  int VOICE_RECOGNITION_REQUEST_CODE = 1234;
  
  // The text to speech object
  private TextToSpeech mTts;
  int MY_DATA_CHECK_CODE = 0;

  void setup() { 
    initTTS();
  }

  void draw() {
  }

  void mousePressed() {
    String whatToSay = "I am a talking robot. Listen to robotic voice. SNOW"; // language code == "en"
    //String whatToSay = "Soy un ordenador parlante. Escucha mi voz robótica."; // language code == "es"
    //String whatToSay = "Sono un computer parlante. Ascolta le mie voce robotica."; // language code == "it"
    //String whatToSay = "Ich bin ein sprechender Computer. Höre meine Stimme Robotik."; // language code == "de"
    //String whatToSay = "我是一个说话的计算机。听我的声音机器人"; // language code == "zh"
    speak(whatToSay);
  }
  private void initTTS() {
    Intent checkIntent = new Intent();
    checkIntent.setAction(TextToSpeech.Engine.ACTION_CHECK_TTS_DATA);
    startActivityForResult(checkIntent, MY_DATA_CHECK_CODE);
  }

  // make sure we know what to do when
  protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    if (requestCode == MY_DATA_CHECK_CODE) {
      
      if (resultCode == TextToSpeech.Engine.CHECK_VOICE_DATA_PASS) {
        mTts = new TextToSpeech(this, this);
      } 
    }
  }

  void speak(String toSpeak) {
    mTts.speak(toSpeak, TextToSpeech.QUEUE_FLUSH, null);
  }

  public void onInit(int status) {
    if (status == TextToSpeech.SUCCESS) {
      
      /*Locale[] locales = Locale.getAvailableLocales();
      ArrayList<Locale> localeList = new ArrayList<Locale>();
      for (Locale locale : locales) {
          int res = mTts.isLanguageAvailable(locale);
          if (res == TextToSpeech.LANG_AVAILABLE) {
              println(locale.getLanguage());
          }
      }*/
      
      
      int result = mTts.setLanguage(new Locale("it"));
      
      if (result == TextToSpeech.LANG_MISSING_DATA) {
        println(" LANG MISSING "); 
      }  else if (result == TextToSpeech.LANG_NOT_SUPPORTED) {
        println(" LANG NOT SUPPORTED "); 
      } 
    } else {
      // Initialization failed.
      println("Could not initialize TextToSpeech.");
    }
  }
}

