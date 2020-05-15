float r = 200;

void setup(){
  size(500, 500);
  translate(width/2, height/2);
  float goffy = r;
  for(int iter = 3; iter >= 0; iter--){
    int n = (int)pow(2, iter);
    float offy = r*3/2/n*2/3;
    for(float i = 0; i < n; i++){
      float y = map(i, 0, n, 0, r*3/2)+offy-goffy;
      for(float j = 0; j <= i; j++){
        float x = j*sqrt(3)*r/n-sqrt(3)*r*i/n/2;
        triangle(new PVector(x, y), r/2/n, false);
        //ellipse(x, y, 50, 50);
      }
    }
  }
  //fill(0);
  //for(float i = 0; i <= n; i++){
  //  float y = map(i, 0, n, 0, r*3/2)-goffy;
  //  for(float j = 0; j <= i; j++){
  //    float x = j*r*sqrt(3)/n-r*sqrt(3)*i/n/2;
  //    ellipse(x, y, 50, 50);
  //  }
  //}
}

void triangle(PVector pos, float r, boolean flipped){
  float sign = 1;
  if(flipped)sign = -1;
  triangle(pos.x, pos.y+r*sign, pos.x-r/2*sqrt(3), pos.y-r/2*sign, pos.x+r/2*sqrt(3), pos.y-r/2*sign);
}
