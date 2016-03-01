import processing.core.*; 

import guicomponents.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class U_Tube extends PApplet {

/*SHM in U-Tube
-Sushovan Mandal
(http://www.tinyurl.com/sushovanmandal)
*/



//the shape, size parameters
float columnHeight;      //the height of the upper column from the start of the arc
//final int meanHeight = 180;
float currHeight;
final int maxVariation = 40;
//final int tubeRadius = 20; //in pixels and in cms= .2
//final float crossArea = PI*(0.002)*(0.002); //in meter-square
float displacement;
//int density;

//motion characteristics
float angle,angleE;
float px,py;
float frequency;

//for creating font
PFont myFont;

//sliders and buttons
GWSlider Length, Displacement;
GButton apply;

public void setup()
{
  size(1000,600);
  background(255);
  smooth();
  
  //intitializations
  columnHeight = 180;
  angle=0;
  frequency= 4.5f - 2*(sqrt(PI/2*.8f+1.8f)/sqrt(PI/2*.8f+1.4f));
  println(frequency);
  displacement = maxVariation;
  
  //Font init
  myFont = createFont("verdana",12);
  textFont(myFont);
  
  //slider init
  Length = new GWSlider(this, width-200-10,height-50, 200);
  Length.setValueType(GWSlider.DECIMAL);
  Length.setLimits(PI/2*.8f+1.8f, PI/2*.8f+1.4f, PI/2*.8f+2.2f);
  Length.setTickCount(9);
  Length.setPrecision(2);
  Length.setStickToTicks(true);
  
  Displacement = new GWSlider(this,width-200-10,height-75-40,200);
  Displacement.setValueType(GWSlider.DECIMAL);
  Displacement.setLimits(0.4f, 0.0f, 0.4f);
  Displacement.setTickCount(5);
  Displacement.setPrecision(2);
  Displacement.setInertia(10);
  Displacement.setStickToTicks(true);
  
  //button init
  G4P.setFont(this, "Verdana", 12);
  G4P.setColorScheme(this, GCScheme.GREY_SCHEME);
  apply = new GButton(this, "Apply the new values", width-10-187, height-180, 175, 30);
  
}

public void draw()
{
  background(255);
  
  //---------------------------------------------------------------------------------------------- 
  //motion calculations
  //currHeight = columnHeight + (columnHeight-columnHeight)*cos(radians(angle));
  currHeight = columnHeight + displacement*cos(radians(angle));
  if(px > (360/frequency))
  {
    px=0;
    angle=0;
  }
  
  //----------------------------------------------------------------------------------------------
  //drawing the static components
  
  //draw the tube
  stroke(104,131,139);
  strokeWeight(3);
  line(100,100,100,400);
  line(140,100,140,400);
  line(300,100,300,400);
  line(260,100,260,400);
  fill(0,191,255);
  arc(200,400,200,200,0,PI);
  fill(255);
  arc(200,400,120,120,0,PI);
  strokeWeight(1);
  stroke(0);
  
  //draw the markers
  for(int i=0; i<=70; i+=10)
  {
    line(80+i,400-columnHeight,80+i+5,400-columnHeight);
  }
  for(int i=0; i<=70; i+=10)
  {
    line(240+i,400-columnHeight,240+i+5,400-columnHeight);
  }
  noFill();
  arc(200,400,220,220,0,PI);
  line(330, 400-columnHeight, 350, 400-columnHeight);
  line(200,107,200,97);
  drawArrow(200,102,58,0);
  line(280,107,280,97);
  drawArrow(280,102,18,0);
  
  //the curve display
  noStroke();
  fill(0);
  rect(400, 400-columnHeight-maxVariation-20, ( float )360/2.35f + 61, 2*maxVariation+40);
  noFill();
  
  stroke(255);
  line(440, 400-columnHeight, 451+ (360/frequency), 400-columnHeight);
  line(440, 400-columnHeight-maxVariation-10, 440, 400-columnHeight+maxVariation+10);
  line(430, 400-columnHeight-displacement, 440, 400-columnHeight-displacement);
  line(430, 400-columnHeight+displacement, 440, 400-columnHeight+displacement);
  line(440+90/frequency, 400-columnHeight-6, 440+90/frequency, 400-columnHeight+6);
  line(440+180/frequency, 400-columnHeight-6, 440+180/frequency, 400-columnHeight+6);
  line(440+270/frequency, 400-columnHeight-6, 440+270/frequency, 400-columnHeight+6);
  line(440+360/frequency, 400-columnHeight-6, 440+360/frequency, 400-columnHeight+6);
  
  stroke(150);
  strokeWeight(2);
  angleE=0;
  py=0;
  for(int i=0; i<=(360/frequency); i++)
  {
    py= 400-columnHeight - cos(radians(angleE))*displacement;
    point(440+i,py);
    angleE -= frequency;
  }
  
  strokeWeight(1);
  stroke(0);
  
  //---------------------------------------------------------------------------------------------
  //drawing the dynamic components
  
  //dynamic markers
  line(80, 400-(2*columnHeight-currHeight), 100, 400-(2*columnHeight-currHeight));
  line(300, 400-currHeight, 320, 400-currHeight);
  
  drawArrow(90,400,2*columnHeight - currHeight,-90);
  drawArrow(310,400,currHeight,-90);
  
  drawArrow(340, 400-columnHeight, currHeight-columnHeight, -90);
  
  //the liquid column
  noStroke();
  fill(0,191,255);
  rect(102, 400-(2*columnHeight-currHeight), 37, 2*columnHeight-currHeight);
  rect(262, 400-currHeight, 37, currHeight);
  fill(255);
  stroke(0);
  
  //motion connect
  stroke(80);
  line(340, 400-currHeight, 440+px, 400-currHeight);
  noStroke();
  fill(200);
  ellipse(440+px, 400-currHeight, 5, 5);
  fill(255);
  stroke(0);
  
  //---------------------------------------------------------------------------------------------
  //text output
  stroke(255);
  fill(255);
  textAlign(LEFT);
  text(( float )displacement/100, 410, 400-columnHeight-displacement-5);
  text(( float )-displacement/100, 407, 400-columnHeight+displacement+15);
  text("\u03c0/2", 420+(90/frequency), 400-columnHeight+20);
  text("\u03c0", 430+(180/frequency), 400-columnHeight-20);
  text("3\u03c0/2", 420+(270/frequency), 400-columnHeight-20);
  text("2\u03c0", 425+(360/frequency), 400-columnHeight+20);
  
  stroke(255,0,0);
  fill(255,0,0);
  text("Scale [pixels:cm]: 10:0.1", (3*width)/4 - 170, height-20);
  
  fill(0,0,255);
  stroke(0,0,255);
  text("maxDisplacement*cos[{\u221a(g/L)}t]", 514, 400-columnHeight+maxVariation+60);
  text("d/dt[Y*cos[{\u221a(g/L)}t]] = -Y\u221a(g/L)sin[{\u221a(g/L)}t]", 412, 460);
  text("d/dt[-Y\u221a(g/L)sin[{\u221a(g/L)}t]] = -Y(g/L)cos[{\u221a(g/L)}t]", 412, 510);
  
  fill(139,90,43);
  stroke(139,90,43);
  text("If the liquid in a U-tube is displaced slightly\nand then released it will oscillate with\nsimple harmonic motion", 700, 100);
  text("Time period of oscillation, T = 2\u03c0\u221a(L/g)", 720, 170);
  text("L is half the length of the liquid in the U-tube", 700, 200);
  
  stroke(0);
  fill(0);
  
  text("L = \u03c0/2*R + "+columnHeight/100+" = "+(PI/2*0.8f+columnHeight/100)+" cm",100,550);
  text("R = mean radius of the tube = 0.8cm",100,570);
  text(".6 cm", 210, 90);
  text(".2 cm", 285, 90);
  text("y = displacement from the mean poition", 445, 400-columnHeight+maxVariation+80);
  text("Y = maximum displacement from the mean poition", 445, 400-columnHeight+maxVariation+100);
  
  text("Velocity of fall of liquid column, V", 400, 440);
  text("= ", 400, 460);
  text("Acceleration of the liquid in motion, A", 400, 490);
  text("= ", 400, 510);
  
  textAlign(CENTER);
  text("The graphical representation of the displacement from the mean position", 440+120+20, 400-columnHeight+maxVariation+40);
  text("y = ", 500, 400-columnHeight+maxVariation+60);
  
  text("L (in cm)", width-110, height-15);
  text("Displacement (in cm)", width-110, height-80);
  
  //fill(0);
  //stroke(0);
  
  textSize(16);
  text("2L", 200, 530);
  textSize(20);
  text("Motion of liquid in U-tube", width/2, 50);
  textSize(12);
  
  //--------------------------------------------------------------------------------------------
  //data changes and resets
  angle-=frequency;
  
  px++;
  

}

//function for drawing arrow
public void drawArrow(float cx, float cy, float len, float angle){
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

public void handleSliderEvents(GSlider slider)
{}

public void handleButtonEvents(GButton button)
{
  switch(button.eventType)
  {
      case GButton.CLICKED:
        //println(Length.getValuef());
        frequency = 4.5f - 2*(sqrt(Length.getValuef())/sqrt(PI/2*.8f+1.4f));
        columnHeight = (Length.getValuef()-(PI/2*.8f))*100;
        //println(Displacement.getValuef());
        displacement = Displacement.getValuef()*100;
        angle = 0;
        px=0;
        break;
      default:
        println("Unrecognized event");
  }
}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#F0F0F0", "U_Tube" });
  }
}
