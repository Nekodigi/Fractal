import processing.core.*; 
import processing.data.*; 
import hypermedia.net.*; 

float radius = 10;
float maxx = Float.NEGATIVE_INFINITY;
float minx = Float.POSITIVE_INFINITY;
float maxy = Float.NEGATIVE_INFINITY;
float miny = Float.POSITIVE_INFINITY;
UDP udp;
String msg = "";

final String IP = "MainPC.local";//this PC IP
final int PORT = 5000;

public void setup() {
  fullScreen(P3D);
  udp = new UDP(this, PORT);
  udp.listen( true );
  background(255);
}

public void draw() {
  //background(255);
  fill(255, 10);
  rect(0,0, width, height);
  String[] datas = msg.split(",");
  fill(255, 0, 0);
  ellipse(width/2,height/2,10,10);
  fill(0, 255, 0);
  ellipse(width/2+(maxx+minx)/2*radius,height/2+(maxy+miny)*radius,10,10);
  if(datas.length == 12){
    float x = PApplet.parseFloat(datas[9])+38;
    float y = PApplet.parseFloat(datas[10])-45;
  translate(width/2+(x)*radius, height/2+(y)*radius, PApplet.parseFloat(datas[11])*radius);
  if(maxx < x){
    maxx = x;
  }
  if(minx > x){
    minx = x;
  }
  if(maxy < y){
    maxy = y;
  }
  if(miny > y){
    miny = y;
  }
  println(atan2(y,x));
  fill(255);
  strokeWeight(1);
  stroke(0);
  sphere(5);
  }
}

public void receive( byte[] data, String ip, int port ) {
  msg = new String( data );
  //println(msg);
}