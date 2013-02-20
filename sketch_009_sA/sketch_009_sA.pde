import ketai.sensors.*;

KetaiSensor sensor;
float accelerometerX, accelerometerY, accelerometerZ;
int index=0;
SPoint pPx;
SPoint pPy;
SPoint pPz;
int value=20;

void setup()
{
  sensor = new KetaiSensor(this);
  sensor.start();
  orientation(LANDSCAPE);
  textAlign(CENTER, CENTER);
  textSize(36);
  background(78, 93, 75);
}

void draw()
{
  if (index==displayWidth)
  {
    background(78, 93, 75);
    index=0;
  }
  /* text("Accelerometer: \n" + 
   "x: " + nfp(accelerometerX, 1, 3) + "\n" +
   "y: " + nfp(accelerometerY, 1, 3) + "\n" +
   "z: " + nfp(accelerometerZ, 1, 3), 0, 0, width, height);*/

  /*point(index,map(accelerometerX,-20,20,0,displayHeight/3));
   point(index,map(accelerometerY,-20,20,displayHeight/3,displayHeight/3*2));
   point(index,map(accelerometerZ,-20,20,displayHeight/3*2,displayHeight));
   */
  SPoint pCx=new SPoint(index, (int)map(accelerometerX, -20, 20, 0, displayHeight/3));
  SPoint pCy=new SPoint(index, (int)map(accelerometerY, -20, 20, displayHeight/3, displayHeight/3*2));
  SPoint pCz=new SPoint(index, (int)map(accelerometerZ, -20, 20, displayHeight/3*2, displayHeight));
  if (index>1)
  {
    line(pPx.x, pPx.y, pCx.x, pCx.y);
    line(pPy.x, pPy.y, pCy.x, pCy.y);
    line(pPz.x, pPz.y, pCz.x, pCz.y);
    if (abs(accelerometerX)>15 || abs(accelerometerY)>15 || abs(accelerometerZ)>15)
    {

      textSize(13);
      fill(0);
      rect(index-20, value-15, 50, 20);
      rect(index-20, displayHeight/3+value-15, 50, 20);
      rect(index-20, displayHeight/3*2+value-15, 50, 20);
      fill(255);
      text(nfp(accelerometerX, 1, 3), index, value);
      text(nfp(accelerometerY, 1, 3), index, displayHeight/3+value);
      text(nfp(accelerometerZ, 1, 3), index, displayHeight/3*2+value);
      value+=40;
      if(value>displayHeight/3)
      {
        value=40;
      }
    }
  }
  pPx=pCx;
  pPy=pCy;
  pPz=pCz;
  line(0, displayHeight/3, displayWidth, displayHeight/3);
  line(0, displayHeight/3*2, displayWidth, displayHeight/3*2);
  index++;
}

void onAccelerometerEvent(float x, float y, float z)
{
  accelerometerX = x;
  accelerometerY = y;
  accelerometerZ = z;
}
void onOrientationEvent(float x, float y, float z) {
  

  gY=y;
 

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

