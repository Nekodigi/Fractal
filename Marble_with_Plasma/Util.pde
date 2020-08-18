void writeMap(){
  pg.noStroke();
  for(int i = 0; i < n; i++){
    for(int j = 0; j < n; j++){
      pg.fill(map[i][j]*360);
      pg.rect(float(i)*pSize, float(j)*pSize, pSize, pSize);
    }
  }
}
