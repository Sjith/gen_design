
class SParticlesManager {
  private ArrayList<SParticle> particles;

  public SParticlesManager()
  {
    particles=new ArrayList<SParticle>();
  }

  public void addParticle(PVector ptmp)
  {
    SParticle sp=new SParticle(ptmp);
    particles.add(sp);
  }
  public void update()
  {
    for (int i=0;i<particles.size();i++)
    {
      particles.get(i).update();
      particles.get(i).calculateIfInBounds();
      particles.get(i).paint();
     for(int j=i+1;j<particles.size();j++)
     {
       
       particles.get(i).isCollidingWith(particles.get(j));
     } 
    }
  }
  public void flick()
  {
  }
  
  public void updateAcceleration(PVector pA)
  {
    for (int i=0;i<particles.size();i++)
    {
     particles.get(i).setAcceleration(pA);
    }
   
  }
}

