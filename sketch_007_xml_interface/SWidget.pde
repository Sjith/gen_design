class SWidget{
  String type;
  SPoint position;
  
}

class SPoint{
  int x;
  int y;
  public SPoint(int x, int y){
    this.x=x;
    this.y=y;
  }
}
class SBound{
  int x,y,w,h;
  public SBound(int x, int y, int w, int h){
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
  }
}
