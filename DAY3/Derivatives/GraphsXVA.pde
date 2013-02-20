class GraphsXVA {
  
  int nbr_pts;
  int graphs_width;
  float steps;
  int indx = 0;
  
  float[] accel;
  float[] vel;
  int[] pos;
  
  PVector c_pos;
  PVector c_vel;
  PVector c_accel;
  
  PVector p = new PVector();
  PVector px = new PVector();
  PVector lx = new PVector();
  
  
  GraphsXVA(int pad, int nbr_points, int pos_y, int vel_y, int accel_y, int w) {
    
    nbr_pts = nbr_points;
    graphs_width = w;
    steps = (float) graphs_width / nbr_pts;
    
    c_pos = new PVector(pad, pos_y);
    c_vel = new PVector(pad, vel_y);
    c_accel = new PVector(pad, accel_y);
    
    accel = new float[nbr_pts];
    vel = new float[nbr_pts];
    pos = new int[nbr_pts];
    
  }
  
  void draw() {
    // draw slider!
    draw_slider("Position");
    // draw velocity
    draw_graph("Velocity", c_vel, vel, 35);
    // draw acceleration
    draw_graph("Acceleration", c_accel, accel, 35);    
  }
  
  void draw_graph(String name, PVector pos, float[] values, int axis_y) {
    
    
    pushMatrix();
    
    // position
    translate(pos.x, pos.y);
    noFill();
    stroke(255, 255, 255);
    line(0, 0, graphs_width, 0);
    line(0, -axis_y, 0, axis_y);
    line(graphs_width, -axis_y, graphs_width, axis_y);
    text(name, 5, -axis_y);
    
    // values
    float x = 0;
    for(int i = 0; i < values.length; i++) {
      
      stroke(127, 34, 255);
      line(x, 0, x, values[i]);

      stroke(255, 34, 127);
      if(i == indx)
        stroke(255);
      ellipse(x, values[i], 6, 6);

      x += steps;  
    }
    
    popMatrix();
    
  }
  
  void draw_slider(String name) {
        
    pushMatrix();
    
    // position
    translate(c_pos.x, c_pos.y);
    noFill();
    stroke(255, 255, 255);
    line(0, 0, graphs_width, 0);
    line(0, -10, 0, 10);
    line(graphs_width, -10, graphs_width, 10);
    text(name, 5, -10);
    
    // cursor
    ellipse(px.x, 0, 6, 6);
    stroke(127, 34, 255);
    ellipse(p.x, p.y, 6, 6);
    stroke(255, 34, 127);
    line(px.x, 0, p.x, p.y);
    
    popMatrix();
    
  }
  
  void position(int x, int y) {    
    
    // make sure we are in the         
    if(x > c_pos.x && x < c_pos.x + graphs_width) {
                  
      //--------------------------------------------------
      // !!!!!!!!!compute velocity and acceleration!!!!!!!
      
      // position (bring gloabl position into local coord system) 
      p.x = x - c_pos.x; p.y = y - c_pos.y;
      
      // eliminate jitter from touch 
      if(abs(p.x - lx.x) < 5) return;
      
      // difference of time
      float dt = (millis() - lx.y) / 1000.0f;    
      
      // velocity (dx / dt)
      float dx = p.x - lx.x;      
      float v = dx / dt;      
      
      // acceleration (dv / dt)
      float dv = v - vel[indx];      
      float a = dv / dt;
      
      // keep track of last x (dx) + last time (dt)
      lx.y = millis();
      lx.x = p.x; 
      
      //--------------------------------------------------
      
      // increment index
      indx++;      
      
      // store new values
      vel[indx] = -v * 0.05;
      accel[indx] = -a * 0.001;
      
      // make sure the index does not overshoot
      indx %= nbr_pts - 1;
      
      // clip the slider to positio (not that important)
      int e = round(p.x / steps);
      px.x = e * steps;                              
     
      
    }
  }    
}
