ArrayList<Float> xPoints,yPoints;
ArrayList<Boolean> press;
ArrayList<float[]> func1 = null,func2 = null;
float count = 0;
ArrayList<float[]> points = null;
void setup(){
  frameRate(144);
  size(1280,720);
  xPoints = new ArrayList<>();
  yPoints = new ArrayList<>();
  press = new ArrayList<>();
  points = new ArrayList<>();
  background(0);
}
void draw(){
  strokeWeight(1);
  stroke(255);
  if (func1==null){
    if (!(mouseButton!=LEFT && xPoints.size()==0)){
      xPoints.add((float)mouseX-width/2);
      yPoints.add((float)mouseY-height/2);
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
    float[] prev1 = new float[] {width/2f,50};
    noFill();
    for (float[] i : func1){
      circle(prev1[0],prev1[1],i[0]*2f);
      float[] point = getPoint(i,count);
      line(prev1[0],prev1[1],prev1[0]+point[0],prev1[1]+point[1]);
      prev1[0] += point[0];
      prev1[1] += point[1];
    }
    float[] prev2 = new float[] {50,height/2f};
    for (float[] i : func2){
      circle(prev2[0],prev2[1],i[0]*2f);
      float[] point = getPoint(i,count);
      line(prev2[0],prev2[1],prev2[0]+point[1],prev2[1]+point[0]);
      prev2[0] += point[1];
      prev2[1] += point[0];
    }
    line(prev1[0],prev1[1],prev1[0],prev2[1]);
    line(prev2[0],prev2[1],prev1[0],prev2[1]); 
    if (points.size()>1){
      for(int i=0;i<points.size()-1;i++){
        float[] point1 = points.get(i);
        float[] point2 = points.get(i+1);
        if (press.get((int)(point1[0]%press.size()))){
          line(point1[1],point1[2],point2[1],point2[2]);
        }
      }
    }
    points.add(new float[] {count,prev1[0],prev2[1]});
    count += 1;
  }
}

void keyPressed(){
  if (key==' ' && func1==null){
    xPoints.add(xPoints.get(0));
    yPoints.add(yPoints.get(0));
    press.add(false);
    println(xPoints.size());
    func1 = getProperties(xPoints,xPoints.size());
    func2 = getProperties(yPoints,yPoints.size());
    println("calculated");
    background(0);
    count = 0;
  }
}
