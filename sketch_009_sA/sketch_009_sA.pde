import ketai.sensors.*;

KetaiSensor sensor;
float accelerometerX, accelerometerY, accelerometerZ;
int index=0;
SPoint pPx;
SPoint pPy;
SPoint pPz;

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
    background(255);
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
  SPoint pCx=new SPoint(index, map(accelerometerX, -20, 20, 0, displayHeight/3));
  SPoint pCy=new SPoint(index, map(accelerometerY, -20, 20, displayHeight/3, displayHeight/3*2));
  SPoint pCz=new SPoint(index, map(accelerometerZ, -20, 20, displayHeight/3*2, displayHeight));
  if (index>1)
  {
    line(pPx.x,pPx.y,pCx.x,pCx.y);
    line(pPy.x,pPy.y,pCy.x,pCy.y);
    line(pPz.x,pPz.y,pCz.x,pCz.y);
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

class SPoint {
  int x;
  int y;
  public SPoint(int x, int y)
  {
    this.x=x;
    this.y=y;
  }
}

