class Tetra{
  PVector pos;
  float size;
  ArrayList<Tetra> children = null;
  boolean flipped;
  int lv = 0;
  PVector b0x, b0y, b0z, b1x, b1y, b1z, b2x, b2y, b2z, b3x, b3y, b3z;//all basis vector
  
  Tetra(PVector pos, float size, boolean flipped){
    this.pos = pos;
    this.size = size;
    this.flipped = flipped;
    calcBasis();
  }
  
  void genChildren(){
    if(children == null){
      children = new ArrayList<Tetra>();
    }else{
      for(Tetra child : children){
        child.genChildren();
      }
    }
    float n = pow(2, lv);
    float dst = size/3+size/n/6;
    float r = size;
    float goffy = r;
    float offy = r*3/2/n*2/3;
    for(float i = 0; i < n; i++){
      float y = map(i, 0, n, 0, r*3/2)+offy-goffy;
      for(float j = 0; j <= i; j++){
        float x = j*sqrt(3)*r/n-sqrt(3)*r*i/n/2;
        PVector v = vecFromUVW(x, -y, dst, b0x, b0y, b0z);
        children.add(new Tetra(PVector.add(pos, v), r/n/2, !flipped));
        //ellipse(x, y, 50, 50);
      }
    }
    for(float i = 0; i < n; i++){
      float y = map(i, 0, n, 0, r*3/2)+offy-goffy;
      for(float j = 0; j <= i; j++){
        float x = j*sqrt(3)*r/n-sqrt(3)*r*i/n/2;
        PVector v = vecFromUVW(x, -y, dst, b1x, b1y, b1z);
        children.add(new Tetra(PVector.add(pos, v), r/n/2, !flipped));
        //ellipse(x, y, 50, 50);
      }
    }
    for(float i = 0; i < n; i++){
      float y = map(i, 0, n, 0, r*3/2)+offy-goffy;
      for(float j = 0; j <= i; j++){
        float x = j*sqrt(3)*r/n-sqrt(3)*r*i/n/2;
        PVector v = vecFromUVW(x, -y, dst, b2x, b2y, b2z);
        children.add(new Tetra(PVector.add(pos, v), r/n/2, !flipped));
        //ellipse(x, y, 50, 50);
      }
    }
    for(float i = 0; i < n; i++){
      float y = map(i, 0, n, 0, r*3/2)+offy-goffy;
      for(float j = 0; j <= i; j++){
        float x = j*sqrt(3)*r/n-sqrt(3)*r*i/n/2;
        PVector v = vecFromUVW(x, -y, -dst, b3x, b3y, b3z);
        children.add(new Tetra(PVector.add(pos, v), r/n/2, !flipped));
        //ellipse(x, y, 50, 50);
      }
    }
    //children.add(new Tetra(PVector.add(pos, vecs[1]), ids, !flipped));
    //children.add(new Tetra(PVector.add(pos, vecs[2]), ids, !flipped));
    //children.add(new Tetra(PVector.add(pos, vecs[3]), ids, !flipped));
    lv++;
  }
  
  void calcBasis(){
    PVector[] vecs = tetraVecs(size, flipped);//vertex of this tetrahedron
    //calculate midpoint
    PVector mid0 = PVector.add(vecs[0], vecs[1]).div(2);
    PVector mid1 = PVector.add(vecs[1], vecs[2]).div(2);
    PVector mid2 = PVector.add(vecs[2], vecs[0]).div(2);
    //calculate basis vector
    b0x = PVector.sub(vecs[2], vecs[1]).normalize();
    b0y = PVector.sub(vecs[3], mid1).normalize();
    b0z = b0y.cross(b0x);//vec00, vec01 scala is 1, so vec2 scala is 1(we don't have to normalize)
    b1x = PVector.sub(vecs[0], vecs[2]).normalize();
    b1y = PVector.sub(vecs[3], mid2).normalize();
    b1z = b1y.cross(b1x);
    b2x = PVector.sub(vecs[1], vecs[0]).normalize();
    b2y = PVector.sub(vecs[3], mid0).normalize();
    b2z = b2y.cross(b2x);
    b3x = PVector.sub(vecs[2], vecs[1]).normalize();
    b3y = PVector.sub(vecs[0], mid1).normalize();
    b3z = b3y.cross(b3x);
  }
  
  void show(){
    tetra(pos, size, flipped);
    if(children != null){
      for(Tetra child : children){
        child.show();
      }
    }
  }
}
