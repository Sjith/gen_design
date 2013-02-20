import ketai.sensors.*;

KetaiSensor sensor;
PVector rot;
PVector up; 
float gX, gY, gZ;
int index=0;
SPoint pPx;
SPoint pPy;
SPoint pPz;
int value=20;

void setup() {

  sensor = new KetaiSensor(this);
  sensor.start();
  textAlign(CENTER, CENTER);
  textSize(36);
  
  up = new PVector(0, 1, 0);
  strokeWeight(5);
  rot=new PVector(0,0,0);
}

void draw() {
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
  SPoint pCx=new SPoint(index, (int)map(gX, -200, 200, 0, displayHeight/3));
  SPoint pCy=new SPoint(index, (int)map(gY, -200, 200, displayHeight/3, displayHeight/3*2));
  SPoint pCz=new SPoint(index, (int)map(gZ, -200, 200, displayHeight/3*2, displayHeight));
  if (index>1)
  {
    line(pPx.x, pPx.y, pCx.x, pCx.y);
    line(pPy.x, pPy.y, pCy.x, pCy.y);
    line(pPz.x, pPz.y, pCz.x, pCz.y);
    if (abs(gX)>15 || abs(gY)>15 || abs(gY)>15)
    {

      textSize(13);
      fill(0);
      //rect(index-20, value-15, 50, 20);
      rect(20, displayHeight/3-15, 50, 20);
      //rect(index-20, displayHeight/3*2+value-15, 50, 20);
      fill(255);
     //text(nfp(gX, 1, 3), index, value);
      text(nfp(gY, 1, 3), 20, displayHeight/3);
      //text(nfp(gZ, 1, 3), index, displayHeight/3*2+value);
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

void onOrientationEvent(float x, float y, float z) {
  rot.set(x, y, z);
  gX=x;
  gY=y;
  gZ=z;
  println(gY);
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
