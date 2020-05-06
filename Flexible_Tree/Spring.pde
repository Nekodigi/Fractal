class Spring{
  Node start, end;
  PVector defDiff;
  float defLen;
  PVector vel = new PVector();//moment of force
  int showType = 1;
  float sWeight;
  
  Spring(Node start, Node end, float sWeight, int showType){
    this.start = start;
    this.end = end;
    start.children.add(end);
    defDiff = PVector.sub(end.pos, start.pos);
    defLen = PVector.dist(start.pos, end.pos);
    this.showType = showType;
    this.sWeight = sWeight;
  }
  
  void update(){
    PVector diff = PVector.sub(end.pos, start.pos);
    PVector dd = PVector.sub(defDiff, diff);
    vel.add(dd.mult(vPow));
    diff.add(vel);
    end.pos = PVector.add(start.pos, diff);
    vel.mult(vDump);
  }
  
  void show(){
    stroke(41.7, 83.9, 45.0);
    strokeWeight(sWeight);
    noFill();
    //line(start.pos.x, start.pos.y, end.pos.x, end.pos.y);
    for(Node child : end.children){
      PVector smid = PVector.add(start.pos, end.pos).div(2);
      PVector emid = PVector.add(end.pos, child.pos).div(2);
      bezier(smid.x, smid.y, end.pos.x, end.pos.y, end.pos.x, end.pos.y, emid.x, emid.y);
      switch(showType){
        case 0:
          line(start.pos.x, start.pos.y, smid.x, smid.y);
          break;
        case 2:
          line(emid.x, emid.y, child.pos.x, child.pos.y);
          break;
      }
    }
  }
}
