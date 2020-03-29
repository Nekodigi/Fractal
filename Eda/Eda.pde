float PositionData[][] = new float[3][2]; //It is a variable to put mouse position information
float edata[][] = new float[100000][100]; // It cintains random numbers;
int nowinputProgress; //dont edit it
float Width = 50; //BasicEdaWidth Width = 50 default; Width < 50 It bocomes thin; Width > 50 It becomes thick;
float Longth = 150; //BasicEdaLongth Longth = 300 default;
float decay = 0.1; //decay = 1 default; decay = 0  Doesn't decay; decay > 1 It decays quickly;
float Random = 10; //Random = 50 default; Random = 0 It doesnt Random; Random > 50 Strong;
float hosei = 0.5; //hosei = 1 default; hosei = 0 It doesn't hosei; hosei > 1 Strong;
float StrokeW = 10;
float StrokeChange = 0.75;
float repetition = 12;

void setup(){
  background(0);
  fullScreen();
  edasetup();
}

void draw(){
}

void eda(float pos1X, float pos1Y, float pos2X, float pos2Y, int generation, float Stroke_W){
  strokeWeight(Stroke_W);
  stroke(255);
  float gen = (1 + generation * decay);
  float nextgen = (1 + (generation + 1) * decay);
  float Angle = atan2(pos2X - pos1X, pos2Y - pos1Y);
  float longth = Longth / gen;
  float nextlongth = Longth / nextgen;
  pos2X = sin(Angle) * longth + pos1X;
  pos2Y = cos(Angle) * longth + pos1Y;
  noFill();
  float pos3X = pos2X + sin(Angle) * longth / 2;
  float pos3Y = pos2Y + cos(Angle) * longth / 2 + (random(-Random, Random) / gen );
  float SecondAngle = atan2(pos3X - pos2X, pos3Y - pos2Y);
  float pos4X = pos2X + sin(SecondAngle) * longth;
  float pos4Y = pos2Y + cos(SecondAngle) * longth - constrain(pos2Y - height / 2, -Width / gen * hosei, Width/ gen * hosei);
  float dia = Width / gen;
  //stroke(255,255,0);
  bezier(pos1X, pos1Y, pos2X, pos2Y, pos3X, pos3Y, pos4X, pos4Y);
  //bezier(pos1X, pos1Y - dia, pos2X, pos2Y - dia, pos3X, pos3Y - Width/nextgen, pos4X, pos4Y - Width/nextgen);
  /*strokeWeight(3);
  point(pos1X, pos1Y);
  point(pos2X, pos2Y);
  point(pos3X, pos3Y);
  strokeWeight(6);
  point(pos4X, pos4Y);
  strokeWeight(1);
  line(pos1X, pos1Y, pos3X, pos3Y);*/
  if (generation < repetition){
    float Angle1 = atan2(pos4X - pos3X, pos4Y - pos3Y);
    float nextpos2X = pos4X + sin(Angle1) * nextlongth;
    float nextpos2Y = pos4Y + cos(Angle1) * nextlongth;
    float Angle2 = atan2(pos4X - pos1X, pos4Y - pos1Y);
    float branchnextpos2X = pos2X + (sin(Angle) * nextlongth) * 1;
    float branchnextpos2Y = pos2Y + (cos(Angle) * nextlongth * 1);
    float branchposX = pos2X + (sin(Angle2) * nextlongth) * 2;
    float branchposY = pos2Y + (cos(Angle2) * nextlongth) * 2 + longth / 100 * ((random(-Random * 5, Random * 5) / gen) - constrain(pos4Y - height / 2, -Width / gen * hosei, Width/ gen * hosei));
    eda(pos4X, pos4Y, nextpos2X, nextpos2Y,generation + 1, Stroke_W * StrokeChange);
    edabranch(pos2X, pos2Y, branchnextpos2X, branchnextpos2Y, branchposX, branchposY, generation + 1, Stroke_W * StrokeChange);
  }
}

void edabranch(float pos1X, float pos1Y, float pos2X, float pos2Y, float TargetposX, float TargetposY, int generation, float Stroke_W){
  strokeWeight(Stroke_W);
  stroke(200);
  float gen = (1 + generation * decay);
  float nextgen = (1 + (generation + 1) * decay);
  float Angle = atan2(pos2X - pos1X, pos2Y - pos1Y);
  float longth = Longth / gen;
  float nextlongth = Longth / nextgen;
  pos2X = sin(Angle) * longth + pos1X;
  pos2Y = cos(Angle) * longth + pos1Y;
  noFill();
  float dia = Width / gen;
  bezier(pos1X, pos1Y, pos2X, pos2Y, pos2X, pos2Y, TargetposX, TargetposY);
  //bezier(pos1X, pos1Y - dia, pos2X, pos2Y - dia, pos2X, pos2Y - Width/nextgen, TargetposX, TargetposY - Width/nextgen);
  /*strokeWeight(3);
  stroke(255,100,100);
  point(pos1X, pos1Y);
  stroke(100,255,100);
  point(pos2X, pos2Y);
  //point(pos3X, pos3Y);
  strokeWeight(6);
  stroke(100,200,255);
  point(TargetposX, TargetposY);
  strokeWeight(1);
  line(pos1X, pos1Y, TargetposX, TargetposY);
  strokeWeight(6);
  stroke(255,255,100);
  point(nexttargetposX, nexttargetposY);*/
  float nextAngle = atan2(TargetposX - pos2X, TargetposY - pos2Y);
  float nexttargetposX = TargetposX + sin(nextAngle) * nextlongth;
  float nexttargetposY = TargetposY + cos(nextAngle) * nextlongth;
  eda(TargetposX, TargetposY,nexttargetposX, nexttargetposY, generation + 1, Stroke_W * StrokeChange);
}

void edasetup(){
  for(int i = 0;i < 1000;i++){
    edata[i][0] = random(-Random, Random);
    edata[i][1] = random(-Random, Random);//edanomagariguai
    edata[i][2] = random(-Random * 3, Random * 3);//edanohirakiguai
  }
}

void mousePressed(){
  if(nowinputProgress == 2){
    nowinputProgress = 0;
  }
  if(nowinputProgress <= 1){
    PositionData[nowinputProgress][0] = mouseX;
    PositionData[nowinputProgress][1] = mouseY;
    nowinputProgress++;
  }
  background(0);
  stroke(255);
  strokeWeight(2);
  if(nowinputProgress == 2){
    //line(PositionData[0][0], PositionData[0][1], PositionData[1][0], PositionData[1][1]);  
    eda(PositionData[0][0], PositionData[0][1], PositionData[1][0], PositionData[1][1], 0, StrokeW);
  }
}