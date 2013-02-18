AudioGenerator audioGenerator = new AudioGenerator(8000);

private int beat;
private int silence;
private double beatSound;
private double sound;
private final int tick1 = 8000; // samples of tick
private boolean play = true;
private boolean mouseClick;
private int silence;
private ArrayList<SSound> sArr;

void setup()
{
  
  silence=200;
  mouseClick=true;
  audioGenerator.createPlayer();
}
void draw() {

  calcSilence();

  double[] tick =
    audioGenerator.getSineWave(this.tick1, 16000, 330);
  double[] tock =
    audioGenerator.getSineWave(this.tick1, 16000, 440);
  double silence = 0;
  double[] sound = new double[16000];
  int t = 0, s = 0, b = 0;

  for (int i=0;i<sound.length&&play;i++) {
    if (i<4000)
    {
      if (i%2==0)
      {
        sound[i]=tock[i+i];
      }
      else
      {
        sound[i]=tick[i+i];
      }
    } 
    else if (i>8000 && i<10000)
    {
      sound[i]=tock[i-8000];
    }
    else
    {
      sound[i]=silence;
    }
  }

  audioGenerator.writeSound(sound);
  println(sound.length+" " + sound[1]+" "+ tick[1]);
} 


public void listenToInteractions()
{
  if (mousePressed)
  {
    if (mouseClick)
    {
      
      
    }
    else
    {
    }
  }
  else {
    if (!mouseClick)
    {
      //mouseReleased
    }
    else
    {
    }
  }
}
class SSound{
  int freq;
  int silence;
  SPoint pos;
  final static int dimSS=100;
  
  public SSound(int x, int y){
    pos=new SPoint(x,y);
    freq=map(x,0,displayWidth,330,880);
    silence=map(y,0,displayHeight,0,16000);
  
  }
  public void draw()
  {
    ellipse(pos.x,pos.y,dimSS,dimSS);
  }
  public boolean over()
  {
    boolean over=false;
    if(mouseX>pos.x && mouseY<pos.x+dimSS && mouseY>pos.y && mouseY<pos.y+dimSS)
    {
      over=true;  
    }
    return over;
  }
}
class SPoint{
  int x;
  int y;
  public SPoint(int x,int y)
  {
    this.x=x;
    this.y=y;
  }
}

