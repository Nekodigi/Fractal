int pow(int a, int b){
  int result = a;
  for(int i = 1; i < b; i++){
    result *= a;
  }
  return result;
}