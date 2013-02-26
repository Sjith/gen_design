//import com.google.api.translate.Language;
//import com.google.api.translate.Translate;

PImage img;

void setup() 
{
   
   size(600, 600);
   img = requestImage( "http://maps.googleapis.com/maps/api/streetview?size=600x600&location=55.682366,12.593576&heading=320&fov=180&pitch=-10&sensor=false");
    
}

void draw() {
  if(img != null)
    image(img, 0, 0);
}
