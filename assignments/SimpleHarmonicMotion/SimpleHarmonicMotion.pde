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
float y=0;
float SpringUnitWidth=25;
 
//for creating font
PFont myFont;

void setup()
{
  size(675,300);
  background(127);
  smooth();
  myFont = createFont("verdana",12);
  textFont(myFont);
  
  y=height/2;
}

void draw()
{
  background(127);
  
  //creating the mean line
  stroke(255);
  line(0,height/2,width-1,height/2);
  
  //calculating y
  y = height/2 + sin(radians(angle))*(radius/2);
  
  //drawing a static component
  stroke(220);
  line((width/8)-15, height/12, (width/8+15), height/12);
  
  //drawing the oscillating spring
  noFill();
  SpringUnitWidth = (y-10-height/12)/5;
  for(int i=0; i<5; i++)
  {
    beginShape();
    curveVertex(width/8+12, height/12 + i*SpringUnitWidth);
    curveVertex(width/8+12, height/12 + i*SpringUnitWidth);
    curveVertex(width/8+8, height/12 + i*SpringUnitWidth + SpringUnitWidth/2);
    curveVertex(width/8-4, height/12 + i*SpringUnitWidth + (4*SpringUnitWidth)/5);
    curveVertex(width/8-12, height/12 + i*SpringUnitWidth + SpringUnitWidth/2);
    curveVertex(width/8-4, height/12 + i*SpringUnitWidth + SpringUnitWidth/5);
    curveVertex(width/8+8, height/12 + i*SpringUnitWidth + SpringUnitWidth/2);
    curveVertex(width/8+12, height/12 + (i+1)*SpringUnitWidth);
    curveVertex(width/8+12, height/12 + (i+1)*SpringUnitWidth);
    endShape();
  }
  
  //drawing the oscilatting object
  noStroke();
  fill(190);
  ellipse(width/8, y, 30, 30);
  
  // draw static curve - y = sin(x)
  angleS=0;
  stroke(200);
  for (int i = 0; i< width; i++){
    pxS = width/8 + cos(radians(angleS))*(radius/2);
    pyS = height/2 + sin(radians(angleS))*(radius/2);
    point(width/8+radius/2+i, pyS);
    angleS -= frequencyS;
  }
  
  //small elipse along the sine curve
  //tracking the y position of the object
  noStroke();
  fill(0);
  ellipse(width/8+radius/2+px, y, 5, 5);
  angle -= frequency;
  px+=1;
  
  //when little ellipse reaches end of window
  //reset ellipse position to beginning
  if(px>=(4*width)/5)
  {
    px=0;
    angle=0;
  }
  
  //draw dynamic line connecting centre of oscillating object 
  //with the wave
  stroke(0);
  line(width/8, y, width/8+radius/2+px, y);
  
  //text outputs
  text("Simple Harmonic Motion", width/2-40, 12);
  text("Sine Curve - y=sin(w)", width/2, 220);
  text("Object Motion: y = " + y, width/8, 275);
  
}
