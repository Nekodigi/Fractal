class Cube{
  PVector pos;
  float size;
  ArrayList<Cube> children = null;
  
  Cube(PVector pos, float size){
    this.pos = pos;
    this.size = size;
  }
  
  void genChildren(){
    if(children == null){
      children = new ArrayList<Cube>();
      float nr = size/3;
      children.add(new Cube(PVector.add(pos, new PVector(nr*2, 0, 0)), nr));
      children.add(new Cube(PVector.add(pos, new PVector(-nr*2, 0, 0)), nr));
      children.add(new Cube(PVector.add(pos, new PVector(0, nr*2, 0)), nr));
      children.add(new Cube(PVector.add(pos, new PVector(0, -nr*2, 0)), nr));
      children.add(new Cube(PVector.add(pos, new PVector(0, 0, nr*2)), nr));
      children.add(new Cube(PVector.add(pos, new PVector(0, 0, -nr*2)), nr));
    }else{
      for(Cube child : children){
        child.genChildren();
      }
    }
  }
  
  void show(){
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    box(size);
    popMatrix();
    if(children != null){
      for(Cube child : children){
        child.show();
      }
    }
  }
}
