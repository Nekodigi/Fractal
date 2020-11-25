int kmax = 15;
float xmin = -2, xmax = 2;
float ymin = -2, ymax = 2;



Complex[] coeffs = {r(-1), r(0), r(0), r(1)};//{2, -2, 0, 1}coefficients in this order a + bz + cz^2
ArrayList<Complex> controlPs = new ArrayList<Complex>();

Complex p2 = c(-1./2, sqrt(3)/2);
Complex p3 = c(-1./2, -sqrt(3)/2);
//may be jaggies come from float accuracy

void setup(){
  controlPs.add(c(1, 0));
  controlPs.add(c(-1./2, sqrt(3)/2));
  controlPs.add(c(-1./2, -sqrt(3)/2));
  coeffs = coeffsFromAns(controlPs.toArray(new Complex[controlPs.size()]));
  println(coeffs);
  size(500, 500);
  //colorMode(HSB, 360, 100, 100);
}

void mousePressed(){
  controlPs.add(new Complex(map(mouseX, 0, width, xmin, xmax), map(mouseY, 0, height, ymin, ymax)));
}

void draw(){
  background(255);
  noStroke();
  for(float i=0; i<width; i++){
    for(float j=0; j<height; j++){
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
      rect(i, j, 1, 1);
    }
  }
  strokeWeight(5);
  stroke(0);
  noFill();
  coeffs = coeffsFromAns(controlPs.toArray(new Complex[controlPs.size()]));
  for(Complex c : controlPs){
    ellipse(map(c.x, xmin, xmax, 0, width), map(c.y, ymin, ymax, 0, height), 50, 50);
  }
}

Complex fdash(Complex z){
  return new Complex(3, 0).mult(z).mult(z);
}

Complex f(Complex z){
  return z.mult(z).mult(z).sub(1);
}

Complex[] coeffsFromAns(Complex ... answers){
  Complex[] coeffs = new Complex[2];
  coeffs[0] = answers[0].mult(-1);
  coeffs[1] = c(1, 0);
  for(int i=1; i<answers.length; i++){
    Complex[] f = {answers[i].mult(-1), r(1)};
    coeffs = formulaMult(coeffs, f);
  }
  return coeffs;
}

Complex[] formulaMult(Complex[] f1, Complex[] f2){
  Complex[] result = new Complex[f1.length+f2.length-1];
  for(int i=0; i<=f1.length-1+f2.length-1; i++){
    result[i] = c(0, 0);
    println(i, max(i-(f2.length-1), 0), min(i, f1.length-1));
    for(int j=max(i-(f2.length-1), 0); j<=min(i, f1.length-1); j++){
      result[i] = result[i].add(f1[j].mult(f2[i-j]));
    }
  }
  return result;
}

Complex[] differential(Complex ... coeffs){
  Complex[] result = new Complex[coeffs.length-1];
  for(int i=1; i<coeffs.length; i++){
    result[i-1] = coeffs[i].mult(i);
  }
  return result;
}

Complex f(Complex z, Complex ... coeffs){//coefficents are this order a + bz + cz^2
  Complex result = new Complex(0, 0);
  for(int i=0; i<coeffs.length; i++){
    Complex temp = coeffs[i];
    for(int j=0; j<i; j++){
      temp = temp.mult(z);
    }
    result = result.add(temp);
  }
  return result;
}
