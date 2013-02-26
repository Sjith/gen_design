import javax.xml.parsers.ParserConfigurationException;
import org.xml.sax.SAXException;
import java.io.StringReader;

PImage img;
XML placeData;

void setup()
{
  
  size(600, 300);
 String apikey = "AIzaSyDqH0QP5inu8n9TZGhFIxicN2syc0WgmsU"; 
 String https = "https://maps.googleapis.com/maps/api/place/textsearch/xml?query=ciid+in+copenhagen+denmark&sensor=true&key=";
 //String https = "https://maps.googleapis.com/maps/api/place/textsearch/xml?query=liberty+15th++Aenue+in+seattle+&sensor=true&key=";
 
 String[] ls = loadStrings(https+apikey);
 //println(ls);
 
 StringReader r = new StringReader(join(ls, ' '));
 try {
   placeData = new XML(r);
 } catch( IOException ioe ) {
  println(" error ");
 } catch( ParserConfigurationException pce ) {
  println(" error ");
 } catch( SAXException se ) {
  println(" error ");
 }
 
 String lat = placeData.getChild("result/geometry/location/lat").getContent();
 String lng = placeData.getChild("result/geometry/location/lng").getContent();

 img = requestImage( "http://maps.googleapis.com/maps/api/streetview?size=600x300&location="+lat+","+lng+"&heading=0&fov=180&pitch=-10&sensor=false", "jpg");
 
}

void draw()
{
  if(img.width != 0) {
    image(img, 0, 0);
  }
}
