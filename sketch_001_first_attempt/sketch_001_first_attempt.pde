DrawSpiro ds;


void setup()
{
  size(800, 600, P3D);
  background(255);
  stroke(1);
  ds=new DrawSpiro(150, 100, 5, 10);

  ds.paint(width/2, height/2, width, height);

 
  
}

void draw()
{
}

import javax.vecmath.Point3d;

class DrawSpiro
{
  private float r;
  private float r1;
  private float outer_index;
  private float inner_index;
  private int[] specials;
  private boolean ev;


  public DrawSpiro() {
    r=100;
    r1=50;
    outer_index=100;
    inner_index=10;
    ev=false;
  }
  public DrawSpiro(float r, float r1, float outer_index, float inner_index) {
    this.r=r;
    this.r1=r1;
    this.outer_index=outer_index;
    this.inner_index=inner_index;
    ev=false;
  }
  public DrawSpiro(float r, float r1, float outer_index, float inner_index, int[]specials) {
    this.r=r;
    this.r1=r1;
    this.outer_index=outer_index;
    this.inner_index=inner_index;
    this.specials=specials;

    ev=true;
  }

  public void paint(int gx, int gy, int w, int h) {
    if (ev)
    {
      drawSpiroImg(gx, gy, w, h);
    }
    else
    {
      float x_offset = gx;
      float y_offset = gy;
      float tmp=0.0;
       beginShape();
      for (int i=0;i<360;i=i)
      {
        float n1=radians(outer_index);
        float n = radians(i);
        float x = sin(n1) * r + x_offset +sin(n)*r1;
        float y = cos(n1) * r + y_offset +cos(n)*r1;
        vertex(x, y, 100);
        outer_index+=inner_index;
        tmp+=0.1;
        i=(int)Math.floor(tmp);
      }
       endShape();
    }
  }

  private void drawSpiroImg(int xT, int yT, int wT, int hT)
  {
    
    outer_index=0;
    inner_index=100;

    int histMax = max(specials);
    for (int hh=0;hh<specials.length;hh++) {
      float x_offset = xT;
      float y_offset = yT;

      for (int i=0;i<360;i++)
      {
        float n1=radians(outer_index);
        float n = radians(i);
        float x = sin(n1) * r + x_offset +sin(n)*r1;
        float y = cos(n1) * r + y_offset +cos(n)*r1;
        point(x, y);
        outer_index+=(1.0/inner_index);
      }  

      if (outer_index>360)
      {
        outer_index=0;
      }


      if (hh>0)
      {
        r+=random(-16, 12);
        //r1=int(map(specials[hh], 0, histMax, -2, 2))+10;
        r1+=(int(map(specials[hh], 0, histMax, -2, 2))+10)/10;

        //  r+=((int)(float(hh_data[hh])/histMax*10)-(int)(float(hh_data[hh-1])/histMax*10))*10;
      }
      inner_index=(int)(float(specials[hh])/histMax*10);

      hh++;
    }
  }
  public void changeParams(float r, float r1, float outer_index, float inner_index) {
    this.r=r;
    this.r1=r1;
    this.outer_index=outer_index;
    this.inner_index=inner_index;
  }
  public void changeInnerRadius(float r) {
    this.r=r;
  }
  public void changeExternalRadius(float r1) {
    this.r1=r1;
  }
  public void changeInnerIndex(float inner_index) {
    this.inner_index=inner_index;
  }
}

