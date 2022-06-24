float color1=0;
float color2=255;
float color1Change=1;
float color2Change=-1;
float x=50;
float y=50;
float vx=1;
float t=700;
float r=100;
float vt=0.5;
float vr=0.5;
int count=0;
float gravity=0.7;
float speedV=0;
float speedH=10;
float airfr=0.0001;
float fr=0.1;
int gameOn=0;
int YelBRate=20;
int lalaS=5;
int lalaI=1000;
float lastAT=0;
int minGH=200;
int maxGH=300;
int lalaW=80;
int maxP=500;
float P=500;
float downP=1;
int score=0;
ArrayList<int[]>lalas=new ArrayList<int[]>();
void setup(){
  size(800,600);
}
void draw(){
if(gameOn==0){level1();}
else if(gameOn==1){level2();}
else if(gameOn==2){gameOver();}
 }
void level2(){
  background(191,235,237);
  drawTR2();
  gravity();
  see();
  drawYellow();
  YellowB();
  speedH();
  lalaUp();
  lalaDown();
  drawP();
  scoreDis();
}
void drawP(){
  stroke(0);
  fill(255);
  rect(width/2+50,10,60,5);
  if(P>250){fill(15,180,85);}
  else if(P>100){fill(247,133,32);}
  else{fill(255,0,0);}
  rect(width/2+50,10,60*(P/maxP),5);
}
void downP(){
  P-=downP;
  if(P<=0){gameOver();}
}
void gameOver(){
  gameOn=2;
  background(0);
  fill(255);
  textSize(40);
  text("Game Over ^^",width/2-130,height/2);
}
void lalaCollision(int luo){
  int[]lala=lalas.get(luo);
  int sLalaX=lala[0];
  int sLalaY=lala[1];
  int sLalaW=lala[2];
  int sLalaH=lala[3];
  int lalaTX=sLalaX;
  int lalaTY=0;
  int lalaTW=sLalaW;
  int lalaTH=sLalaY;
  int lalaBX=sLalaX;
  int lalaBY=sLalaY+sLalaH;
  int lalaBW=sLalaW;
  int lalaBH=height-(sLalaY+sLalaH);
  int lalaScore=lala[4];
  if((t+15>lalaTX)&&(t<lalaTX+lalaTW)&&
  (r+40>lalaTY)&&(r<lalaTY+lalaTH)){
  downP();}
  if((t+15>lalaBX)&&(t<lalaBX+lalaBW)&&
  (r+40>lalaBY)&&(r<lalaBY+lalaBH)){
  downP();}
  if(t+15>sLalaX+(sLalaW/2)&&lalaScore==0){
  lalaScore=1;
  lala[4]=1;
  score();}
}
void score(){
  score++;
}
void scoreDis(){
  fill(0);
  textSize(15);
  text("Your score is",width/3-15,20);
  text(score,width/2-45,20);
  text("Lifeline",width/2-15,20);
}
void lalaUp(){
  if(millis()-lastAT>lalaI){
  int lalala=round(random(minGH,maxGH));
  int lalaY=round(random(0,height-lalala));
  int[] laLa={width,lalaY,lalaW,lalala,0};
  lalas.add(laLa);
  lastAT=millis();
}
}
void lalaDown(){
  for(int i=0;i<lalas.size();i++){
  lalaRemove(i);
  lalaMove(i);
  lalaDraw(i);
  lalaCollision(i);}
}
void lalaDraw(int luo){
  int[] la=lalas.get(luo);
  int sLalaX=la[0];
  int sLalaY=la[1];
  int sLalaW=la[2];
  int sLalaH=la[3];
  rectMode(CORNER);
  fill(37,44,206);
  stroke(0);
  ellipse(sLalaX,sLalaH/2+20,70,sLalaH-40);
  rect(sLalaX,sLalaH+sLalaH/2,sLalaW,height-(sLalaY)+200);  
  rect(sLalaX-20,sLalaH+sLalaH/2,10,10);
  rect(sLalaX+sLalaW+10,sLalaH+sLalaH/2,10,10);
  fill(255);
  ellipse(sLalaX-10,sLalaH/2,8,8);
  ellipse(sLalaX+10,sLalaH/2,8,8);
}
void lalaMove(int luo){
  int[]lala=lalas.get(luo);
  lala[0]-=lalaS;
}
void lalaRemove(int luo){
  int[]lala=lalas.get(luo);
  if(lala[0]+lala[2]<=0){
  lalas.remove(luo);}
}
void drawTR2(){
  fill(255,255,255);
  rect(t,r,15,40);
}
void drawYellow(){
  fill(250,255,10);
  stroke(0);
  rectMode(CENTER);
  rect(mouseX,mouseY,100,10);
}
void YellowB(){
  float ble=mouseY-pmouseY;
  if(t+15>mouseX-50&&t<mouseX+50){
  if(dist(t,r,t,mouseY)<=20+abs(ble)){
  BBottom(mouseY);
  speedH=(t-mouseX)/15;
  if(ble<0){
  r+=ble;
  speedV+=ble;}}}
}
void gravity(){
  speedV+=gravity;
  r+=speedV;
  speedV-=(speedV*airfr);
}
void speedH(){
  t+=speedH;
  speedH-=speedH*airfr;
}
void BBottom(int lala){
  r=lala-20;
  speedV*=-1;
  speedV-=speedV*fr;
}
void BTop(int lala){
  r=lala;
  speedV*=-1;
  speedV-=speedV*fr;
}
void BLeft(int lala){
  t=lala;
  speedH*=-1;
  speedH-=speedH*fr;
}
void BRight(int lala){
  t=lala-15;
  speedH*=-1;
  speedH-=speedH*fr;
}
void see(){
  if(r+20>height){BBottom(height);}
  if(r<0){BTop(0);}
  if(t<0){BLeft(0);}
  if(t+15>width){BRight(width);}
}
void level1(){
  background1();
  drawEmo();
  moveEmo();
  drawTR1();
  fill(0);
  textSize(15);
  text(count,125,450);
  text("Your count is = ",10,450);
  if(count>15){text("Mouse Activated",10,500);}
  if(dist(x,y,t+7,r+20)<15){gameOn=1;}
}
void background1(){
  fill(color1,0,color2);
  rect(-1,-1,width+1,200);
  fill(color2,0,color1);
  rect(-1,200,width+1,400);
  color1+=color1Change;
  color2+=color2Change;
  if(color1<0||color1>255){color1Change*=-1;}
  if(color2<0||color2>255){color2Change*=-1;}
  fill(0,255,0);
  rect(-1,400,width+1,600);
}
void drawEmo(){
  fill(103,207,237);
  ellipse(x,y,50,50);
  strokeWeight(2);
  line(x-10,y+5,x-20,y+5);
  line(x+10,y+5,x+20,y+5);
  ellipse(x,y+20,3,5);
}
void moveEmo(){
  x+=vx;
  if(x>width-25||x<25){vx=-vx;}
}
void drawTR1(){
  fill(255,255,255);
  rect(t,r,15,40,0,0,6,6);
  ellipse(t+7,r-2,18,10);
  ellipse(t+7,r-2,7,5);
  rect(t+16,r-2,8,40);
  t=t+vt;
  r=r+vr;
  if(t>800-30||t<580){vt=-vt; t=random(580,770);}
  if(r>155||r<15){vr=-vr; r=random(15,155);}
}
void keyPressed(){
if(key==CODED){if(keyCode==UP){y-=5;}else if(keyCode==DOWN){y+=5;}}
if(key==CODED){if(keyCode==LEFT){x-=5;}else if(keyCode==RIGHT){x+=5;}}
count++;
}
void mousePressed(){
  if(count>15){x=mouseX; y=mouseY;}
}
