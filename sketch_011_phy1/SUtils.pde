import android.view.MotionEvent;
import ketai.sensors.*;
import ketai.ui.*;


KetaiGesture gesture;
KetaiSensor sensor;
KetaiVibrate vibrate;

float tapX;
float tapY;


public boolean surfaceTouchEvent(MotionEvent event) {

  //call to keep mouseX, mouseY, etc updated
  super.surfaceTouchEvent(event);
  tapX=event.getRawX();
  tapY=event.getRawY();
  //forward event to class for processing
  return gesture.surfaceTouchEvent(event);
}

public void init()
{
  size(displayWidth,displayHeight);
  orientation(LANDSCAPE);
  sensor = new KetaiSensor(this);
  sensor.start();
  vibrate=new KetaiVibrate(this);
  gesture = new KetaiGesture(this);
}


class SRect{
  int x;
  int y;
  int w;
  int h;
  
  public SRect(int x,int y,int w,int h)
  {
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
  }
}


