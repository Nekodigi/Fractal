class Tetra{
  PVector pos;
  float size;
  ArrayList<Tetra> children = null;
  boolean flipped;
  int lv = 0;
  
  Tetra(PVector pos, float size, boolean flipped){
    this.pos = pos;
    this.size = size;
    this.flipped = flipped;
  }
  
  void genChildren(){
    if(children == null){
      children = new ArrayList<Tetra>();
    }else{
      for(Tetra child : children){
        child.genChildren();
      }
    }
    float ids = size/2;
    float dst = -sqrt(2)*size/3*(3/2);
    PVector[] vecs = tetraVecs(dst, flipped);
    children.add(new Tetra(PVector.add(pos, vecs[0]), ids, !flipped));
    children.add(new Tetra(PVector.add(pos, vecs[1]), ids, !flipped));
    children.add(new Tetra(PVector.add(pos, vecs[2]), ids, !flipped));
    children.add(new Tetra(PVector.add(pos, vecs[3]), ids, !flipped));
    lv++;
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
