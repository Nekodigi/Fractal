class Node{
  PVector pos;
  ArrayList<Node> children = new ArrayList<Node>();
  
  Node(float x, float y){
    this.pos = new PVector(x, y);
  }
  
  void show(){
    noFill();
    fill(0, 100, 100);
    ellipse(pos.x, pos.y, 20, 20);
  }
}
