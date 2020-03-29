int maxgeneration = 0;
int maxgenerationLimit = 8;
boolean generationadd;

void setup(){
  fullScreen();
  frameRate(1);
}

void draw(){
  background(0);
  triangleLink(width / 2, height / 2, 0, 1024);
  if(maxgeneration > maxgenerationLimit){
    maxgeneration = -1;
  }
  maxgeneration++;
}

void triangleLink(float x, float y, float angle, float range){
  drawtriangle(x, y, angle, range, color(255), 0, 0); 
  clone(x, y, angle, angle, range, range,0, 0);
  clone(x, y, angle + 120, angle + 120, range, range,0, 1);
  clone(x, y, angle + 240, angle + 240, range, range,0 , 2);
}

void clone(float x, float y, float angle, float triaangle, float range, float ofsetrange, int generation, int exdirec){
  if(generation < maxgeneration){
    float sposx = excos(x, angle+60, ofsetrange/2);
    float sposy = exsin(y, angle+60, ofsetrange/2);
    float ofset = 0;
    drawtriangle(excos(sposx, 0 + angle, range/2) , exsin(sposy, 0 + angle, range/2), triaangle+60, range/2, color(256 - generation * 10, 256, 256), generation, exdirec); 
    drawtriangle(excos(sposx, 180 + angle, range/2) , exsin(sposy, 180 + angle, range/2), triaangle, range/2, color(100, 100 + generation * 10, 100), generation, exdirec); 
  }
}

void drawtriangle(float x, float y, float angle, float range, int col, int generation, int exdirec){
  fill(col);
  if(angle >= 360){
    angle -= 360;
  }
  noStroke();
  triangle(excos(x, angle, range) , exsin(y, angle, range), excos(x, angle+120, range), exsin(y, angle+120, range), excos(x, angle+240, range), exsin(y, angle+240, range));
  int ex0 = exdirec;
  int ex1 = exdirec + 1;
  int ex2 = exdirec + 2;
  if(ex1 >= 3){
    ex1 -= 3;
  }
  if(ex2 >= 3){
    ex2 -= 3;
  }
  if(ex2 >= 3){
    ex2 -= 3;
  }
  if(exdirec + 1 >= 0)
  if(angle >= 0 && angle < 120){
    clone(x, y, angle, angle, range, range, generation + 1, ex0);
    clone(x, y, angle + 240, angle + 240, range, range, generation + 1, ex2);
    print(ex1);
  }
  else if(angle >= 120 && angle < 240){
    clone(x, y, angle, angle, range, range, generation + 1, ex0);
    clone(x, y, angle + 240, angle + 240, range, range, generation + 1, ex2);
  }
  else if(angle >= 240 && angle < 360){
    clone(x, y, angle + 240, angle + 240, range, range, generation + 1, ex2);
    clone(x, y, angle, angle, range, range, generation + 1, ex0);
  }
  //ellipse(excos(x, angle, range) , exsin(y, angle, range), 100, 100);
}

float excos(float bias, float angle, float range){
   return bias + cos(radians(angle)) * range;
}

float exsin(float bias, float angle, float range){
   return bias + sin(radians(angle)) * range;
}

float grantonran(float gran){
  return sqrt(3) * gran / 6;
}