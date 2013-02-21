import ketai.camera.*;

import android.os.Environment;
import java.io.File;

KetaiCamera cam;
int strokeMax;
int [][] pH;
char type='l';

void setup() {
 
  orientation(LANDSCAPE);
  cam = new KetaiCamera(this, 160, 120, 1);
  cam.setCameraID(0);
  if(type=='e')
  {
    strokeMax=(int)displayHeight/2/256;
    noFill();
  }
  else if(type=='l')
  {
     strokeMax=(int)displayHeight/4/256;
  }
}

void draw() {
  try {
    background(255);
    image(cam, 0, 0, 160, 120);
    PierImage pI=new PierImage(cam);
    pH=pI.globalHist(pH);
    
    
    for (int k=0;k<4;k++)
    { 
      int cX=0,cY=0;
       if(type=='e')
        {
         cX=displayWidth/2*((int)k%2)+displayWidth/4;
          cY=displayHeight/2*(floor(k/2))+displayHeight/4;
      
        } 
        else if(type=='l')
        {
          cX=displayWidth/2*((int)k%2);
          cY=displayHeight/2*(floor(k/2));
        }
      
      for (int j=0;j<256;j++) {
        
        if(type=='e')
        {
          strokeWeight(map(pH[k][j],0,pH[4][k],0,strokeMax));
          ellipse(cX,cY,j*strokeMax,j*strokeMax);
        } 
        else if(type=='l')
        {
          if(j>0)
          {
            line(cX+j*strokeMax,cY+map(pH[k][j],0,pH[4][k],0,strokeMax),cX+(j-1)*strokeMax,cY+map(pH[k][j-1],0,pH[4][k],0,strokeMax));
          }
          //point(cX+j*strokeMax,cY+map(pH[k][j],0,pH[4][k],0,strokeMax));
        }
      }
    }
  }
  catch(Exception e)
  { 
    println("error:"+e+" ");
  }
}

void onCameraPreviewEvent()
{
  cam.read();
}

void exit() {
  cam.stop();
  super.exit();
}

// start/stop camera preview by tapping the screen
void mousePressed()
{
  if (!cam.isStarted()) {
    cam.start();
    return;
  }
  String SDCARD = Environment.getExternalStorageDirectory().getAbsolutePath();
  cam.addToMediaLibrary("image.jpg"); 
  println("saved");
}

