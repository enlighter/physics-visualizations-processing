/* Orbital Motion
-Sushovan mandal
(http://www.tinyurl.com/sushovanmandal)
*/

//motion parameters
float angle, frequency;

//orbit parameters
float centreX, centreY;
float fociX, fociY;
float currX, currY;
float a,b;
float e;

//for creating font
PFont myFont;

void setup()
{
  size(1000,500);
  background(25,25,112);
  smooth();
  
  //initializations
  centreX = width/2;
  centreY = height/2;
  
  a=200;
  b=100;
  
  e = sqrt(1-(b/a)*(b/a));
  println(e);
  fociX = centreX + sqrt(a*a - b*b);
  fociY = centreY;
  
  frequency=2;
  
  //Font init
  myFont = createFont("verdana",12);
  textFont(myFont);
}

void draw()
{
  background(25,25,112);
  
  //motion dynamics
  currX = centreX + a*cos(radians(angle));
  currY = centreY - b*sin(radians(angle));
  
  //-------------------------------------------------------------------------------------
  //static components
  stroke(132,112,255);
  fill(25,25,112);
  ellipse(centreX, centreY, 400, 200);
  
  noStroke();
  fill(238,230,133);
  ellipse(fociX, fociY, 30, 30);
  /*line(centreX, centreY, centreX+a*cos(radians(-20)), centreY+b*sin(radians(-20)));
  line(centreX, centreY, centreX+a*cos(radians(-40)), centreY+b*sin(radians(-40)));
  line(centreX, centreY, centreX+a*cos(radians(40)), centreY+b*sin(radians(40)));
  line(centreX, centreY, centreX+a*cos(radians(20)), centreY+b*sin(radians(20)));
  */
  
  //------------------------------------------------------------------------------------
  //dynamic components
  noStroke();
  fill(248,248,255);
  ellipse(currX, currY, 15, 15);
  
  //------------------------------------------------------------------------------------
  //increments and resets
  angle -= frequency;
  
}
