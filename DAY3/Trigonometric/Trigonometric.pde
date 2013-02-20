int x0, y0;
int w, h;

int diameter = 200;
int radius = diameter / 2;
float arc_radius = (float) diameter / 3;

float angle = 0.0;
float cos = 0.0;
float sin = 0.0;
float tan = 0.0;

PVector pos = new PVector();
PVector circle_position = new PVector();

GraphsWavvve g;
float freq = 3.0;

boolean tangent = true;
boolean wavvves = true;
boolean auto = false;

void setup() {
  w = 800;
  h = displayHeight;  
  size(800, displayHeight);
  
  x0 = w / 2;
  y0 = h / 2;   
  
  circle_position.x = x0;
  circle_position.y = y0;  
  
  textSize(9);
  
  g = new GraphsWavvve(50, 100, 3 * y0 / 2 , 600);
}

void draw() {
  
  if(auto)
    automaticDragged();
  
  background(0);
  
  pushMatrix();
  
  translate(circle_position.x, circle_position.y);  
  
  stroke(255);
  noFill();
  ellipse(0,0, diameter, diameter);
  
  line(0, 0, pos.x, pos.y);
  ellipse(pos.x, pos.y, 6, 6);
  
  pushMatrix();
  
  // flip the y axis
  scale(1, -1);
  arc(0.0, 0.0, arc_radius, arc_radius, 0, angle);
  
  line(0, 0, cos * radius, 0);
  line(0, 0, 0, sin * radius);
  
  popMatrix();
  
  int a = (int)(angle * 180 / PI);
  text(Integer.toString(a), 5, 0);
  
  int c = (int)(cos * radius);
  text(Float.toString(cos), c, 10);
  
  int s = -(int)(sin * radius);
  text(Float.toString(sin), 5, s);
  
  stroke(125);
  line(c, 0, pos.x, pos.y);
  line(0, s, pos.x, pos.y);
  
  if(tangent) {
    // tangent
    int t = -(int)(tan * radius);
    int r = radius;
    
    if(angle >= PI / 2 && angle <= 3 * PI / 2) {
      t = -t;
      r = -r;
    } 
    
    stroke(255, 0, 0);
    line(r, 0, r, t);
    text(Integer.toString(-t), r, t);
    stroke(125);
    line(pos.x, pos.y, r, t);
  }
    
  popMatrix();
  
  if(wavvves)
    g.draw();
}

void mouseDragged() {
  pos.x = mouseX - x0;
  pos.y = mouseY - y0;
  pos.setMag(radius);
  angle(new PVector(1,0), pos);  
  g.data(sin, cos);
}

void automaticDragged() {
  angle += freq * (1.0 / 30.0) * TWO_PI;
  cos = cos(angle);
  sin = sin(angle);
  tan = tan(angle);  
  pos.x = cos;
  pos.y = -sin;
  pos.setMag(radius);  
  g.data(sin, cos);
}

void angle(PVector a, PVector b) {
  
  // a . b = |a||b|cos(ø)
  
  angle = acos(a.dot(b) / (a.mag() * b.mag()));
  if(b.y > 0)
    angle = TWO_PI - angle;
  cos = cos(angle);
  sin = sin(angle);
  tan = tan(angle);
}


