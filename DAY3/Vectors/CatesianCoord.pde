
class CartesianCoord {
  
  PVector c_vect = new PVector();
  PVector c_pnt = new PVector();
  PVector l_pnt = new PVector();  
  
  ArrayList<PVector> points = new ArrayList<PVector>(); // in screen coord
  ArrayList<PVector> vectors = new ArrayList<PVector>(); // in cartesian coord
  
  float x0 = displayWidth / 2;
  float y0 = displayHeight / 2;    
  
  CartesianCoord() { }
  
  void draw() {    
    noFill();
    textSize(12);    
    
    pushMatrix();
        
    translate(displayWidth / 2, displayHeight / 2);
    line(-displayWidth / 2, 0, displayWidth / 2, 0);
    line(0, -displayHeight / 2, 0, displayHeight / 2);
    
    if(c_vect != null) {
      draw_vector(c_vect);
    }
    
    for(int i = 0; i < vectors.size(); i++) {
      draw_vector(vectors.get(i));
    }
    
    for(int i = 0; i < points.size() - 1; i++) {
      draw_vector(points.get(i), points.get(i + 1));
    }    
    if(c_pnt != null) {
      draw_vector(l_pnt, c_pnt);
    }
    
    
    popMatrix();
  }
  
  void draw_vector(PVector v) {
    if(v == null) return;
    stroke(127,34,255);
    line(0, 0, v.x, v.y);
    stroke(255,34,127);
    ellipse(v.x, v.y, 9, 9);
    stroke(255,34,255);
    text(Integer.toString((int)v.x), v.x, 0);
    ellipse(c_vect.x, 0, 3, 3);
    text(Integer.toString((int)-v.y), 0, v.y);
    ellipse(0, v.y, 3, 3);    
  }
  
  void draw_vector(PVector v0, PVector v1) {
    stroke(255,34,127);
    line(v0.x, v0.y, v1.x, v1.y);
    stroke(127,34,255);
    ellipse(v1.x, v1.y, 15, 15);
  }
  
  void draw_vector_w(PVector v) {
    stroke(255,255,255);
    line(0, 0, v.x, v.y);
    stroke(255,255,255);
    ellipse(v.x, v.y, 9, 9);
    stroke(255,255,255);
    text(Integer.toString((int)v.x), v.x, 0);
    ellipse(c_vect.x, 0, 3, 3);
    text(Integer.toString((int)-v.y), 0, v.y);
    ellipse(0, v.y, 3, 3);    
  }  
  
  
  void startVector(int x, int y) {
    l_pnt = c_pnt;
    c_pnt = new PVector(x - x0, y - y0);
    PVector.sub(c_pnt, l_pnt, c_vect);
    println(c_vect);
  }

  void updateVector(int x, int y) {
    c_pnt.x = x - x0;
    c_pnt.y = y - y0; 
    PVector.sub(c_pnt, l_pnt, c_vect); 
  }
  
  void endVector(int x, int y) {
    c_pnt.x = x - x0;
    c_pnt.y = y - y0;
    
    // !!! Create the vector
    PVector v = new PVector();
    PVector.sub(c_pnt, l_pnt, v);  
    
    vectors.add(v);
    points.add(c_pnt);
  }
  
  
  PVector addVectors() {
    PVector a = new PVector();
    for(int i = 0; i < vectors.size(); i++) {
      a.add(vectors.get(i));
    }
    return a;
  }
  
    
}
