float baseSize = 400;
Cube cube;
Tetra tetra;
int dispType = 0;

void setup(){
  size(500, 500, P3D);
  //fullScreen(P3D);
  baseSize = height/5*4;
  cube = new Cube(new PVector(0, 0, 0), baseSize);
  tetra = new Tetra(new PVector(0, 0, 0), baseSize, false);
}

void mousePressed(){
  cube.genChildren();
  tetra.genChildren();
}

void keyPressed(){
  if(key == 'd'){
    dispType++;
    if(dispType == 2){
      dispType = 0;
    }
  }
  if(key == 'r'){
    cube = new Cube(new PVector(0, 0, 0), baseSize);
    tetra = new Tetra(new PVector(0, 0, 0), baseSize, false);
  }
}

void draw(){
  background(0);
  lights();
  translate(width/2, height/2, -height);
  float rt = float(frameCount)/100;
  rotateX(rt/10); rotateY(rt); rotateZ(rt/5);
  switch(dispType){
    case 0:
      cube.show();
      break;
    case 1: 
      tetra.show();
    break;
  }
}
