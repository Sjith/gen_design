import android.os.Environment;
import java.io.File;

void setup()
{
  
  String SDCARD = Environment.getExternalStorageDirectory().getAbsolutePath();  
  File file = new File(SDCARD + File.separator + "saveString.txt"); 
  String[] s = loadStrings(file.getPath());
  
  for(int i = 0; i < s.length; i++) {
    println( s[i]);
  }
}
