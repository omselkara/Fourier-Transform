ArrayList<Complex> xPoints;
ArrayList<Boolean> press;
ArrayList<float[]> func1 = null;
float count = 0;
ArrayList<float[]> points = null;
void setup(){
  frameRate(1000);
  size(700,700,P3D);
  xPoints = new ArrayList<>();
  press = new ArrayList<>();
  points = new ArrayList<>();
  
}
void draw(){
  if (frameCount==1){
    background(0);
    String[] file = loadStrings("save.txt");
    for (String line : file){
      int x = Integer.parseInt(line.split(" ")[1])-width/2;
      int y = Integer.parseInt(line.split(" ")[0])-height/2;
      xPoints.add(new Complex(x,y));
      press.add(true);
    }
    xPoints.add(xPoints.get(0));
    press.add(false);
    println(xPoints.size());
    func1 = getProperties(xPoints,10000);
    //func2 = getProperties(yPoints,yPoints.size());
    println("calculated");
    background(0);
    count = 0;
  }
  strokeWeight(1);
  stroke(255);
  if (func1==null){
    if (!(mouseButton!=LEFT && xPoints.size()==0)){
      xPoints.add(new Complex((float)mouseX-width/2f,(float)mouseY-height/2f));
    }
    if (mouseButton==LEFT){
      line(pmouseX,pmouseY,mouseX,mouseY);
      if (xPoints.size()>0) press.add(true);
    }
    else{
      if (xPoints.size()>0) press.add(false);
    }
  }
  else{
    background(0);
    float[] prev1 = new float[] {width/2f,height/2f};
    noFill();
    if (count<xPoints.size()){
      println(count);
      for (float[] i : func1){
        //circle(prev1[0],prev1[1],i[0]*2f);
        float[] point = getPoint(i,count);
        line(prev1[0],prev1[1],prev1[0]+point[0],prev1[1]+point[1]);
        prev1[0] += point[0];
        prev1[1] += point[1];
      }
    }
    if (points.size()>1){
      for(int i=0;i<points.size()-1;i++){
        float[] point1 = points.get(i);
        float[] point2 = points.get(i+1);
        if (press.get((int)(point1[0]%press.size()))){
          line(point1[1],point1[2],point2[1],point2[2]);
        }
      }
    }
    points.add(new float[] {count,prev1[0],prev1[1]});
    count += 1;
  }
}

void keyPressed(){
  if (key==' ' && func1==null){
    xPoints.add(xPoints.get(0));
    press.add(false);
    println(xPoints.size());
    func1 = getProperties(xPoints,xPoints.size());
    //func2 = getProperties(yPoints,yPoints.size());
    println("calculated");
    background(0);
    count = 0;
  }
}
