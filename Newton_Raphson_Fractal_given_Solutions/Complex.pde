Complex c(float x, float y){
  return new Complex(x, y);
}

Complex r(float x){
  return new Complex(x, 0);
}

class Complex{//Complexex number
  float x, y;
  Complex(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  String toString(){
    return "("+str(x)+","+str(y)+")";
  }
  
  float mag(){
    return sqrt(x*x + y*y);
  }
  
  boolean equal(Complex z){
    return x==z.x && y==z.y;
  }
  
  Complex powt(float value){//return this^value
    float angle = atan2(y, x);
    float mag = sqrt(x*x + y*y);
    float rangle = angle*value;
    float rmag = pow(mag, value);
    return new Complex(cos(rangle)*rmag, sin(rangle)*rmag);
  }
  //based on this site https://www.onlinemathlearning.com/multiplying-complex-numbers.html
  Complex mult(Complex z){
    return new Complex(x*z.x - y*z.y, y*z.x + x*z.y);
  }
  
  Complex mult(float z){
    return new Complex(x*z, y*z);
  }
  //based on this site http://www.sosmath.com/complex/number/basic/soscv.html
  Complex div(Complex z){
    return new Complex((x*z.x + y*z.y)/(z.x*z.x + z.y*z.y), (y*z.x - x*z.y)/(z.x*z.x + z.y*z.y));
  }
  
  Complex add(Complex target){
    return new Complex(x+target.x, y+target.y);
  }
  
  Complex add(float target){
    return new Complex(x+target, y);
  }
  
  Complex sub(Complex target){
    return new Complex(x-target.x, y-target.y);
  }
  
  Complex sub(float target){
    return new Complex(x-target, y);
  }
}
