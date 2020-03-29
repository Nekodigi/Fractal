ArrayList<branch> tbranchs = new ArrayList<branch>();
ArrayList<pressrepos> pposs = new ArrayList<pressrepos>();
int id;
float maxTreeWidth = 200;
int maxgeneration = 8;
float lengthmulti = 1;
float anglemulti = 1;
int Mode = 0;
boolean enablepress;

void setup(){
  colorMode(HSB, 360, 100, 100);
  fullScreen();
  id = 0;
  branchgen(width/2, height, width/2, height/4*3, 1);
  print(id);
  pressrepos ppos = new pressrepos();
  pposs.add(0, ppos);
}

void draw(){
  background(135, 10, 90);
  id = 0;
  float wid = width;
  float hei = height;
  pressrepos ppos = new pressrepos();
  ppos.x = mouseX;
  ppos.y = mouseY;
  ppos.power = 0.1;
  pposs.set(0, ppos);
  lengthmulti = 2*mouseY / wid;
  anglemulti = 2*mouseX / hei;
  fill(255);
  ellipse(mouseX, mouseY, 100, 100);
  colorMode(HSB, 360, 100, 100);
  stroke(41.7, 83.9, 45.0);
  branch(width/2, height, width/2, height/4*3, 1);
}

void mousePressed(){
  if(mouseButton == LEFT){
    tbranchs = new ArrayList<branch>();
    branchgen(width/2, height, width/2, height/4*3, 1);
  }
  else if(mouseButton == RIGHT){
    Mode++;
  }
  else{
    enablepress = !enablepress;
  }
}

void branchgen(float fposx, float fposy, float sposx, float sposy, int generation){
  if(generation > maxgeneration){
    return;
  }
  float angle = atan2(sposy-fposy, sposx-fposx);
  float distance = dist(fposx, fposy, sposx, sposy);
  float pos1len = distance*random(0.4, .8);
  float pos2len = distance*random(0.4, .8);
  float pos1x1 = fposx+cos(angle)*pos1len;
  float pos1y1 = fposy+sin(angle)*pos1len;
  //ellipse(pos1x1, pos1y1, 10, 10);
  float pos2x1 = fposx+cos(angle)*pos2len;
  float pos2y1 = fposy+sin(angle)*pos2len;
  //ellipse(pos2x1, pos2y1, 10, 10);
  float pos1angle = radians(random(10, 40));
  float pos2angle = radians(random(320, 350));
  float pos1x2 = pos1x1+cos(angle+pos1angle)*pos1len;
  float pos1y2 = pos1y1+sin(angle+pos1angle)*pos1len;
  //ellipse(pos1x2, pos1y2, 10, 10);
  float pos2x2 = pos2x1+cos(angle+pos2angle)*pos2len;
  float pos2y2 = pos2y1+sin(angle+pos2angle)*pos2len;
  float stickweight = (maxTreeWidth/pow(2,generation) - maxTreeWidth/pow(2,generation+1))/2;
  float fposxofset = cos(angle+PI/2)*stickweight;
  float fposyofset = sin(angle+PI/2)*stickweight;
  //ellipse(pos2x2, pos2y2, 10, 10);
  noFill();
  strokeWeight(maxTreeWidth/pow(2,generation+1));
  branch tbranch = new branch();
  if(pos1angle <= PI){
    tbranch.angle1 = pos1angle;
  }
  else{
    tbranch.angle1 = -(2*PI - pos1angle);
  }
  if(pos2angle <= PI){
    tbranch.angle2 = pos2angle;
  }
  else{
    tbranch.angle2 = -(2*PI - pos2angle);
  }
  tbranch.dist1 = pos1len;
  tbranch.dist2 = pos2len;
  tbranchs.add(tbranch);
  bezier(fposx+fposxofset, fposy+fposyofset, pos1x1, pos1y1, pos1x2, pos1y2, pos1x2, pos1y2);
  bezier(fposx-fposxofset, fposy-fposyofset, pos2x1, pos2y1, pos2x2, pos2y2, pos2x2, pos2y2);
  bezier(fposx+fposxofset, fposy+fposyofset, pos1x1, pos1y1, pos1x2, pos1y2, pos1x2, pos1y2);
  bezier(fposx-fposxofset, fposy-fposyofset, pos2x1, pos2y1, pos2x2, pos2y2, pos2x2, pos2y2);
  id++;
  branchgen(pos1x2, pos1y2, pos1x2+cos(angle+pos1angle)*pos1len, pos1y2+sin(angle+pos1angle)*pos1len, generation+1);
  branchgen(pos2x2, pos2y2, pos2x2+cos(angle+pos2angle)*pos2len, pos2y2+sin(angle+pos2angle)*pos2len, generation+1);
}

void branch(float fposx, float fposy, float sposx, float sposy, int generation){
  if(generation > maxgeneration){
    return;
  }
  float angle = atan2(sposy-fposy, sposx-fposx);
  float distance = dist(fposx, fposy, sposx, sposy);
  branch tbranch = tbranchs.get(id);
  float pos1len = 0;
  float pos2len = 0;
  float pos1angle = 0;
  float pos2angle = 0;
  switch(Mode){
    case 0:
      pos1len = tbranch.dist1*lengthmulti;
      pos2len = tbranch.dist2*lengthmulti;
      pos1angle = tbranch.angle1*anglemulti;
      pos2angle = tbranch.angle2*anglemulti;
      break;
    case 1:
      pos1len = tbranch.dist1;
      pos2len = tbranch.dist2;
      pos1angle = tbranch.angle1;
      pos2angle = tbranch.angle2;
      break;
    default:
      Mode = 0;
  }
  float pos1x1 = fposx+cos(angle)*pos1len;
  float pos1y1 = fposy+sin(angle)*pos1len;
  //ellipse(pos1x1, pos1y1, 10, 10);
  float pos2x1 = fposx+cos(angle)*pos2len;
  float pos2y1 = fposy+sin(angle)*pos2len;
  //ellipse(pos2x1, pos2y1, 10, 10);
  float pos1x2 = pos1x1+cos(angle+pos1angle)*pos1len;
  float pos1y2 = pos1y1+sin(angle+pos1angle)*pos1len;
  //ellipse(pos1x2, pos1y2, 10, 10);
  float pos2x2 = pos2x1+cos(angle+pos2angle)*pos2len;
  float pos2y2 = pos2y1+sin(angle+pos2angle)*pos2len;
  if(enablepress){
    for(pressrepos ppos: pposs){
      pos1x2 += (pos1x2-ppos.x)*ppos.power/pow(1.001,dist(pos1x2, pos1y2, ppos.x, ppos.y));
      pos1y2 += (pos1y2-ppos.y)*ppos.power/pow(1.001,dist(pos1x2, pos1y2, ppos.x, ppos.y));
      pos2x2 += (pos2x2-ppos.x)*ppos.power/pow(1.001,dist(pos2x2, pos2y2, ppos.x, ppos.y));
      pos2y2 += (pos2y2-ppos.y)*ppos.power/pow(1.001,dist(pos2x2, pos2y2, ppos.x, ppos.y));
    }
  }
  float stickweight = (maxTreeWidth/pow(2,generation) - maxTreeWidth/pow(2,generation+1))/2;
  float fposxofset = cos(angle+PI/2)*stickweight;
  float fposyofset = sin(angle+PI/2)*stickweight;
  //ellipse(pos2x2, pos2y2, 10, 10);
  noFill();
  strokeWeight(maxTreeWidth/pow(2,generation+1));
  bezier(fposx+fposxofset, fposy+fposyofset, pos1x1, pos1y1, pos1x2, pos1y2, pos1x2, pos1y2);
  bezier(fposx-fposxofset, fposy-fposyofset, pos2x1, pos2y1, pos2x2, pos2y2, pos2x2, pos2y2);
  bezier(fposx+fposxofset, fposy+fposyofset, pos1x1, pos1y1, pos1x2, pos1y2, pos1x2, pos1y2);
  bezier(fposx-fposxofset, fposy-fposyofset, pos2x1, pos2y1, pos2x2, pos2y2, pos2x2, pos2y2);
  id++;
  branch(pos1x2, pos1y2, pos1x2+(pos1x2-pos1x1), pos1y2+(pos1y2-pos1y1), generation+1);
  branch(pos2x2, pos2y2, pos2x2+(pos2x2-pos2x1), pos2y2+(pos2y2-pos2y1), generation+1);
}

class position{
  float x;
  float y;
}

class pressrepos extends position{
  float power;
}

class branch{
  float angle1;
  float dist1;
  float angle2;
  float dist2;
}