import processing.serial.*;
import peasy.*;

PeasyCam cam;
Serial port;
float l1 = 82.5;
float l2 = 96;
float l3 = 85;
float bodyX = 8;
float a1, a2, a3, x, y, step = 0;
float j = -60;
boolean tok = true;
int[] offs = {115, 65, 70, 55, 105, 115, 145, 80, 125, 65, 20, 65, 55, 140, 130, 130};
int[] s = new int[16];
int[] a = new int[16];

void setup(){
  size(1081, 631, P3D);
  cam = new PeasyCam(this, 0, 0, 0, 500);
  
  port = new Serial(this, "COM11", 9600);
  port.bufferUntil('\n');
}

void draw(){ 
  background(255);
  fill(#00F9FF);
  ortho();

  float x = mouseX-width/2;
  float y = mouseY-height/2;
  
  float phi = HALF_PI;
  
  float p2x = x - l3*cos(phi);
  float p2y = y - l3*sin(phi);

  float c2 = (sq(p2x) + sq(p2y) - sq(l1) - sq(l2)) / (2*l1*l2);
  float s2 = sqrt(1 - sq(c2));
  a2 = atan2(s2, c2);
  
  float c1 = (p2x*(l1+l2*cos(a2)) + l2*sin(a2)*p2y) / (sq(l1)+sq(l2)+2*l1*l2*cos(a2));
  float s1 = (p2y*(l1+l2*cos(a2)) - l2*sin(a2)*p2x) / (sq(l1)+sq(l2)+2*l1*l2*cos(a2));
  a1 = atan2(s1, c1);

  a3 = phi - a1 - a2;
  
  /*if(tok){
    step += 0.08;}
  else{
    step -= 0.08;}
    
  if(step > 1){
  tok = false;
  delay(1000);
  }
  if(step < 0){
    tok = true;
    delay(1000);
  }*/
  
  box(bodyX*10*2, 10, bodyX*10*2);
  pushMatrix();
  translate(bodyX*10, 0, -bodyX*10);
  rotateY(PI/4);
  sphere(15);
  drawLine(0,0,0,l1*cos(a1), l1*sin(a1),0);
  translate(l1*cos(a1), l1*sin(a1),0);
  sphere(15);
  drawLine(0,0,0,l2*cos(a1+a2), l2*sin(a1+a2),0);
  translate(l2*cos(a1+a2), l2*sin(a1+a2));
  sphere(15);
  drawLine(0,0,0,l3*cos(a1+a2+a3), l3*sin(a1+a2+a3),0);
  translate(l3*cos(a1+a2+a3), l3*sin(a1+a2+a3));
  sphere(15);
  popMatrix();
  
  pushMatrix();
  translate(bodyX*10, 0, bodyX*10);
  rotateY(-PI/4);
  sphere(15);
  drawLine(0,0,0,l1*cos(a1), l1*sin(a1),0);
  translate(l1*cos(a1), l1*sin(a1),0);
  sphere(15);
  drawLine(0,0,0,l2*cos(a1+a2), l2*sin(a1+a2),0);
  translate(l2*cos(a1+a2), l2*sin(a1+a2));
  sphere(15);
  drawLine(0,0,0,l3*cos(a1+a2+a3), l3*sin(a1+a2+a3),0);
  translate(l3*cos(a1+a2+a3), l3*sin(a1+a2+a3));
  sphere(15);
  popMatrix();
  
  scale(-1,1,1);
  
  pushMatrix();
  translate(bodyX*10, 0, bodyX*10);
  rotateY(-PI/4);
  sphere(15);
  drawLine(0,0,0,l1*cos(a1), l1*sin(a1),0);
  translate(l1*cos(a1), l1*sin(a1),0);
  sphere(15);
  drawLine(0,0,0,l2*cos(a1+a2), l2*sin(a1+a2),0);
  translate(l2*cos(a1+a2), l2*sin(a1+a2));
  sphere(15);
  drawLine(0,0,0,l3*cos(a1+a2+a3), l3*sin(a1+a2+a3),0);
  translate(l3*cos(a1+a2+a3), l3*sin(a1+a2+a3));
  sphere(15);
  popMatrix();
  
  pushMatrix();
  translate(bodyX*10, 0, -bodyX*10);
  rotateY(PI/4);
  sphere(15);
  drawLine(0,0,0,l1*cos(a1), l1*sin(a1),0);
  translate(l1*cos(a1), l1*sin(a1),0);
  sphere(15);
  drawLine(0,0,0,l2*cos(a1+a2), l2*sin(a1+a2),0);
  translate(l2*cos(a1+a2), l2*sin(a1+a2));
  sphere(15);
  drawLine(0,0,0,l3*cos(a1+a2+a3), l3*sin(a1+a2+a3),0);
  translate(l3*cos(a1+a2+a3), l3*sin(a1+a2+a3));
  sphere(15);
  popMatrix();
  
  for(int i = 0; i < 4; i++){
    s[4*i+1] = int(degrees(a1));
    s[4*i+2] = int(degrees(a2));
    s[4*i+3] = int(degrees(a3));
  }
  servoWrite(s);
  println(degrees(a1), degrees(a2), degrees(a3));
}

void serialEvent(Serial port){
    String a = port.readStringUntil('\n');
    println(a);
}

void servoWrite(int[] sa){
  for(int i = 0; i < 4; i++){
    a[4*i] = int(offs[4*i]+sa[4*i]);
  }
  for(int i = 0; i <= 1; i++){
    a[8*i+1] = int(offs[8*i+1]-sa[8*i+1]);
    a[8*i+2] = int(offs[8*i+2]+sa[8*i+2]);
    a[8*i+3] = int(offs[8*i+3]+sa[8*i+3]);
  }
  for(int i = 0; i <= 1; i++){
    a[8*i+5] = int(offs[8*i+5]+sa[8*i+5]);
    a[8*i+6] = int(offs[8*i+6]-sa[8*i+6]);
    a[8*i+7] = int(offs[8*i+7]-sa[8*i+7]);
  }
  port.write('A');
  port.write(' ');
  for(int i = 0; i < 16; i++){
    port.write(str(a[i]));
    port.write(' ');
  }
  port.write('x');
  delay(10);
}

void drawLine(float x1, float y1, float z1, 
  float x2, float y2, float z2)
{
  float weight = 5;
  color strokeColour = 0;
  PVector p1 = new PVector(x1, y1, z1);
  PVector p2 = new PVector(x2, y2, z2);
  PVector v1 = new PVector(x2-x1, y2-y1, z2-z1);
  float rho = sqrt(pow(v1.x, 2)+pow(v1.y, 2)+pow(v1.z, 2));
  float phi = acos(v1.z/rho);
  float the = atan2(v1.y, v1.x);
  v1.mult(0.5);

  pushMatrix();
  translate(x1, y1, z1);
  translate(v1.x, v1.y, v1.z);
  rotateZ(the);
  rotateY(phi);
  noStroke();
  fill(strokeColour);
  // box(weight,weight,p1.dist(p2)*1.2);
  box(weight, weight, p1.dist(p2)*1.0);
  fill(#00F9FF);
  popMatrix();
}
