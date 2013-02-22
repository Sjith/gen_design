double earth_radius = 6371; //km

// based on haversine formula - http://en.wikipedia.org/wiki/Haversine_formula
float distance(PVector lat_lon_0, PVector lat_lon_1) {
  
  float lat0 = to_radians(lat_lon_0.x);
  float lon0 = to_radians(lat_lon_0.y);
  float lat1 = to_radians(lat_lon_1.x);
  float lon1 = to_radians(lat_lon_1.y);
  
  float dlat = lat1 - lat0;
  float dlon = lon1 - lon0;
  
  double h = sin(dlat / 2) * sin(dlat / 2) + cos(lon0) * cos(lon1) * sin(dlon / 2) * sin(dlon / 2);
  double a = 2 * Math.atan2(Math.sqrt(h), Math.sqrt(1 - h));
  double d = h * earth_radius * 1000.0;
  
  return  (float)d;
  
}

float angle(PVector a, PVector b) {
  // a . b = |a||b|cos(ø)
  float angle = acos(a.dot(b) / (a.mag() * b.mag()));
  if(b.y > a.y)
    angle = TWO_PI - angle;
  return angle;
}

float ellipsoid_a = 6378137.0;
float ellipsoid_b = 6356752.314;

float distance_world_mercator(PVector lat_lon_0, PVector lat_lon_1) {
  
  float lat0 = to_radians(lat_lon_0.x);
  float lon0 = to_radians(lat_lon_0.y);
  float lat1 = to_radians(lat_lon_1.x);
  float lon1 = to_radians(lat_lon_1.y);
  
  PVector m0 = new PVector();
  m0.y = ellipsoid_a * lon0;
  m0.x = ellipsoid_a * log((sin(lat0) + 1) / cos(lat0));
  
  PVector m1 = new PVector();
  m1.y = ellipsoid_a * lon1;
  m1.x = ellipsoid_a * log((sin(lat1) + 1) / cos(lat1));
 
  return PVector.dist(m1, m0); 
}

float to_radians(float deg) {
    return deg * PI / 180;
}


