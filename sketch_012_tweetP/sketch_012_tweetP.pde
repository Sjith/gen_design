
//physics
import processing.opengl.*;

import mathematik.Vector3f;

import teilchen.Particle;
import teilchen.BasicParticle;

import teilchen.Particle;
import teilchen.Physics;
import teilchen.constraint.Box;
import teilchen.force.Gravity;
import teilchen.force.Spring;
import teilchen.force.ViscousDrag;
import teilchen.util.CollisionManager;


//data

import java.util.Iterator;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;


//data var
ArrayList tweetList;
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

//physics var


static final float PARTICLE_SIZE = 12;

CollisionManager mCollision;

Physics mPhysics;

void setup() {
  size(800, 600, OPENGL);
  smooth();
  frameRate(30);
  noFill();
  ellipseMode(CENTER);

  mCollision = new CollisionManager();
  mCollision.distancemode(CollisionManager.DISTANCE_MODE_FIXED);
  mCollision.minimumDistance(50);

  mPhysics = new Physics();
  mPhysics.add(new ViscousDrag(0.85f));
  mPhysics.add(new Gravity(0, 0, 0));

  Box myBox = new Box();
  myBox.min().set(50, 50, 0);
  myBox.max().set(width - 50, height - 50, 0);
  myBox.coefficientofrestitution(0.7f);
  myBox.reflect(true);
  mPhysics.add(myBox);

  /* create a first particle 
   final Particle myParticle = mPhysics.makeParticle(new Vector3f(mouseX, mouseY, 0), 10);
   mCollision.collision().add(myParticle);
   */
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

void draw() {


  background(255);
  /* collision handler */
  final float mDeltaTime = 1.0 / frameRate;
  mCollision.createCollisionResolvers();
  mCollision.loop(mDeltaTime);
  mPhysics.step(mDeltaTime);

  /* draw */

  drawThings();

  mCollision.removeCollisionResolver();
  //DATA
  int tmpF ;
  if (iter.hasNext ()) {
    Map.Entry me = (Map.Entry)iter.next();
    tmpF = (int) ((Integer)(me.getValue()));
    if (tmpF>1)
    {
      int dimF=(int)(((int)tmpF)*10);
      if (dimF>100)
      {
        dimF=100;
      }
      textSize(dimF);
      String sTmp="";
      if (false)
      {

        sTmp=(String)me.getKey();
        String mrsTmp=str2morse(sTmp);
        text(mrsTmp, random(100, width-100), random(100, height-(mrsTmp.length()*dimF)));
      }
      else
      {
        sTmp=(String)me.getKey();
        //  text(sTmp, random(100, width-100), random(100, height-(sTmp.length()*dimF)));
      }

      TwParticle myParticle =new TwParticle(new Vector3f(mouseX, mouseY, 0), 10, dimF, sTmp);
      mPhysics.add(myParticle);
      mCollision.collision().add(myParticle);
    }
  }

  if (keyPressed)
  {
    if (key=='s')
    {
  
      exit();
    }
  }
}

void drawThings() {
  /* collision springs */
  noFill();
  stroke(255, 0, 127, 64);
  for (int i = 0; i < mCollision.collision().forces().size(); ++i) {
    if (mCollision.collision().forces().get(i) instanceof Spring) {
      Spring mySpring = (Spring)mCollision.collision_forces().get(i);
      line(mySpring.a().position().x, mySpring.a().position().y, mySpring.a().position().z, 
      mySpring.b().position().x, mySpring.b().position().y, mySpring.b().position().z);
    }
  }

  /* particles */
  fill(0);
  stroke(0);
  
  for (int i = 0; i < mPhysics.particles().size(); ++i) {
    TwParticle myParticle =(TwParticle) mPhysics.particles().get(i);

    pushMatrix();
    translate(myParticle.position().x, myParticle.position().y, myParticle.position().z);
    textSize(myParticle.wP/2);
    text(myParticle.txt, 0, 0);

    //ellipse(0, 0, 10, 10);
    popMatrix();
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

class TwParticle extends BasicParticle {
  public int wP;
  public String txt;
  public String mrs;

  public TwParticle(Vector3f v3f, int pos, int wP, String txt)
  {

    super();
    this.wP=wP;
    this.txt=txt;
    this.mrs=str2morse(txt);
    this.setPositionRef(v3f);
    this.old_position().set(this.position());
  }
}

