class PPoint {
  private int size;
  private int _ws; //working size
  private SPoint pos;
  private SPoint target;
  private int start;
  private float acc;
  private SPoint dir;

  public PPoint(int x, int y, int size, int timing) {
    this.pos=new SPoint(x, y);
    this.size=size;
    this._ws=floor(this.size*this.size);
    this.start=timing;
    this.acc=0;
    this.dir=new SPoint((int)random(-10, 10), (int)random(-10, 10));
  }
  public void draw() {
    ellipse( this.pos.x, this.pos.y, this.size, this.size);
  }

  public void update() {
    if (acc<=1)
    {
      acc+=0.025;
    }
    this.pos.x=(int)(this.acc*this.dir.x);
    this.pos.y=(int)(this.acc*this.dir.y);
    if (this.pos.x<(int)(this.size/2) || this.pos.x>displayWidth-(int)(this.size/2) )
    {
      this.dir.x=-this.dir.x;
      this.acc=this.acc/2;
    }
    if (this.pos.y<(int)(this.size/2) || this.pos.y>displayHeight-(int)(this.size/2) )
    {
      this.dir.y=-this.dir.y;
      this.acc=this.acc/2;
    }
  }
  public void changeSize(int ss) {
    this.size=ss;
  }
  public void setAcc(int a)
  {
    this.acc=a;
  }
  public void setTarget(int x, int y) {
  }
  public void setTarget(String str) {
    if (str=="mouse")
    {
    }
  }
  public String toString()
  {
  }
  public boolean mouseOver()
  {
    boolean ret=false;
    int dX=mouseX-this.pos.x;
    int dY=mouseY-this.pos.y;
    if (abs(pow(dX, 2)+pow(dY, 2))>_ws)
    {
      ret=true;
    }
    return ret;
  }
}

class SPoint {
  public int x, y;
  public SPoint(int x, int y)
  {
    this.x=x;
    this.y=y;
  }
}

