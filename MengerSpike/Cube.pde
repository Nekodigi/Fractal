class Cube{
  PVector pos;
  float size;
  ArrayList<Cube> children = null;
  int lv = 0;
  
  Cube(PVector pos, float size){
    this.pos = pos;
    this.size = size;
  }
  
  void genChildren(){
    if(children == null){
      children = new ArrayList<Cube>();
    }else{
      for(Cube child : children){
        child.genChildren();
      }
    }
    float ids = size/pow(3, lv);
    for(float s = -1; s <= 1; s+=2){//s = +-1
      for(float i = -size/2; i < size/2-EPSILON; i+= ids){
        for(float j = -size/2; j < size/2-EPSILON; j+= ids){
          children.add(new Cube(PVector.add(pos, new PVector(s*(size/2+ids/6), i+ids/2, j+ids/2)), ids/3));
        }
      }
    }
    for(float s = -1; s <= 1; s+=2){//s = +-1
      for(float i = -size/2; i < size/2-EPSILON; i+= ids){
        for(float j = -size/2; j < size/2-EPSILON; j+= ids){
          children.add(new Cube(PVector.add(pos, new PVector(s*(size/2+ids/6), i+ids/2, j+ids/2)), ids/3));
        }
      }
    }
    for(float s = -1; s <= 1; s+=2){//s = +-1
      for(float i = -size/2; i < size/2-EPSILON; i+= ids){
        for(float j = -size/2; j < size/2-EPSILON; j+= ids){
          children.add(new Cube(PVector.add(pos, new PVector(j+ids/2, s*(size/2+ids/6), i+ids/2)), ids/3));
        }
      }
    }
    for(float s = -1; s <= 1; s+=2){//s = +-1
      for(float i = -size/2; i < size/2-EPSILON; i+= ids){
        for(float j = -size/2; j < size/2-EPSILON; j+= ids){
          children.add(new Cube(PVector.add(pos, new PVector(i+ids/2, j+ids/2, s*(size/2+ids/6))), ids/3));
        }
      }
    }
    lv++;
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
