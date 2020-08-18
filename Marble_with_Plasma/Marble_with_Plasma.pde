int deg = 8;
int n;
int step;
float pSize;
float[][] map;
float randomFac = .2;
float randomFac2 = .1;
PGraphics pg;
float noiseS = 100;//noise scale
float noiseP = 5;//noise power
MeshDeform meshDeform;

void setup(){
  size(500, 500, P3D);
  pg = createGraphics(width, height);
  pg.colorMode(HSB, 360, 100, 100);
  //fullScreen();
  pg.beginDraw();
  plasmaNoise();
  pg.endDraw();
  meshDeform = new MeshDeform(pg, new PVector(0, 0), new PVector(width, height));
  //image(pg, 0, 0);
}

void mousePressed(){
  plasmaNoise();
}

void draw(){
  //background(255);
  PVector[][] target = meshDeform.ctrPoss;
  for(int i=0; i<target[0].length; i++){
    for(int j=0; j<target.length; j++){
      //float angle = noise(target[i][j].x/noiseS, target[i][j].y/noiseS)*TWO_PI*8;
      float x = (noise(target[i][j].x/noiseS, target[i][j].y/noiseS)-0.5)*noiseP;
      float y = (noise(target[i][j].x/noiseS, target[i][j].y/noiseS, 1)-0.5)*noiseP;
      //target[i][j].add(PVector.fromAngle(angle).mult(noiseP));
      target[i][j].add(x, y);
    }
  }
  noStroke();
  meshDeform.show();
}

void plasmaNoise(){
  n = (int)pow(2, deg)+1;
  map = new float[n][n];
  map[0][0] = random(1);
  map[n-1][0] = random(1);
  map[0][n-1] = random(1);
  map[n-1][n-1] = random(1);
  pSize = float(width)/n;
  step = n - 1;
  while(step >= 2){//https://en.wikipedia.org/wiki/Diamond-square_algorithm
    for(int i = 0; i < n-1; i+=step){
      for(int j = 0; j < n-1; j+=step){
        float bl = map[i][j];//bottom left
        float br = map[i+step][j];
        float tl = map[i][j+step];
        float tr = map[i+step][j+step];
        map[i+step/2][j+step/2] = (bl+br+tl+tr)/4+random(-1, 1)*randomFac;//square midpoint
        map[i+step/2][j] = (bl+br)/2+random(-1, 1)*randomFac2;//diamond bottom
        map[i+step/2][j+step] = (tl+tr)/2+random(-1, 1)*randomFac2;//diamond top
        map[i][j+step/2] = (bl+br)/2+random(-1, 1)*randomFac2;//diamond left
        map[i+step][j+step/2] = (tl+tr)/2+random(-1, 1)*randomFac2;//diamond right
       // rect(i*pSize, j*pSize, pSize, pSize);
      }
    }
    step /= 2;//square size
  }
  writeMap();
}
