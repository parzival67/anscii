import processing.serial.*;
import peasy.*;

PeasyCam cam;
Serial port;
float l1 = 82.5;
float l2 = 96;
float l3 = 85;

float bodyX = 8;

void setup(){
  size(1081, 631, P3D);
  cam = new PeasyCam(this, 0, 0, 0, 500);
}

void draw(){ 
  background(255);
  fill(#00F9FF);
  //lights();
  ortho();
  
  float x = mouseX-width/2;
  float y = mouseY-height/2;
  
  float phi = HALF_PI;
  
  float p2x = x - l3*cos(phi);
  float p2y = y - l3*sin(phi);

  float c2 = (sq(p2x) + sq(p2y) - sq(l1) - sq(l2)) / (2*l1*l2);
  float s2 = sqrt(1 - sq(c2));
  float a2 = atan2(s2, c2);
  
  float c1 = (p2x*(l1+l2*cos(a2)) + l2*sin(a2)*p2y) / (sq(l1)+sq(l2)+2*l1*l2*cos(a2));
  float s1 = (p2y*(l1+l2*cos(a2)) - l2*sin(a2)*p2x) / (sq(l1)+sq(l2)+2*l1*l2*cos(a2));
  float a1 = atan2(s1, c1);

  float a3 = phi - a1 - a2;
  
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
