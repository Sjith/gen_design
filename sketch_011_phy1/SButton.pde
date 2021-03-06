
class SButton {
  SPoint pos;
  SPoint dim;
  color c;
  boolean prs;
  String name;
  public SButton(int x, int y, int w, int h, color c1, String name)
  {
    this.name=name;
    this.pos=new SPoint(x, y);
    this.dim=new SPoint(w, h);
    this.prs=false;
    this.c=c1;
  }
  public boolean pressed()
  {
    if (mousePressed)
    {

      boolean ret=false;
      
      if ((tapX>this.pos.x && tapX<(this.pos.x+this.dim.x)) && (tapY>this.pos.y && tapY<(this.pos.y+ this.dim.y)) && !this.prs)
      {
        println(name+": tap("+tapX+", " +tapY+")  pos("+pos.x+","+pos.y+") dim("+dim.x+","+dim.y+") sum("+(pos.x+dim.x)+","+(pos.y+dim.y)+")");
        this.c=color(red(this.c)+50, green(this.c)+50, blue(this.c)+50);
        this.prs=true;
        ret=true;
      }
      return ret;
    }
    else
    {
      if (this.prs)
      {
        this.c=color(red(this.c)-50, green(this.c)-50, blue(this.c)-50);
        this.prs=false;
      }
      return false;
    }
  }
  public void paint()
  {
    fill(c);
    noStroke();
    rect(this.pos.x, this.pos.y, this.dim.x, this.dim.y);
    fill(200);
    textAlign(LEFT);
    textSize(30);
    text(name,this.pos.x+40, this.pos.y+80);
  }
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
