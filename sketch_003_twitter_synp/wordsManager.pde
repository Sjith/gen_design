final static int WORDS_NUM=15;
class WordsManager {
  Word[] wArr=new Word[WORDS_NUM];


  public WordsManager(String username)
  {
    String response;
    String SDCARD = Environment.getExternalStorageDirectory().getAbsolutePath();
    try {
       
      File file = new File(SDCARD + File.separator + username+".txt"); 
       response = loadStrings( username+".txt")[0];
    }
    catch(Exception e)
    {
      String BASE_URL = "https://api.twitter.com/1/statuses/user_timeline/"+username+".json?callback=?&count=200";
       response = loadStrings( BASE_URL )[0];
      String [] arr=new String[1];
      arr[0]=response;
      saveStrings(SDCARD + File.separator + username+".txt",arr);
    }
    

    String dUserName="\"created_at\":\"";
    String dProfileImage="\"id_str\":\"";
    String dText="\"text\":";
    String dLimit="\",";


    if ( response != null ) {
      ArrayList tweetList=new ArrayList();
     
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

      

      iter = hm.entrySet().iterator();  
      fill(0);
      stroke(0);
    }
    else
    {
      println("WORDS_MANAGER:: error loading the stream");
    }
  }
}








