import android.os.Environment;
import java.io.File;

ArrayList<String> dataStore;

void setup()
{
  dataStore = new ArrayList<String>();
}

void mousePressed()
{
  float elapsed = float(millis()) / 1000.0;
  String dataPoint = "time : " + elapsed + " x: " + mouseX + " y: " + mouseY;
  dataStore.add(dataPoint);
}

void draw()
{
 
}
void onPause()
{
  super.onPause();
}
void exit()
{
  String[] s = new String[dataStore.size()];
  int i = 0;
  while ( i < dataStore.size() ) {
    s[i] = dataStore.get(i);
    i++;
  }
  
  String SDCARD = Environment.getExternalStorageDirectory().getAbsolutePath();
  println( SDCARD );
  saveStrings(SDCARD + File.separator + "saveString.txt", s);
  
  super.exit();
}
