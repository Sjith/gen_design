import java.util.Iterator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import android.os.Environment;
import java.io.File;

final String[] aa = {
  "a", "b", "c", "d", "e", "f", "g", "h", "i", 
  "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", 
  "v", "w", "x", "y", "z", " "
};
final String[] mm = {
  ".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "..", 
  ".---", "-.-", ".-..", "--", "-.", "---", ".--.", "--.-", ".-.", "...", "-", "..-", 
  "...-", ".--", "-..-", "-.--", "--..", "|"
};
class tweetObj {
  String userName;
  String dProfileImageUrl; 
  String text;

  public tweetObj(String userName, String dProfileImageUrl, String text) {
    this.userName=userName;
    this.dProfileImageUrl=dProfileImageUrl;
    this.text=text;
  }
}

String str2morse(String aa)
{
  String morseTmp="";
  for (int i=0;i<aa.length();i++)
  {

    String sTmp=aa.charAt(i)+"";
    String strMM=(String)morse.get(sTmp);
    if (strMM!=null)
    {
      morseTmp+=strMM;
    }
  }
  if (morseTmp==null || morseTmp=="null")
  {
    return "";
  }
  return morseTmp;
}

