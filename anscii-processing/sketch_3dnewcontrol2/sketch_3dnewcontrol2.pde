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
int[] offs = {115, 65, 75, 55, 105, 115, 130, 80, 125, 65, 20, 65, 55, 140, 130, 130};
int[] s = new int[16];
int[] a = new int[16];
int delayT = 1000;

void setup(){
  size(1081, 631, P3D);
  cam = new PeasyCam(this, 0, 0, 0, 500);
  
  port = new Serial(this, "COM11", 9600);
  port.bufferUntil('\n');
}

void draw(){ 
  background(255);
  fill(#00F9FF);
  
  stand();
  twist();
  sideStretch();
  twerk();  
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
  port.write('B');
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

void stand(){
  for(int i = 0; i < 4; i++){
    s[4*i+1] = int(-85);
    s[4*i+2] = int(100);
    s[4*i+3] = int(80);
  }
  servoWrite(s);
  delay(delayT);
  for(int i = 0; i < 4; i++){
    s[4*i+1] = int(-55);
    s[4*i+2] = int(110);
    s[4*i+3] = int(35);
  }
  servoWrite(s);
  delay(delayT);
    for(int i = 0; i < 4; i++){
    s[4*i+1] = int(0);
    s[4*i+2] = int(80);
    s[4*i+3] = int(10);
  }
  servoWrite(s);
  delay(delayT);
  for(int i = 0; i < 4; i++){
    s[4*i+1] = int(35);
    s[4*i+2] = int(35);
    s[4*i+3] = int(20);
  }
  servoWrite(s);
  delay(delayT);
  for(int i = 0; i < 4; i++){
    s[4*i+1] = int(-55);
    s[4*i+2] = int(110);
    s[4*i+3] = int(35);
  }
  servoWrite(s);
  delay(delayT+500);
}

void twist(){
  for(int i = 0; i < 4; i++){
    s[4*i+1] = int(-55);
    s[4*i+2] = int(110);
    s[4*i+3] = int(35);
  }
  servoWrite(s);
  delay(delayT);
  for(int i = 0; i < 4; i++){
    s[4*i] = 60;
  }
  servoWrite(s);
  delay(delayT);
  for(int i = 0; i < 4; i++){
    s[4*i] = 0;
  }
  servoWrite(s);
  delay(delayT);
  for(int i = 0; i < 4; i++){
    s[4*i] = -60;
  }
  servoWrite(s);
  delay(delayT);
  for(int i = 0; i < 4; i++){
    s[4*i] = 0;
  }
  servoWrite(s);
  delay(delayT);
  
  for(int i = 0; i < 4; i++){
    s[4*i+1] = int(-1);
    s[4*i+2] = int(80);
    s[4*i+3] = int(10);
  }
  servoWrite(s);
  delay(delayT);
  for(int i = 0; i < 4; i++){
    s[4*i] = 60;
  }
  servoWrite(s);
  delay(delayT);
  for(int i = 0; i < 4; i++){
    s[4*i] = 0;
  }
  servoWrite(s);
  delay(delayT);
  for(int i = 0; i < 4; i++){
    s[4*i] = -60;
  }
  servoWrite(s);
  delay(delayT);
  for(int i = 0; i < 4; i++){
    s[4*i] = 0;
  }
  servoWrite(s);
  delay(delayT);
}

void sideStretch(){
  for(int i = 0; i < 4; i++){
    s[4*i+1] = int(-55);
    s[4*i+2] = int(110);
  }
  
  s[0] = -50;
  s[4] = 50;
  s[8] = -50;
  s[12] = 50;
  servoWrite(s);
  delay(delayT);
  
  s[3] = 0;
  s[15] = 80;
  s[7] = 0;
  s[11] = 80;
  servoWrite(s);
  delay(delayT);
  
  s[3] = 35;
  s[15] = 35;
  s[7] = 35;
  s[11] = 35;
  servoWrite(s);
  delay(delayT);
  
  s[3] = 80;
  s[15] = 0;
  s[7] = 80;
  s[11] = 0;
  servoWrite(s);
  delay(delayT);
  
  s[3] = 35;
  s[15] = 35;
  s[7] = 35;
  s[11] = 35;
  servoWrite(s);
  delay(delayT);
  
  s[0] = 0;
  s[4] = 0;
  s[8] = 0;
  s[12] = 0;
  servoWrite(s);
  delay(delayT);
}

void twerk(){
  for(int i = 0; i <= 1; i++){
    s[4*i+1] = int(-80);
    s[4*i+2] = int(90);
    s[4*i+3] = int(80);
  }
  for(int i = 2; i <= 3; i++){
    s[4*i+1] = int(-30);
    s[4*i+2] = int(103);
    s[4*i+3] = int(17);
  }
  s[8] = 30;
  s[12] = -30;
  servoWrite(s);
  delay(delayT);
  s[8] = 0;
  s[12] = 0;
  for(int i = 0; i < 4; i++){
    s[4*i+1] = int(-55);
    s[4*i+2] = int(110);
    s[4*i+3] = int(35);
  }
  servoWrite(s);
  delay(delayT);
  
  for(int i = 0; i <= 1; i++){
    s[4*i+1] = int(-30);
    s[4*i+2] = int(103);
    s[4*i+3] = int(17);
  }
  for(int i = 2; i <= 3; i++){
    s[4*i+1] = int(-80);
    s[4*i+2] = int(90);
    s[4*i+3] = int(80);
  }
  s[0] = 30;
  s[4] = -30;
  servoWrite(s);
  delay(delayT);
  s[0] = 0;
  s[4] = 0;
  for(int i = 0; i < 4; i++){
    s[4*i+1] = int(-55);
    s[4*i+2] = int(110);
    s[4*i+3] = int(35);
  }
  servoWrite(s);
  delay(delayT);
}

void walk(){
  for(int i = 0; i < 4; i++){
    s[4*i+1] = int(-55);
    s[4*i+2] = int(110);
    s[4*i+3] = int(35);
  }
  
  s[4] = 30;
  s[8] = -30;
  servoWrite(s);
  delay(delayT);
  
  s[4] = 0;
  s[5] = -85;
  s[6] = 100;
  s[7] = 80;
  servoWrite(s);
  delay(600);
  
  s[5] = -55;
  s[6] = 110;
  s[7] = 35;
  servoWrite(s);
  delay(600);
  
  s[12] = 30;
  s[13] = -85;
  s[14] = 100;
  s[15] = 80;
  servoWrite(s);
  delay(600);
  
  s[13] = -55;
  s[14] = 110;
  s[15] = 35;
  servoWrite(s);
  delay(600);
  
  s[8] = 0;
  s[9] = -85;
  s[10] = 100;
  s[11] = 80;
  servoWrite(s);
  delay(600);
  
  s[9] = -55;
  s[10] = 110;
  s[11] = 35;
  servoWrite(s);
  delay(600);
  
  s[0] = -30;
  s[1] = -85;
  s[2] = 100;
  s[3] = 80;
  servoWrite(s);
  delay(600);
  
  s[1] = -55;
  s[2] = 110;
  s[3] = 35;
  servoWrite(s);
  delay(600);
  
  s[0] = 0;
  s[4] = 0;
  s[8] = 0;
  s[12] = 0;
}
