//generate coeffitients from answers. it's just like expansion of formula.
Complex[] coeffsFromAns(Complex ... answers){
  Complex[] coeffs = new Complex[2];
  coeffs[0] = answers[0].mult(-1);
  coeffs[1] = c(1, 0);
  for(int i=1; i<answers.length; i++){
    Complex[] f = {answers[i].mult(-1), r(1)};
    coeffs = formulaMult(coeffs, f);
  }
  return coeffs;
}

//Multiplication of formula
Complex[] formulaMult(Complex[] f1, Complex[] f2){
  Complex[] result = new Complex[f1.length+f2.length-1];
  for(int i=0; i<=f1.length-1+f2.length-1; i++){
    result[i] = c(0, 0);
    println(i, max(i-(f2.length-1), 0), min(i, f1.length-1));
    for(int j=max(i-(f2.length-1), 0); j<=min(i, f1.length-1); j++){
      result[i] = result[i].add(f1[j].mult(f2[i-j]));
    }
  }
  return result;
}

//Calculate differential from coeffients
Complex[] differential(Complex ... coeffs){
  Complex[] result = new Complex[coeffs.length-1];
  for(int i=1; i<coeffs.length; i++){
    result[i-1] = coeffs[i].mult(i);
  }
  return result;
}

//calculate f(z) from z, coefficients
Complex f(Complex z, Complex ... coeffs){//coefficents are this order a + bz + cz^2
  Complex result = new Complex(0, 0);
  for(int i=0; i<coeffs.length; i++){
    Complex temp = coeffs[i];
    for(int j=0; j<i; j++){
      temp = temp.mult(z);
    }
    result = result.add(temp);
  }
  return result;
}
