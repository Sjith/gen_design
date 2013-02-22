class SDeflector{
  //TEMP
  SRect sr;
    public SDeflector(SRect sr)
    {
      this.sr=sr;
    }
    public void paint()
    {
      fill(40);
      rect(sr.x,sr.y,sr.w,sr.h);
    }  

}
