class Complex{
  float realValue,complexValue;
  Complex(float realValue,float complexValue){
    this.realValue = realValue;
    this.complexValue = complexValue;
  }
  float length(){
    return sqrt((realValue*realValue+complexValue*complexValue));
  }
  
  Complex dot(Complex other){
    return new Complex(realValue*other.realValue-complexValue*other.complexValue,realValue*other.complexValue+complexValue*other.realValue);
  }
  
  void add(Complex other){
    realValue += other.realValue;
    complexValue += other.complexValue;
  }
}

Complex dft(ArrayList<Complex> points, int k){
  Complex value = new Complex(0,0);
  float w = 2f*PI*k/points.size();
  for (int n=0;n<points.size();n++){
    float x = w*n;
    Complex result = points.get(n).dot(new Complex(cos(x),-sin(x)));
    value.add(result);
  }
  return value;
}

ArrayList<float[]> getProperties(ArrayList<Complex> points, int K){
  ArrayList<float[]> funcs = new ArrayList<>();
  int k = 0;
  for (int i=0;i<K;i++){
    Complex value = dft(points,k);
    float amp = value.length();
    float phase = atan2(value.complexValue,value.realValue);
    float freq = k/(float)points.size();
    funcs.add(new float[] {amp/points.size(),2.0f*PI*freq,phase});
    k = -k + (k<=0 ? 1:0);
  }
  return funcs;
}

Function findFunc(ArrayList<Complex> points, int K){
  ArrayList<float[]> funcs = getProperties(points,K);
  return new Function(){
    @Override
    float call(float x){
      float value = 0;
      for (float[] i : funcs){
        value += i[0]*cos(i[1]*x+i[2]);
      }
      return value;
    }
  };
}

float[] getPoint(float[] i,float x){
  return new float[] {i[0]*cos(i[1]*x+i[2]),i[0]*sin(i[1]*x+i[2])};
}
