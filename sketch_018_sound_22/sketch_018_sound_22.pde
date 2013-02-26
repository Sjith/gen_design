AudioGenerator audioGenerator = new AudioGenerator(48000);

private int beat;
private int silence;
private double beatSound;
private double sound;
private final int tick1 = 48000; // samples of tick
private boolean play = true;
private boolean mouseClick;

private ArrayList<SSound> sArr;

void setup()
{
  
  silence=200;
  mouseClick=true;
  audioGenerator.createPlayer();
}
void draw() {

  //calcSilence();

  double[] tick =
    audioGenerator.getSineWave(this.tick1, 48000, 22000);
  double[] tock =
    audioGenerator.getSineWave(this.tick1, 48000, 440);
  double silence = 0;
  double[] sound = new double[48000];
  int t = 0, s = 0, b = 0;

  for (int i=0;i<sound.length&&play;i++) {
    if (i<22000)
    {
      sound[i]=tick[i];
    } 
    else
    {
      sound[i]=tock[i];
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
    freq=(int)map(x,0,displayWidth,330,880);
    silence=(int)map(y,0,displayHeight,0,16000);
  
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



import android.media.AudioFormat;
import android.media.AudioManager;
import android.media.AudioTrack;

public class AudioGenerator {

    private int sampleRate;
    private AudioTrack audioTrack;

    public AudioGenerator(int sampleRate) {
        this.sampleRate = sampleRate;
    }

    public double[] getSineWave(int samples,int sampleRate,double frequencyOfTone){
        double[] sample = new double[samples];
        for (int i = 0; i < samples; i++) {
            sample[i] = Math.sin(2 * Math.PI * i / (sampleRate/frequencyOfTone));
        }
                return sample;
    }

    public byte[] get16BitPcm(double[] samples) {
        byte[] generatedSound = new byte[2 * samples.length];
        int index = 0;
        for (double sample : samples) {
            // scale to maximum amplitude
            short maxSample = (short) ((sample * Short.MAX_VALUE));
            // in 16 bit wav PCM, first byte is the low order byte
            generatedSound[index++] = (byte) (maxSample & 0x00ff);
            generatedSound[index++] = (byte) ((maxSample & 0xff00) >>> 8);

        }
        return generatedSound;
    }

    public void createPlayer(){
        audioTrack = new AudioTrack(AudioManager.STREAM_MUSIC,
                sampleRate, AudioFormat.CHANNEL_CONFIGURATION_MONO,
                AudioFormat.ENCODING_PCM_16BIT, sampleRate,
                AudioTrack.MODE_STREAM);

        audioTrack.play();
    }

    public void writeSound(double[] samples) {
        byte[] generatedSnd = get16BitPcm(samples);
        audioTrack.write(generatedSnd, 0, generatedSnd.length);
    }

    public void destroyAudioTrack() {
        audioTrack.stop();
        audioTrack.release();
    }

}

