import android.media.AudioRecord;
import android.media.AudioFormat;
import android.media.MediaRecorder;
 
final int RECORDER_SAMPLERATE = 44100;
final int RECORDER_CHANNELS = AudioFormat.CHANNEL_IN_MONO;
final int RECORDER_AUDIO_ENCODING = AudioFormat.ENCODING_PCM_16BIT;
 
short[] buffer = null;
double[] bufferFFT=null;
AudioRecord audioRecord = null;
int bufferSize;
float volume = 0;
boolean mmbb=true;


FFT fftO=null;
 
void setup() {
  bufferSize = AudioRecord.getMinBufferSize(RECORDER_SAMPLERATE,RECORDER_CHANNELS,RECORDER_AUDIO_ENCODING);
  audioRecord = new AudioRecord(MediaRecorder.AudioSource.MIC, RECORDER_SAMPLERATE, RECORDER_CHANNELS,RECORDER_AUDIO_ENCODING, bufferSize);
  if(audioRecord==null)
  {
    audioRecord.startRecording();
  }
  else
  {
    println("error");
  }
     println(bufferSize);
  fftO=new FFT(bufferSize);
  bufferFFT=new double[bufferSize];
  buffer = new short[bufferSize];
}
 
void draw() {
   background(200);
   int bufferReadResult = audioRecord.read(buffer, 0, bufferSize);
   volume = 0;

   fftO.fft(buffer, bufferFFT);
   for (int i = 0; i < bufferReadResult; i++) 
   {
      //volume = Math.max(Math.abs(buffer[i]), volume);
     line( i, 200 +(short) bufferFFT[i]/100, i + 1, 200 + (short)bufferFFT[i+1]/100 ); 
   }
    bufferFFT=new double[bufferSize];
  buffer = new short[bufferSize];
   //text("" + volume, 100, 100);
  if(mousePressed)
  {
    if(mmbb)
    {
      touchStart();
      mmbb=false;
    }
    
  }
  else
  {
    if(!mmbb)
    {
      mmbb=true;
    }
  }
}

void touchStart()
{
  audioRecord.startRecording();
  println(" asd ");
}

void touchEnd()
{
  
}
void stop() {
  audioRecord.stop();
  audioRecord.release();
}
