/* SHM in simple pendulum
-Sushovan Mandal
(http://www.tunyurl.com/sushovanmandal)
*/

import guicomponents.*;

//constants
final int headingSize = 20;
final float g = 9.8;

float displacementAngle;
float pendulumLength;
//current angle of pendulum
float currAngle;
//current x,y position
float currX,currY;
//current angular velocity and acceleration
//float omega,alfa;
float angle,frequency;
//keeping track of base and foot of pendulum's
//initial position
int baseX,baseY;
float footX,footY;

//variables for drawing the equation curves
float angleY,velY,accY;
float ex,angleE;
float py,frequencyE=4;
int radiusE;
float x;
//float errorYa,errorYv;


float accConst;

//for creating font
PFont myFont;

//for creating the sliders and buttons
GWSlider PLength, ADisplacement;
GButton apply;

void setup()
{
  frameRate(60);
  
  size(1200,600);
  background(255);
  smooth();
  
  //Font init
  myFont = createFont("verdana",12);
  textFont(myFont);
  
  //slider init
  PLength = new GWSlider(this,width-200-10,height-30-12,200);
  PLength.setValueType(GWSlider.DECIMAL);
  PLength.setLimits(3.0,2.0,4.0);
  PLength.setTickCount(4);
  PLength.setInertia(10);
  //PLength.setPrecision(2);
  
  ADisplacement = new GWSlider(this,width-200-10,height-75-24,200);
  ADisplacement.setValueType(GWSlider.DECIMAL);
  ADisplacement.setLimits(45.0,0.0,90.0);
  ADisplacement.setTickCount(18);
  ADisplacement.setPrecision(1);
  ADisplacement.setInertia(10);
  
  //button init
  G4P.setFont(this, "Verdana", 12);
  G4P.setColorScheme(this, GCScheme.GREY_SCHEME);
  apply = new GButton(this, "Apply the new values", width-10-187,height-150,175,30);
  
  //set the base location;
  baseX=width/2;
  baseY=50;
  
  footX = baseX + pendulumLength*cos(radians(90+displacementAngle));
  footY = baseY + pendulumLength*sin(radians(90+displacementAngle));
  
  //motion dynamics
  displacementAngle = -45;
  pendulumLength = 300;
  currAngle = displacementAngle;
  //alfa = (g*cos(radians(displacementAngle)))/( float )pendulumLength;
  //omega = 0;
  
  //speed of oscillation
  frequency = 2.3;
  
  radiusE=20;
}

void draw()
{
  
  background(255);
  
  //----------------------------------------------------------------------------
  //dynamics calculations
  
  //alfa = -(g*sin(radians(currAngle)))/pendulumLength;
  //omega = omega + alfa*tim;
  
  /*if(x == 90/(360/frequency))
  {
    println(velY);
    errorYa = radiusE - radiusE*cos(radians(angle));
    errorYv = radiusE*sin(radians(angle));
  }*/
  if(x>=90)
  {
    //println(cos(radians(angle)));
    x=0;
  }
    
  currAngle = 90 + displacementAngle*cos(radians(angle));
  
  currX = baseX + ( float )pendulumLength*cos(radians(currAngle));
  currY = baseY + ( float )pendulumLength*sin(radians(currAngle));
  
  //----------------------------------------------------------------------------
  //drawing the constant part
  line(baseX-20,baseY,baseX+20,baseY);
  line(baseX-20,baseY,baseX-12,baseY-4);
  line(baseX-12,baseY,baseX-4,baseY-4);
  line(baseX-4,baseY,baseX+4,baseY-4);
  line(baseX+4,baseY,baseX+12,baseY-4);
  line(baseX+12,baseY,baseX+20,baseY-4);
  
  footX = baseX+( float )pendulumLength*cos(radians(90+displacementAngle));
  footY = baseY+( float )pendulumLength*sin(radians(90+displacementAngle));
  
  line(baseX,baseY,footX,footY);
  
  pushMatrix();
  translate(footX,footY);
  rotate(radians(displacementAngle));
  //line(0,0,-16,0);
  line(0,0,16,0);
  popMatrix();
  
  //denoting the length and initial position
  //of the pendulum
  drawArrow(baseX+( float )(pendulumLength/2-15)*cos(radians(90+displacementAngle))+15,
  baseY+( float )(pendulumLength/2-15)*sin(radians(90+displacementAngle)) - 15*cos(radians(90+displacementAngle)),
  pendulumLength/2-20, -90+displacementAngle);
  drawArrow(baseX+( float )(pendulumLength/2+15)*cos(radians(90+displacementAngle))+15,
  baseY+( float )(pendulumLength/2+15)*sin(radians(90+displacementAngle)) - 15*cos(radians(90+displacementAngle)),
  pendulumLength/2-30, 90+displacementAngle);
  
  //drawing the mean position
  for(int i=0; i<pendulumLength+30; i=i+20)
  {
    line(baseX, baseY+i, baseX, baseY+i+10);
  }
  
  //drawing the equation depiction windows
  fill(0);
  rect(width/16,height/8+40,120,60);
  rect(width/16,height/8+185,120,60);
  rect(width/16,height/8+330,120,60);
  
  //drawing the euation curves'
  //axes
  
  stroke(255);
  line(width/16+15,height/8+45,width/16+15,height/8+95);
  line(width/16+15,height/8+190,width/16+15,height/8+240);
  line(width/16+15,height/8+335,width/16+15,height/8+385);
  
  line(width/16+15,height/8+70,width/16+105,height/8+70);
  line(width/16+15,height/8+215,width/16+105,height/8+215);
  line(width/16+15,height/8+360,width/16+105,height/8+360);
  
  
  //drawing the equation curves
  stroke(150);
  strokeWeight(2);
  
  angleE=0;
  py=0;
  for(int i=0; i<90; i++)
  {
    py = height/8+70 - cos(radians(angleE))*radiusE;
    point(width/16+15+i,py);
    angleE += frequencyE;
  }
  angleE=0;
  py=0;
  for(int i=0; i<90; i++)
  {
    py = height/8+215 + sin(radians(angleE))*radiusE;
    point(width/16+15+i,py);
    angleE += frequencyE;
  }
  angleE=0;
  py=0;
  for(int i=0; i<90; i++)
  {
    py = height/8+360 + cos(radians(angleE))*radiusE;
    point(width/16+15+i,py);
    angleE += frequencyE;
  }
  
  strokeWeight(1);
  
  
  //---------------------------------------------------------------------------
  //drawing the pendulum
  strokeWeight(4);
  stroke(200);
  line(baseX,baseY,currX,currY);
  strokeWeight(1);
  
  //drawing the dynamic bob
  stroke(0);
  fill(255,0,0);
  ellipse(currX,currY,20,20);
  
  //drawing ellipses keeping track on equations
  noStroke();
  fill(225);
  angleY = height/8+70 - radiusE*cos(radians(angle)); //- errorYa;
  ellipse(width/16+15+x, angleY, 5, 5);
  velY = height/8+215 - radiusE*sin(radians(angle)); //+ errorYv;
  ellipse(width/16+15+x, velY, 5, 5);
  accY = height/8+360 + radiusE*cos(radians(angle)); //+ errorYa;
  ellipse(width/16+15+x, accY, 5, 5);
  
  //---------------------------------------------------------------------------
  //the angle
  angle -= frequency;
  x+= 90/(360/frequency);
  
  /*
  if(width/16+15+x >= width/16+105)
  {
    angle=0;
    x=0;
  }*/
  
  //----------------------------------------------------------------------------
  //text outputs
  stroke(0);
  fill(0);
  
  textFont(myFont);
  textAlign(LEFT);
  text(pendulumLength/100+" metres", baseX+( float )(pendulumLength/2+5)*cos(radians(90+displacementAngle))+15,
  baseY+( float )(pendulumLength/2+5)*sin(radians(90+displacementAngle)) - 20*cos(radians(90+displacementAngle)));
  text("Starting position\nof the pendulum", footX+5, footY+20);
  
  //writing the equations
  textSize(16);
  text("θ",width/16,height/8);
  text("ω",width/16,height/8+125);
  text("α",width/16,height/8+265);
  textSize(10);
  text("instantaneous",width/16+12,height/8);
  text("instantaneous",width/16+12,height/8+125);
  text("instantaneous",width/16+12,height/8+265);
  textSize(12);
  text("= θcos[{√(g/L)}t]",width/16,height/8+20);
  text("= d/dt[θcos[{√(g/L)}t]",width/16,height/8+145);
  text("= -θ√(g/L)sin[{√(g/L)}t]",width/16,height/8+165);
  text("= d/dt[-θ√(g/L)sin[{√(g/L)}t]",width/16,height/8+285);
  text("= -(θg/L)cos[{√(g/L)}t] = -θ",width/16,height/8+305);
  textSize(8);
  text("instantaneous",width/16+180,height/8+305);
  
  //the details
  textSize(12);
  text("θ = maximum angular \ndisplacement of the \npendulum \n= "+(-displacementAngle),width-190,height/8);
  text("Time period of oscillation \nfor pendulum, T \n= 2π√(g/L)\n= "+2*PI*sqrt(g/pendulumLength)+" s",width-190,height/8+100);
  text("Frequency of pendulum \n= 1/T = (1/2π)√(L/g)\n= "+(1/(2*PI))*sqrt(pendulumLength/g)+" Hz",width-190, height/8+200);
  text("Thus, the longer the \npendulum, greater the time\ntaken by the pendulum to\ncomplete one oscillation",width-190,height/8+280);
  
  textAlign(CENTER);
  
  textSize(12);
  text("Irrespective of the maximum angular displacement for a given length,\nthe time taken for one oscillation is constant",baseX,height-90);
  text("Mean Position",baseX,baseY+pendulumLength+45);
  textFont(createFont("verdana",14));
  text("Motion Characteristics of this simulation is proportional to real-time motion characteristics",baseX,height-20);
  textFont(myFont);
  textSize(16);
  text("θ",baseX+25*cos(radians(90+displacementAngle)),baseY+60*cos(radians(90+displacementAngle)));
  
  //set slider labels
  textSize(12);
  text("Length of Pendulum (in metre)",width-10-100,height-4);
  text("Maximum Displacement Angle (in degree)",width-10-100,height-50-8);
  //text(tim+"\n"+count+"\n"+alfa*100,width/2,height/2);
  //text(currX+" "+currY+" "+accConst,width/2,height/2);
  
  
  //set heading
  //textSize(headingSize);
  textFont(createFont("Cambria",headingSize));
  text("Simple Pendulum", width/2, headingSize+5);
}

void drawArrow(float cx, float cy, float len, float angle){
  pushMatrix();
  translate(cx, cy);
  rotate(radians(angle));
  line(0,0,len, 0);
  if(len>0)
  {
    line(len, 0, len - 8, -8);
    line(len, 0, len - 8, 8);
  }
  else
  {
    line(len, 0, len + 8, -8);
    line(len, 0, len + 8, 8);
  }
  popMatrix();
}

void handleSliderEvents(GSlider slider)
{}

void handleButtonEvents(GButton button)
{
  switch(button.eventType)
  {
      case GButton.CLICKED:
        println(PLength.getValuef());
        pendulumLength = PLength.getValuef()*100;
        frequency = 2 + (4-PLength.getValuef());
        println(ADisplacement.getValuef());
        displacementAngle = -ADisplacement.getValuef();
        currAngle = displacementAngle;
        angle = 0;
        x=0;
        break;
      default:
        println("Unrecognized event");
  }
}
