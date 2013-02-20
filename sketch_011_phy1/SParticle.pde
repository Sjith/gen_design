class SParticle {
  private PVector pos, vel, acc;
  private int size;
  private color c;

  public SParticle(int x, int y)
  {
    pos=new PVector(x, y);
    vel=new PVector(0, 0);
    acc=new PVector(0, 0);
    size=(int)random(10,15);
    c=color(random(128,180),random(200,210),random(20,80));
  }
   public SParticle(PVector pV)
  {
    pos=pV;
    vel=new PVector(0, 0);
    acc=new PVector(0, 0);
    size=(int)random(10,15);
  }
  public SParticle(int x, int y, float bVx, float bVy)
  {
    pos=new PVector(x, y);
    vel=new PVector(bVx, bVy);
    acc=new PVector(0, 0);
    size=(int)random(10,30);
    
  }
  public void updateAcceleration(PVector nAcc)
  {
    acc.add(nAcc);
  }
  public void setAcceleration(PVector nAcc)
  {
    acc=nAcc;
  }
  public void update()
  {
    vel.add(acc);
    pos.add(vel);
  }
  public void paint()
  {
    stroke(c);
    noFill();
    ellipse(pos.x,pos.y,size,size);
  }
}


