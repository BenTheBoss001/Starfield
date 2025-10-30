Particle[] particles = new Particle[150];
Orb orby = new Orb(300,300);
int timer = 0;
int index = 100;
float orbX = 300;
float orbY = 300;
float angle;
float mX;
float mY;
void setup(){
  size(600,600);
  particles[0] = new Orb(300,300);
  for (int i = 1; i <= index; i++){
    particles[i] = new Particle(orbX,orbY);
  }
}
void draw(){
  //System.out.println(orby.wander);
  fill(0,0,0,30);
  rect(0,0,600,600);
  timer ++;
  orby.move();
  orby.show();
  if (index >= 149){
    index = 100;
  }
  if (timer >= 10){
    index+=1;
    timer = 0;
    particles[index] = new Particle(orbX,orbY);
  }
  
  for (int i = 0; i <= index; i++){
    particles[i].show();
    particles[i].move();
  }
}




class Particle{
  float myX, myY, mySize;
  double mySpeed, myAngle;
  Particle(){}
  Particle(float x, float y){
    myAngle = Math.random()*(2*Math.PI);
    myX = x+(int)(Math.cos(myAngle)*50);
    myY = y+(int)(Math.sin(myAngle)*50);
    mySize = 5;
    mySpeed = (Math.random()*3+3);
    
  }
  void show(){
    noStroke();
    fill(255);
    ellipse(myX, myY, (float)mySize, (float)mySize);
  }
  void move(){
    myX += Math.cos(myAngle)*mySpeed;
    myY += Math.sin(myAngle)*mySpeed;
    if (myX > 700 || myX < -100 || myY > 700 || myY < -100){
      myAngle = Math.random()*(2*Math.PI);
      myX = orbX+(float)(Math.cos(myAngle)*50);
      myY = orbY+(float)(Math.sin(myAngle)*50);
    }
  }
}

class Orb extends Particle{
  boolean wander = true;
  Orb(float x, float y){
    orbX = x;
    orbY = y;
    mySize = 65;
    mySpeed = 3;
  }
  void show(){
    fill(255);
    ellipse(orbX, orbY, mySize, mySize);
  }
  void move(){
    if (wander == true){
      orbX += (float)(Math.random()*10-5);
      orbY += (float)(Math.random()*10-5);
    }else if(wander == false) {
      if (orbX < mX + 30 && orbX > mX - 30 && orbY < mY + 30 && orbY > mY - 30){
        wander = true;
      } else {
        wander = false;
        orbX += (float)(Math.cos(angle)*mySpeed);
        orbY -= (float)(Math.sin(angle)*mySpeed);
      }
    }
  }
  void moveToMouse(){
    wander = false;
  }
}

void mousePressed(){
  //orbX = mouseX;
  //orbY = mouseY;
  pushMatrix();
  translate(orbX,orbY);
  angle = atan2(mouseX-orbX, mouseY-orbY);
  angle -= PI/2;
  if (angle < 0){
    angle = 2*PI - abs(angle);
  }
  popMatrix();
  mX = mouseX;
  mY = mouseY;
  //System.out.println("Orb: " + orbX + "," + orbY); 
  //System.out.println("Mouse: " + mouseX + "," + mouseY);
  //System.out.println(degrees(angle));
  orby.moveToMouse();
  
}
