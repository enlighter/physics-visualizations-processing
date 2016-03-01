/* 
Simple harmonic motion
Sine Curve follower
- Sushovan Mandal
 (http://www.tinyurl.com/sushovanmandal)
 */
 
float angleS=0,angle=0;
float pxS=0,pyS=0,px=0,py=0;
float radius=100;
float frequency=2;
float frequencyS=2;
float y=0, velVL=0, accVL=0;
float SpringUnitWidth=25;
float topPart = 0;
//spring stifness constant k
//and mass of bob
float k=0, mass=0; 
 
//for creating font
PFont myFont;

void setup()
{
  size(675,620);
  background(127);
  smooth();
  myFont = createFont("verdana",12);
  textFont(myFont);
  
  topPart= (height-20)/3;
  y=topPart/2;
  
  k=mass=1;
}


void draw()
{
  background(127);
  
  //------------------------------------------------------------------------------
  //creating the mean line for object motion
  stroke(255);
  line(0,topPart/2,width-1,topPart/2);
  
  //draw the axis for the velocity curve
  line(0, 1.5*topPart, width, 1.5*topPart);
  
  //draw the axis for the acceleration curve
  line(0, 2.5*topPart,width, 2.5*topPart);
  
  //------------------------------------------------------------------------------
  //calculating y
  y = topPart/2 + sin(radians(angle))*(radius/2);
  
  //calculating velocity vector length
  velVL = cos(radians(angle))*(radius/2);
  
  //calculating the acceleration vector length
  //accVL = - (sin(radians(angle))*(radius/2));
  accVL = -(topPart/2 - y);
  
  //-------------------------------------------------------------------------------
  //drawing a static component
  stroke(220);
  line((width/8)-15, topPart/12, (width/8+15), topPart/12);
  
  //drawing the oscillating spring
  noFill();
  SpringUnitWidth = (y-10-topPart/12)/5;
  for(int i=0; i<5; i++)
  {
    beginShape();
    curveVertex(width/8+12, topPart/12 + i*SpringUnitWidth);
    curveVertex(width/8+12, topPart/12 + i*SpringUnitWidth);
    curveVertex(width/8+8, topPart/12 + i*SpringUnitWidth + SpringUnitWidth/2);
    curveVertex(width/8-4, topPart/12 + i*SpringUnitWidth + (4*SpringUnitWidth)/5);
    curveVertex(width/8-12, topPart/12 + i*SpringUnitWidth + SpringUnitWidth/2);
    curveVertex(width/8-4, topPart/12 + i*SpringUnitWidth + SpringUnitWidth/5);
    curveVertex(width/8+8, topPart/12 + i*SpringUnitWidth + SpringUnitWidth/2);
    curveVertex(width/8+12, topPart/12 + (i+1)*SpringUnitWidth);
    curveVertex(width/8+12, topPart/12 + (i+1)*SpringUnitWidth);
    endShape();
  }
  
  //denote the spring stiffness constant
  text("k", width/8 + 20, topPart/12 + 2.5*SpringUnitWidth);
  
  //drawing the oscilatting object
  noStroke();
  fill(200);
  ellipse(width/8, y, 30, 30);
  
  //denote the mass of the object
  text("m", width/8 + 23, y);
  
  //draw the velocity circle
  stroke(160);
  noFill();
  ellipse(width/8, 1.5*topPart, radius, radius);
  line(width/8, (1.5*topPart)-radius/2, width/8, (1.5*topPart)+radius/2);
  
  //-------------------------------------------------------------------------------
  //denote the maximum value of displacement
  stroke(0);
  drawArrow( (width/8)-(radius/2), topPart/2, radius/2, -90);
  line( (width/8)-(radius/2)-8, topPart/2 - radius/2, (width/8)-(radius/2)+8, topPart/2 - radius/2);
  
  //denote the maximum value of velocity
  stroke(0);
  drawArrow( (width/8)-(radius/2), 1.5*topPart, radius/2, -90);
  line( (width/8)-(radius/2)-8, 1.5*topPart - radius/2, (width/8)-(radius/2)+8, 1.5*topPart - radius/2);
  
  //denote the maximum value of acceleration
  stroke(0);
  drawArrow( (width/8)-(radius/2), 2.5*topPart, radius/2, -90);
  line( (width/8)-(radius/2)-8, 2.5*topPart - radius/2, (width/8)-(radius/2)+8, 2.5*topPart - radius/2);
  
  //-------------------------------------------------------------------------------
  // draw static curve - y = sin(x)
  angleS=0;
  stroke(190);
  strokeWeight(2);
  for (int i = 0; i< width; i++){
    pxS = width/8 + cos(radians(angleS))*(radius/2);
    pyS = topPart/2 + sin(radians(angleS))*(radius/2);
    point(width/8+radius/2+i, pyS);
    angleS -= frequencyS;
  }
  
  
  //draw static curve for velocity - dy/dt = cos(x)
  //[phase shifted by 90]
  angleS=0;
  for (int i = 0; i< width; i++){
    pxS = width/8 + sin(radians(angleS))*(radius/2);
    pyS = (3*topPart)/2 - cos(radians(angleS))*(radius/2);
    point(width/8+radius/2+i, pyS);
    angleS -= frequencyS;
  }
  
  //draw the static curve for acceleration - a = -sin(x);
  //[phase shifted by 180]
  angleS=0;
  for (int i = 0; i< width; i++){
    pxS = width/8 + cos(radians(angleS))*(radius/2);
    pyS = 2.5*topPart - sin(radians(angleS))*(radius/2);
    point(width/8+radius/2+i, pyS);
    angleS -= frequencyS;
  }
  
  //------------------------------------------------------------------------------
  //draw the velocity vector
  drawArrow((float)width/8, 1.5*topPart, velVL, (float)-90);
  
  //draw the acceleration vector
  drawArrow((float)width/8, 2.5*topPart, accVL, (float)-90);
  
  strokeWeight(1);  
  
  //------------------------------------------------------------------------------
  //small elipse along the sine curve
  //tracking the y position of the object
  noStroke();
  fill(0);
  ellipse(width/8+radius/2+px, y, 5, 5);
  //angle -= frequency;
  //px+=1;
  
  //small ellipse along the velocity (cosine) curve
  //tracking the position of the velocity vector
  ellipse(width/8+radius/2+px, (1.5*topPart)-velVL, 5,5);
  
  //small ellipse along the acceleration (negative sine) curve
  //tracking the position of the acceleration vector
  ellipse(width/8+radius/2+px, (2.5*topPart)-accVL, 5,5);
  
  angle -= frequency;
  px+=1;
  
  //-----------------------------------------------------------------------------
  //when little ellipse reaches end of window
  //reset ellipse position to beginning
  if(px>=(4*width)/5)
  {
    px=0;
    angle=0;
  }
  
  //-----------------------------------------------------------------------------
  //draw dynamic line connecting centre of oscillating object 
  //with the wave
  stroke(0);
  line(width/8, y, width/8+radius/2+px, y);
  
  //draw dynamic line connecting top of velocity vector 
  //with the velocity curve
  line(width/8, (1.5*topPart)-velVL, width/8+radius/2+px, (1.5*topPart)-velVL);

  //draw dynamic line connecting top of velocity vector 
  //with the velocity curve
  line(width/8, (2.5*topPart)-accVL, width/8+radius/2+px, (2.5*topPart)-accVL);
  
  //----------------------------------------------------------------------------
  //text outputs
  text("Simple Harmonic Motion", width/2-40, 16);
  textSize(16);
  text("Y",5,topPart/3 + 10);
  text("V",5,topPart + topPart/3 + 10);
  text("A",5,2*topPart + topPart/3 + 10);
  textSize(9);
  text("max",20,topPart/3 +10);
  text("max",20,topPart + topPart/3 +10);
  text("max",20,2*topPart + topPart/3 +10);
  textSize(12);
  textAlign(CENTER);
  text("y  =  A sin ωt", width/2, height/3);
  text("[Velocity vector]  v  =  dy/dt  =  Aω cos ωt [tangent to the displacement curve (y)]", width/2, (2*height)/3);
  text("[Acceleration Vector]  a  =  dv/dt  =  − A(ω^2)sin ωt =  − (ω^2)y [tangent to the velocity curve (v)]", width/2, 3*topPart-20);
  textSize(11);
  text("Angular frequency,ω = √(k/m); Time period,T = 2π/ω = 2π√(m/k). [Here assumption: A=1, k=m]", width/2, height-10);
  //text("Object Motion: y = " + accVL, width/8, 275);
  
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
