String urlSF, urlNY, urlAZ; // usually class names start with capital letters

PImage imgSF, imgNY, imgAZ; // variable to store image

void setup() {
size(640, 640);
String apikey = "&key=AIzaSyDqH0QP5inu8n9TZGhFIxicN2syc0WgmsU";
urlNY = "http://maps.googleapis.com/maps/api/streetview?size=640x640&location=40.75896,%20-73.985195&fov=90&heading=45&pitch=10&sensor=false"+apikey;
imgNY = loadImage(urlNY, "jpg");

urlSF = "http://maps.googleapis.com/maps/api/streetview?size=640x640&location=37.767125,%20-122.400084&fov=90&heading=45&pitch=10&sensor=false"+apikey;
imgSF = loadImage(urlSF, "jpg");

urlAZ = "http://maps.googleapis.com/maps/api/streetview?size=640x640&location=33.597347,%20-111.843181&fov=90&heading=45&pitch=10&sensor=false"+apikey;
imgAZ = loadImage(urlAZ, "jpg");
}


void draw() {
background(255);
if (keyPressed) {
if (key == 'a') {
image(imgAZ, 0, 0);
}
else if (key == 'n') {
image(imgNY, 0, 0);
}
else if (key == 's') {
image(imgSF, 0, 0);
}
else {
fill(200);
rect(-1, -1, 650, 650);
}
}
}
