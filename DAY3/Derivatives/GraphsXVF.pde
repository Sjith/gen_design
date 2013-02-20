class GraphsXVF extends GraphsXVA {
  
  float[] forces;
  
  float X, V, F;    
  float m, k, d;
  int tick;
  
  
  GraphsXVF(int pad, int nbr_points, int pos_y, int vel_y, int force_y, int w) {
    super(pad, nbr_points, pos_y, vel_y, force_y, w);
    forces = new float[nbr_pts];
  }
  
  void draw() {
    // draw slider!
    draw_slider("Position");
    // draw velocity
    draw_graph("Velocity", c_vel, vel, 35);
    // draw forces
    draw_graph("Forces", c_accel, forces, 35);        
  }
  
  void position(int x, int y) {    
    
    // make sure we are in the 
    if(x > c_pos.x && x < c_pos.x + graphs_width) {

                  
      //--------------------------------------------------
      // !!!!!!!!!compute velocity and forces!!!!!!!
      
      // position (bring gloabl position into local coord system) 
      p.x = x - c_pos.x; p.y = y - c_pos.y;
      
      // difference of time
      float dt = (millis() - tick) / 1000.0f;          
      
      F = k * (p.x - X) - (d * V);
      V += (F / m) * dt;
      X += V * dt;       
      
      tick = millis();
      
      //--------------------------------------------------
      
      // increment index
      indx++;      
      
      // store new values
      vel[indx] = -V * 0.1;
      forces[indx] = -F * 0.05;
      
      // make sure the index does not overshoot
      indx %= nbr_pts - 1;
      
      // clip the slider to positio (not that important)
      int e = round(X / steps);
      px.x = X;                              
    }
  }    
  
}
