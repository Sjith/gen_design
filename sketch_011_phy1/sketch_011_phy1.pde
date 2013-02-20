
SParticlesManager SPM;


void setup()
{
   init();
  SPM=new SParticlesManager();
 
}

void draw(){
     background(255);
    SPM.update();
}
void onAccelerometerEvent(float x, float y, float z)
{
  //println("acc:"+x+" "+y);
   SPM.updateAcceleration(new PVector(x,y));
}

void onTap(float x, float y) {
  println("tap:"+x+" "+y);

   SPM.addParticle(new PVector(x,y));
}
void onLongPress()
{
  
}
void onFlick( float x, float y, float px, float py, float v) {
  println(" flick started at " + x + " " + y);
  println(" and ended at " + px + " " + py + " with speed "+ v);
  
}
