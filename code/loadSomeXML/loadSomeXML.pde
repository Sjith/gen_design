XML xml;

void setup()
{
  xml = loadXML( "testXML.xml");
  size(500, 500);
  noLoop();
}

void draw()
{
  
  XML[] rectangles = xml.getChildren("rectangle");
  
  int nextRectanglePosition = 0;
  
  for( int i = 0; i < rectangles.length; i++)
  {
    int w = rectangles[i].getInt("w");
    int h = rectangles[i].getInt("h");
    
    int r = rectangles[i].getInt("r");
    int g = rectangles[i].getInt("g");
    int b = rectangles[i].getInt("b");
    
    fill(r,g,b);
    rect( nextRectanglePosition, height-h, w, height );
    
    nextRectanglePosition+=w;
  }
  
}
