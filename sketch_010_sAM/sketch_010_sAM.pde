import ketai.sensors.*;
import ketai.ui.*;
import android.view.MotionEvent;

KetaiSensor sensor;
KetaiVibrate vibrate;
KetaiGesture gesture;

String text;
float tapX,tapY;
float gY;

HashMap morse;
final String[] aa = {
  "a", "b", "c", "d", "e", "f", "g", "h", "i", 
  "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", 
  "v", "w", "x", "y", "z", " "
};
final String[] mm = {
  "._", "_...", "_._.", "_..", ".", ".._.", "__.", "....", "..", 
  ".___", "_._", "._..", "__", "_.", "___", ".__.", "__._", "._.", "...", "_", ".._", 
  "..._", ".__", "_.._", "_.__", "__..", "|"
};

float accelerometerX, accelerometerY, accelerometerZ;
int index=0;
SPoint pPx;
SPoint pPy;
SPoint pPz;
int value=20;
int timeout=150;
int timeGest=0;

String currentSequence;
float valZ;
String macroText;

SButton sbCancel;
SButton sbSpace;
SButton sbReset;


void setup()
{
  size(displayWidth,displayHeight);
  tapX=-1;
  tapY=-1;
  gY=0;
  sensor = new KetaiSensor(this);
  sensor.start();
  vibrate=new KetaiVibrate(this);
  gesture = new KetaiGesture(this);
  orientation(LANDSCAPE);
  macroText="";
  currentSequence="";
  textAlign(CENTER, CENTER);
  textSize(36);
  background(78, 93, 75);
  accelerometerX=0.0;
  accelerometerY=0.0;
  accelerometerZ=0.0;
  sbCancel = new SButton(width-width/4, 0, width/4, height/3, color(#29aecf),"cancel");
  sbSpace  = new SButton(width-width/4, height/3, width/4, height/3, color(#a35b79),"space");
  sbReset = new SButton(width-width/4, height/3*2, width/4, height/3, color(#b29e4b),"reset");
  
  //generate morse
  morse = new HashMap();
  for (int i=0;i<mm.length;i++)
  {
    morse.put(mm[i], aa[i]);
  }
  //end morse
}

void draw()
{
  textAlign(LEFT);
  textSize(20);
  fill(78, 93, 75);
  noStroke();
  rect(width/3, height/4, width/3, height/3);
  rect(0, 0, width/4, height/4);
  fill(0);
  text(macroText, 20, 20);

  textSize(56);
  textAlign(CENTER);
  text(currentSequence, width/2, height/2);
  if (morse.containsKey(currentSequence))
  {
    textSize(76);
    text((String)morse.get(currentSequence), width/2, height/3);
  }
  pushMatrix();
  translate(0, displayHeight/3*2);
  drawAccGraph();
  popMatrix();
  sbCancel.paint();
  sbSpace.paint();
  sbReset.paint();
  if (sbCancel.pressed())
  {
    if (currentSequence.length() > 0 ) {
      currentSequence = currentSequence.substring(0, currentSequence.length()-1);
      vibrate.vibrate(50);
    }
  }
  if (sbSpace.pressed())
  {
    terminateChar();
    macroText+=" ";
  }
  if(sbReset.pressed())
  {
    macroText="";
  }
}
void drawAccValues(int x, int y)
{
  textSize(36);
  fill(0);
  rect(x-60, y-10, 130, 40);
  rect(x-60, y-10+40, 130, 40);
  rect(x-60, y-10+80, 130, 40);
  fill(255);
  text(nfp(accelerometerX, 1, 3), x, y);
  text(nfp(accelerometerY, 1, 3), x, y+40);
  text(nfp(accelerometerZ, 1, 3), x, y+80);
}
void drawAccGraph()
{


  if (index==displayWidth/4*3)
  {
    background(78, 93, 75);
    index=0;
  }
  SPoint pCx=new SPoint(index, (int)map(accelerometerX, -20, 20, 0, displayHeight/3));
  SPoint pCy=new SPoint(index, (int)map(accelerometerY, -20, 20, 0, displayHeight/3));
  SPoint pCz=new SPoint(index, (int)map(accelerometerZ, -20, 20, 0, displayHeight/3));
  if (index>1)
  {
    stroke(255, 0, 0, 85);
    line(pPx.x, pPx.y, pCx.x, pCx.y);
    stroke(0, 255, 0, 85);
    line(pPy.x, pPy.y, pCy.x, pCy.y);
    stroke(0, 0, 255, 85);
    line(pPz.x, pPz.y, pCz.x, pCz.y);
  }
  pPx=pCx;
  pPy=pCy;
  pPz=pCz;
  index++;
}

void onAccelerometerEvent(float x, float y, float z)
{
  try {
    accelerometerX = x;
    accelerometerY = y;
    accelerometerZ = z;
    float elapsed=millis()-timeGest;

    if (valZ>17 && elapsed<timeout)
    {
      if (abs(accelerometerY)<1)
      {
        timeGest=millis();
        //println("char");
        timeout=400;
        terminateChar();
        valZ=0;
        //remove last character

        return ;
      }
    }

    if (elapsed>timeout)
    {

      if (abs(accelerometerY)<1 && abs(gY)<10)
      {
        timeGest=millis();
        //println("char");
        timeout=400;
        terminateChar();
        return ;
      }
      if (accelerometerZ>15)
      {
        println("point");
        vibrate.vibrate(50);
        timeGest=millis();
        timeout=100;
        if (currentSequence.length()==4)
        {
          terminateChar();
        }
        currentSequence+=".";
        return ;
      }

      if (abs(accelerometerX)>10)
      {
        println("line");
        vibrate.vibrate(200);
        timeGest=millis();
        timeout=200;
        if (currentSequence.length()==4)
        {
          terminateChar();
        }
        currentSequence+="_";

        return ;
      }
    }
  }
  catch(Exception e)
  {
    println("error");
  }
}
void terminateChar()
{
  if (currentSequence!="")
  {
    String charTmp=(String)morse.get(currentSequence);
    if (charTmp!=null && charTmp!="")
    {
      macroText+=(charTmp+" ");
    }
    currentSequence="";
  }
}
class SPoint {
  int x;
  int y;
  public SPoint(int x, int y)
  {
    this.x=x;
    this.y=y;
  }
}
class SButton {
  SPoint pos;
  SPoint dim;
  color c;
  boolean prs;
  String name;
  public SButton(int x, int y, int w, int h, color c1, String name)
  {
    this.name=name;
    this.pos=new SPoint(x, y);
    this.dim=new SPoint(w, h);
    this.prs=false;
    this.c=c1;
  }
  public boolean pressed()
  {
    if (mousePressed)
    {

      boolean ret=false;
      
      if ((tapX>this.pos.x && tapX<(this.pos.x+this.dim.x)) && (tapY>this.pos.y && tapY<(this.pos.y+ this.dim.y)) && !this.prs)
      {
        println(name+": tap("+tapX+", " +tapY+")  pos("+pos.x+","+pos.y+") dim("+dim.x+","+dim.y+") sum("+(pos.x+dim.x)+","+(pos.y+dim.y)+")");
        this.c=color(red(this.c)+50, green(this.c)+50, blue(this.c)+50);
        this.prs=true;
        ret=true;
      }
      return ret;
    }
    else
    {
      if (this.prs)
      {
        this.c=color(red(this.c)-50, green(this.c)-50, blue(this.c)-50);
        this.prs=false;
      }
      return false;
    }
  }
  public void paint()
  {
    fill(c);
    noStroke();
    rect(this.pos.x, this.pos.y, this.dim.x, this.dim.y);
    fill(200);
     textAlign(LEFT);
     textSize(30);
    text(name,this.pos.x+40, this.pos.y+80);
  }
}

void onOrientationEvent(float x, float y, float z) {
  gY=y;
}

public boolean surfaceTouchEvent(MotionEvent event) {

  //call to keep mouseX, mouseY, etc updated
  super.surfaceTouchEvent(event);
  tapX=event.getRawX();
  tapY=event.getRawY();
  //forward event to class for processing
  return gesture.surfaceTouchEvent(event);
}


