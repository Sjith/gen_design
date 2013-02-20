int w, h;

PVector start = new PVector();
PVector end = new PVector();

class Line {
  PVector a;
  PVector b;
  PVector s;
  PVector e;
}

ArrayList<Line> lines;
ArrayList<PVector[]> intersections;

boolean drawing = false;

void setup() {
  size(displayWidth, displayHeight);
  w = displayWidth;
  h = displayHeight;
  lines = new ArrayList<Line>();
  intersections = new ArrayList<PVector[]>();
}

void draw() {
  background(0);

  if(drawing) {
    noFill();
    stroke(127, 34, 255);    
    ellipse(start.x, start.y, 6, 6);
    ellipse(end.x, end.y, 6, 6);
    stroke(255, 34, 127);
    line(start.x, start.y, end.x, end.y);
  }  
  
  for(int i = 0; i < lines.size(); i++) {
    Line l = lines.get(i);
    draw_line(l);
  }
  
  stroke(255);
  for(int i = 0; i < intersections.size(); i++) {
    PVector[] intersects = intersections.get(i);
    for(int j = 0; j < intersects.length; j++) {
      PVector in = intersects[j];
      if(in != null)
        ellipse(in.x, in.y, 6, 6);
    }
  }
  
}

void draw_line(Line l) {
  noFill();  
  stroke(255, 34, 127);
  ellipse(l.s.x, l.s.y, 6, 6);
  ellipse(l.e.x, l.e.y, 6, 6); 
  stroke(127, 34, 255);
  line(l.a.x, l.a.y, l.b.x, l.b.y); 
}

Line compute_line(PVector start, PVector end, float xa, float xb) {
  
  float m = (end.y - start.y) / (end.x - start.x);
  
  float ya = start.y + m * (xa - start.x);
  float yb = start.y + m * (xb - start.x);
  
  Line l = new Line();
  l.a = new PVector(xa, ya);
  l.b = new PVector(xb, yb);
  l.s = new PVector(start.x, start.y);
  l.e = new PVector(end.x, end.y);
  
  return l;
  
}

// modified version of: http://processingjs.org/learning/custom/intersect/
PVector intersect(PVector a0, PVector b0, PVector a1, PVector b1) {
  return intersect(a0.x, a0.y, b0.x, b0.y, a1.x, a1.y, b1.x, b1.y);
}

PVector intersect(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4){

  float a1, a2, b1, b2, c1, c2;
  float r1, r2 , r3, r4;
  float denom, offset, num;

  // Compute a1, b1, c1, where line joining points 1 and 2
  // is "a1 x + b1 y + c1 = 0".
  a1 = y2 - y1;
  b1 = x1 - x2;
  c1 = (x2 * y1) - (x1 * y2);

  // Compute r3 and r4.
  r3 = ((a1 * x3) + (b1 * y3) + c1);
  r4 = ((a1 * x4) + (b1 * y4) + c1);

  // Check signs of r3 and r4. If both point 3 and point 4 lie on
  // same side of line 1, the line segments do not intersect.
  if ((r3 != 0) && (r4 != 0) && (r3 * r4 >= 0)){
    return null;
  }

  // Compute a2, b2, c2
  a2 = y4 - y3;
  b2 = x3 - x4;
  c2 = (x4 * y3) - (x3 * y4);

  // Compute r1 and r2
  r1 = (a2 * x1) + (b2 * y1) + c2;
  r2 = (a2 * x2) + (b2 * y2) + c2;

  // Check signs of r1 and r2. If both point 1 and point 2 lie
  // on same side of second line segment, the line segments do
  // not intersect.
  if ((r1 != 0) && (r2 != 0) && (r1 * r2 >= 0)){
    return null;
  }

  //Line segments intersect: compute intersection point.
  denom = (a1 * b2) - (a2 * b1);

  if (denom == 0) {
    return null;
  }

  if (denom < 0){ 
    offset = -denom / 2; 
  } 
  else {
    offset = denom / 2 ;
  }

  // The denom/2 is to get rounding instead of truncating. It
  // is added or subtracted to the numerator, depending upon the
  // sign of the numerator.
  float x = 0, y = 0;
  num = (b1 * c2) - (b2 * c1);
  if (num < 0){
    x = (num - offset) / denom;
  } 
  else {
    x = (num + offset) / denom;
  }

  num = (a2 * c1) - (a1 * c2);
  if (num < 0){
    y = ( num - offset) / denom;
  } 
  else {
    y = (num + offset) / denom;
  }

  // lines_intersect
  return new PVector(x, y);
}

void compute_intersections(int indx) {
  
  Line l = lines.get(indx);
  PVector[] intersects = intersections.get(indx);
  
  for(int i = 0; i < intersects.length; i++) {
    Line ll = lines.get(i);
    intersects[i] = intersect(l.a, l.b, ll.a, ll.b);
  }
  
}

void mouseDragged() {
  end.x = mouseX;
  end.y = mouseY;
}

void mousePressed() {
  drawing = true;
  start.x = mouseX;
  start.y = mouseY;
}

void mouseReleased() {
  end.x = mouseX;
  end.y = mouseY;
  
  Line l = compute_line(start, end, w, 0);
  lines.add(l);
  
  intersections.add(new PVector[lines.size() - 1]);
  compute_intersections(lines.size() - 1);
  
  drawing = false;
}

