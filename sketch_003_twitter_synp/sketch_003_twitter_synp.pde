AudioGenerator audioGenerator = new AudioGenerator(8000);

private int beat;
private int silence;
private double beatSound;
private double sound;
private final int tick1 = 8000; // samples of tick
private boolean play = true;

private WordsManager wm ;
private HashMap morse;


void setup()
{
  wm=new WordsManager("pierdr");
  audioGenerator.createPlayer();
  //generate morse
  morse = new HashMap();
  for (int i=0;i<mm.length;i++)
  {
    morse.put(aa[i], mm[i]);
  }
  //end morse
}
void draw() {

  calcSilence();
   double[] tick =
   audioGenerator.getSineWave(this.tick1, 8000, 3000);
   double[] tock =
   audioGenerator.getSineWave(this.tick1, 8000, 1000);
   double silence = 0;
   double[] sound = new double[8000];
   int t = 0, s = 0, b = 0;
   
   for (int i=0;i<sound.length&&play;i++) {
   sound[i]=tick[i];
   }
   
   audioGenerator.writeSound(sound);
   println(sound.length+" " + sound[1]+" "+ tick[1]);
} 
public void calcSilence() {
  silence = 200;
}

