int kmax = 15;//max number of iteration
float xmin = -2, xmax = 2;//graph area
float ymin = -2, ymax = 2;
int gridS = 1;//grid(pixel) size



//Complex[] coeffs = {r(-1), r(0), r(0), r(1)};//{2, -2, 0, 1}coefficients in this order a + bz + cz^2
Complex[] coeffs;
ArrayList<Complex> controlPs = new ArrayList<Complex>();

//Complex p2 = c(-1./2, sqrt(3)/2);
//Complex p3 = c(-1./2, -sqrt(3)/2);
//may be jaggies come from float accuracy

void setup(){
  reset();
  //println(coeffs);
  //fullScreen();
  size(500, 500);
  //colorMode(HSB, 360, 100, 100);
}


void draw(){
  background(255);
  noStroke();
  for(float i=0; i<width; i+=gridS){
    for(float j=0; j<height; j+=gridS){
      float x = map(i, 0, width, xmin, xmax);
      float y = map(j, 0, height, ymin, ymax);
      Complex z = new Complex(x, y);
      int k=0;
      for(;k<kmax; k++){
        Complex zp = new Complex(z.x, z.y);//previous z
        z = z.sub(f(z, coeffs).div(f(z, differential(coeffs))));
        if(z.equal(zp))break;
        //if(z.mag() > 1)break;
      }
      fill(z.x*100*3+125, z.y*100*3+125, 0, map(k, 0, kmax, 0, 255));//something seem bad
      //fill(map(k, 0, kmax, 0, 360));
      rect(i, j, gridS, gridS);
    }
  }
  strokeWeight(5);
  stroke(0);
  noFill();
  
  for(Complex c : controlPs){
    ellipse(map(c.x, xmin, xmax, 0, width), map(c.y, ymin, ymax, 0, height), 50, 50);
  }
}

//Complex fdash(Complex z){
//  return new Complex(3, 0).mult(z).mult(z);
//}

//Complex f(Complex z){
//  return z.mult(z).mult(z).sub(1);
//}

void reset(){
  controlPs = new ArrayList<Complex>();
  controlPs.add(c(1, 0));
  controlPs.add(c(-1./2, sqrt(3)/2));
  controlPs.add(c(-1./2, -sqrt(3)/2));
  coeffs = coeffsFromAns(controlPs.toArray(new Complex[controlPs.size()]));
}

void addPoint(float x, float y){
  controlPs.add(new Complex(x, y));
  
}

void mousePressed(){
  addPoint(map(mouseX, 0, width, xmin, xmax), map(mouseY, 0, height, ymin, ymax));
  coeffs = coeffsFromAns(controlPs.toArray(new Complex[controlPs.size()]));
}

void keyPressed(){
  if(key == 'r'){
    reset();
  }
}
