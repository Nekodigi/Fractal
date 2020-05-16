PVector[] tetraVecs(float r, boolean flipped){
  float sign = 1;
  if(flipped){
    sign = -1;
  }
  PVector[] result = new PVector[4];
  result[0] = new PVector(sqrt(6)*r/3, r/3*sign, -sqrt(2)*r/3*sign);
  result[1] = new PVector(-sqrt(6)*r/3, r/3*sign, -sqrt(2)*r/3*sign);
  result[2] = new PVector(0, r/3*sign, 2*sqrt(2)*r/3*sign);
  result[3] = new PVector(0, -r*sign, 0);
  return result;
}

void tetra(PVector pos, float r, boolean flipped){
  PVector[] points = tetraVecs(r, flipped);
  pushMatrix();
  translate(pos.x, pos.y, pos.z);
  triangleVec(points[0], points[1], points[2]);
  triangleVec(points[0], points[3], points[1]);
  triangleVec(points[1], points[3], points[2]);
  triangleVec(points[2], points[3], points[0]);
  popMatrix();
}

void triangleVec(PVector a, PVector b, PVector c){
  pushMatrix();
  beginShape();
  vertex(a.x, a.y, a.z);
  vertex(b.x, b.y, b.z);
  vertex(c.x, c.y, c.z);
  endShape(CLOSE);
  popMatrix();
}
