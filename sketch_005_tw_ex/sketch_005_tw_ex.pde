
import java.util.Iterator;
ArrayList tweetList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
HashMap  hm;
Iterator iter;
HashMap morse;
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

void setup()
{
  size(displayWidth, displayHeight);
  background(255);

  hm = new HashMap();  


  String BASE_URL = "https://api.twitter.com/1/statuses/user_timeline/pier_dr.json?callback=?&count=200";
  
  String response = loadStrings( BASE_URL )[0];


  // String [] responseR = loadStrings("data.txt");
  // String response=responseR[0];
  String dUserName="\"created_at\":\"";
  String dProfileImage="\"id_str\":\"";
  String dText="\"text\":";
  String dLimit="\",";


  if ( response != null ) {
    tweetList=new ArrayList();
    String words="";
    int index=0;

    while (response.indexOf (dUserName, index)!=-1)
    {

      try {
        index=response.indexOf(dUserName, index);
        String userName= response.substring(index, response.indexOf(dLimit, index) );
        index=response.indexOf(dProfileImage, index);

        if (index==-1)
        {
          break;
        }
        String profileImage = response.substring(index, response.indexOf(dLimit, index) );
        index=response.indexOf(dText, index);
        String text = response.substring(index, response.indexOf(dLimit, index) );
        tweetList.add(new tweetObj(userName, profileImage, text));
        words+=text;
      }
      catch(Exception e)
      {
      }
    }
    String[] wordsArr=words.split("[, #':\"]");
    for (int i=0;i<wordsArr.length;i++)
    {
      if (hm.containsKey(wordsArr[i]))
      {
        int val=(int)((Integer)(hm.get(wordsArr[i]))).intValue();

        val++;
        hm.put(wordsArr[i], new Integer(val));
      }
      else
      {
        hm.put(wordsArr[i], new Integer(0));
      }
    }



    //empty memory
    wordsArr=null;
    tweetList=null;
    response=null;
    //end empty memory

    //generate morse
    morse = new HashMap();
    for (int i=0;i<mm.length;i++)
    {
      morse.put(aa[i], mm[i]);
    }
    //end morse

    iter = hm.entrySet().iterator();  
    fill(0);
    stroke(0);
  }
}

void draw()
{
  //println("draw");
  int tmpF ;
  if (iter.hasNext ()) {
    Map.Entry me = (Map.Entry)iter.next();
    tmpF = (int) ((Integer)(me.getValue()));
    if (tmpF>0)
    {
      int dimF=(int)(((int)tmpF)*10);
      if (dimF>100)
      {
        dimF=100;
      }
      textSize(dimF);
      if (false)
      {
        
        String sTmp=(String)me.getKey();
        String mrsTmp=str2morse(sTmp);
        text(mrsTmp, random(100, width-100), random(100, height-(mrsTmp.length()*dimF)));
      }
      else
      {
        String sTmp=(String)me.getKey();
        text(sTmp, random(100, width-100), random(100, height-(sTmp.length()*dimF)));
      }
    }
  }

  if (mousePressed)
  {
      saveFrame();
      background(255);
      
     iter = hm.entrySet().iterator();  
      
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
class tweetObj{
  String userName;
  String dProfileImageUrl; 
  String text;
  
  public tweetObj(String userName,String dProfileImageUrl, String text){
    this.userName=userName;
    this.dProfileImageUrl=dProfileImageUrl;
    this.text=text;
  }
  
}
