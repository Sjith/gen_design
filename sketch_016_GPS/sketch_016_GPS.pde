import ketai.sensors.*;

/*
size(1280,931);
 bounds(12.5838,55.6801, 12.605 , 55.6888);
 leftLon, bottomLat, rightLon, topLat
 */

final static int   MAP_WIDTH    = 1280;
final static int   MAP_HEIGHT   = 931;

final static float LEFT_LON     = 12.5838;
final static float BOTTOM_LAT   = 55.6801;

final static float RIGHT_LON    = 12.605;
final static float TOP_LAT      = 55.6888;


MercatorMap map;
PImage map_background;
KetaiLocation location;
PVector me;
PVector me_pixel;

void setup()
{
  orientation(LANDSCAPE);
  size(displayWidth, displayHeight);

  //float mapScreenWidth, float mapScreenHeight, float topLatitude, float bottomLatitude, float leftLongitude, float rightLongitude) {
  map =new MercatorMap(MAP_WIDTH, MAP_HEIGHT, TOP_LAT, BOTTOM_LAT, LEFT_LON, RIGHT_LON );
  map_background=loadImage("CIID_map.png");
  me_pixel=new PVector(0, 0);
  me=new PVector(0, 0);
  location=new KetaiLocation(this);
}


void draw()
{
  image(map_background, 0, 0, MAP_WIDTH, MAP_HEIGHT);
  stroke(0, 255, 230, 100);
  fill(0, 255, 200, 100);
  ellipse(me_pixel.x, me_pixel.y, 8, 8);
}

void onLocationEvent(double _latitude, double _longitude, double _altitude)
{
  try {


    me.x=(float)_latitude;
    me.y=(float)_longitude;
    me_pixel = map.getScreenLocation(me);
    println(me.x+" "+me.y);
  }
  catch(Exception e)
  {
    println(e);
  }
}

