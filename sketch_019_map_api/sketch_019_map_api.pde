 int W=600, H=400;
//final static String geoc="55.682412,12.593336";
final static String geoc="46.012224,11.236954";
PImage imgs[]=new PImage[4];
String apikey = "AIzaSyDqH0QP5inu8n9TZGhFIxicN2syc0WgmsU";
final static int zoom=16;
String[] services={"google","cloudmade","mapquest","openstreetmap"};
void setup()
{
  W=displayWidth/2;
  H=displayHeight/2;
  size(displayWidth,displayHeight );
  String[] requestUrl=new String[4];
  String apikey = "AIzaSyDqH0QP5inu8n9TZGhFIxicN2syc0WgmsU";
  
   requestUrl[0]="http://maps.googleapis.com/maps/api/staticmap?center="+geoc+"&zoom="+zoom+"&size="+W+"x"+H+"&sensor=false&scale=2&key="+apikey;
  
  //requestUrl[0]="http://staticmap.openstreetmap.de/staticmap.php?center="+geoc+"&zoom="+10+"&size="+W+"x"+H+"&maptype=mapnik";
  requestUrl[3]="http://pafciu17.dev.openstreetmap.org/?module=map&center="+geoc+"&zoom="+zoom+"&width="+W+"&height="+H;
  //requestUrl[3]="http://staticmap.openstreetmap.de/staticmap.php?center="+geoc+"&zoom="+zoom+"&size="+W+"x"+H+"&maptype=mapnik";
  requestUrl[2]="http://open.mapquestapi.com/staticmap/v4/getmap?size="+W+","+H+"&zoom="+zoom+"&center="+geoc;
  requestUrl[1]="http://staticmaps.cloudmade.com/8ee2a50541944fb9bcedded5165f09d9/staticmap?center="+geoc+"&zoom="+zoom+"&size="+W+"x"+H+"&format=jpg&styleid=997";
  // String requestUrl=" http://open.mapquestapi.com/staticmap/v3/getmap?size="+W+","+H+"&zoom="+(int)random(8,14)+"&center="+geoc;
  // String requestUrl="http://www.redherring.com/wp-content/uploads/2012/01/apple-150x150.png";
  int timeTmp=millis();
  try{
  for (int i=0;i<requestUrl.length;i++)
  {
    imgs[i]=loadImage(requestUrl[i]);
     println("loaded:"+services[i]+" in time:"+(millis()-timeTmp));
     timeTmp=millis();
  }
  }
  catch(Exception e)
  {
    
  }
}

void draw()
{
  if (imgs!=null)
  {
    for (int i=0;i<imgs.length;i++)
    { 
      try{
        image(imgs[i], W*(int)(floor(i%2)), H*(int)floor(i/2), W, H);
      }
      catch(Exception e)
      {
       println("exception in "+services[i]+" map"); 
      }
    }
  }
}

