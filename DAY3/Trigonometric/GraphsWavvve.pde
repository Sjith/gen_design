class GraphsWavvve {
  
  int nbr_pts;
  int graphs_width;
  float steps;
  int indx = 0;
  int axis_y = 50;
  
  float[] sine;
  float[] cosine;
  
  PVector pos;
  
  GraphsWavvve(int nbr_points, int pos_x, int pos_y, int w) {
    nbr_pts = nbr_points;
    graphs_width = w;
    steps = (float) graphs_width / nbr_pts;
    
    pos = new PVector(pos_x, pos_y);
    
    sine = new float[nbr_pts];
    cosine = new float[nbr_pts];
  }
  
  void draw() {
    pushMatrix();
    
    // position
    translate(pos.x, pos.y);
    noFill();
    stroke(255, 255, 255);
    line(0, 0, graphs_width, 0);
    line(0, -axis_y, 0, axis_y);
    line(graphs_width, -axis_y, graphs_width, axis_y);    
    
    float x = 0;
    for(int i = 0; i < nbr_pts - 1; i++) {
      stroke(127, 34, 255);
      line(x, sine[i], x + steps, sine[i + 1]);
      stroke(255, 34, 127);
      line(x, cosine[i], x + steps, cosine[i + 1]);
      
      if(i == indx) {
        stroke(255);
        ellipse(x, sine[i], 6, 6);
        ellipse(x, cosine[i], 6, 6);
      }

      x += steps;
    }

    popMatrix();    
  }
  
  void data(float s, float c) {
      // increment index
      indx++;      
      sine[indx] = s * axis_y;
      cosine[indx] = c * axis_y;
      indx %= nbr_pts - 1;
  }
  
}
