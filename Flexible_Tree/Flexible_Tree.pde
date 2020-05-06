float baseLen = 350;
float branchAngle = 0.5;
float lenRand = 0.5;
float angleRand = 0.2;
float vPow = 0.1;
float vDump = 0.5;
int maxGen = 6;
float baseSWeight = 20;
ArrayList<Node> nodes = new ArrayList<Node>();
ArrayList<Spring> springs = new ArrayList<Spring>();
Node sNode;

void setup(){
  colorMode(HSB, 360, 100, 100);
  size(1000, 1000);
  init();
}

void draw(){
  background(135, 10, 90);
  noFill();
  sNode.pos = new PVector(mouseX, mouseY);
  for(Node node : nodes){
    node.show();
  }
  for(Spring spring : springs){
    spring.update();
  }
  for(Spring spring : springs){
    spring.show();
  }
}

void init(){
  nodes = new ArrayList<Node>();
  springs = new ArrayList<Spring>();
  sNode = new Node(width/2, height);
  nodes.add(sNode);
  treeGen(sNode, HALF_PI, 0);
}

void mousePressed(){
  init();
}

void treeGen(Node node, float angle, int gen){
  if(gen < maxGen){
    int showType = 1;
    if(gen == 0){
      showType = 0;
    }
    if(gen == maxGen - 2){
      showType = 2;
    }
    float newAngle = angle += random(-angleRand, angleRand);
    float len = baseLen/(gen+1)*random(1-lenRand, 1+lenRand);
    PVector newPos = PVector.add(node.pos, PVector.fromAngle(angle).mult(-len));
    float sWeight = baseSWeight/(gen+1);
    Node endNode = new Node(newPos.x, newPos.y);
    nodes.add(endNode);
    Spring spring = new Spring(node, endNode, sWeight, showType);
    springs.add(spring);
    treeGen(endNode, newAngle+branchAngle, gen+1);
    treeGen(endNode, newAngle-branchAngle, gen+1);
  }
}
