void showMap(){
  for(int i = 0; i < n; i++){
    for(int j = 0; j < n; j++){
      fill(map[i][j]*360, 100, 100);
      rect(float(i)*pSize, float(j)*pSize, pSize, pSize);
    }
  }
}