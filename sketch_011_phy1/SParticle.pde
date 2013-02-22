class SParticle {
  private PVector pos, vel, acc;
  private int size;
  private color c;

  public SParticle(int x, int y)
  {
    pos=new PVector(x, y);
    vel=new PVector(0, 0);
    acc=new PVector(0, 0);
    size=(int)random(30,100);
    c=color(random(128,180),random(200,210),random(20,80));
  }
   public SParticle(PVector pV)
  {
    pos=pV;
    vel=new PVector(0, 0);
    acc=new PVector(0, 0);
    size=(int)random(30,100);
  }
  public SParticle(int x, int y, float bVx, float bVy)
  {
    pos=new PVector(x, y);
    vel=new PVector(bVx, bVy);
    acc=new PVector(0, 0);
    size=(int)random(30,100);
    
  }
  public boolean isColliding(SRect sr){
      if(pos.x+size>sr.x && pos.x+size<(sr.x+sr.w) && pos.y+size> sr.y && pos.y+size<(sr.y+sr.h))
      {
        return true;
      }
      return false;
  }
  public void updateAcceleration(PVector nAcc)
  {
   
    //nAcc.mult(map(size,0,100,0,1));
    acc.add(nAcc);
  }
  public void setAcceleration(PVector nAcc)
  {
    //nAcc.mult(map(size,0,100,0,1));
    acc=nAcc;
  }
  public void addVelocity(PVector vel1)
  {
    vel.add(vel1);
  }
  public void flipVelocityX()
  {
  
    
    this.vel.x=this.vel.x*-0.5;
  
  }
  public void flipVelocityY()
  {
    
    this.vel.y=this.vel.y*-0.5;
    
  }
  public void update()
  {
    vel.add(acc);
    pos.add(vel);
     
  }
  public void calculateIfInBounds()
  {
    int sH=(int)size/2;
    if(pos.x<10+sH){
      pos.x=10+sH;
      flipVelocityX();
    }
    else if(pos.x>displayWidth-(10+sH))
    {
      pos.x=displayWidth-(10+sH);
      flipVelocityX();
    }
    if(pos.y<10+sH)
    {
      pos.y=10+sH;
      flipVelocityY();
    }else if( pos.y>displayHeight-(10+sH))
    {
      pos.y=displayHeight-(10+sH);
      flipVelocityY();
    }
    
  }
  public void isCollidingWith(SParticle otherParticle)
  {
    if(pow((otherParticle.getPos().x-pos.x),2)+pow((otherParticle.getPos().y-pos.y),2)<pow((otherParticle.getSize()/2+size/2),2))
    {
      /*//vel.mult(0.5);
      PVector pVT=otherParticle.getVel();
      PVector pTmp=vel;
      //pVT.mult(0.5);
      vel=(pVT);
      otherParticle.addVelocity(pTmp);*/
    }
  }
  public int getSize()
  {
    return size;
  }
  public PVector getVel()
  {
    return vel;
  }
  public void paint()
  {
    stroke(c);
    noFill();
    ellipse(pos.x,pos.y,size,size);
  }
  PVector getPos()
  {
    return pos;
  }
}

