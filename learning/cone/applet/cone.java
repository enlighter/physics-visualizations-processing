import processing.core.*; 

import processing.opengl.*; 
import processing.opengl.*; 

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

public class cone extends PApplet {

 

public void setup()
{
  size(600,600,OPENGL);
  stroke(0);
  fill(128,128,128);
  background(241,253,11);
}

public void draw()
{
  cone(width/2,780,(3/4)*width,(3/4)*height);
}

static float unitConeX[];
static float unitConeY[];
static int coneDetail;
 
static {
  coneDetail(24);
}
 
// just inits the points of a circle, 
// if you're doing lots of cones the same size 
// then you'll want to cache height and radius too
public static void coneDetail(int det) {
  coneDetail = det;
  unitConeX = new float[det+1];
  unitConeY = new float[det+1];
  for (int i = 0; i <= det; i++) {
    float a1 = TWO_PI * i / det;
    unitConeX[i] = (float)Math.cos(a1);
    unitConeY[i] = (float)Math.sin(a1);
  }
}
 
// places a cone with it's base centred at (x,y),
// beight h in positive z, radius r.
public void cone(float x, float y, float r, float h) {
  pushMatrix();
  translate(x,y);
  scale(r,r);
  beginShape(TRIANGLES);
  for (int i = 0; i < coneDetail; i++) {
    vertex(unitConeX[i],unitConeY[i],0.0f);
    vertex(unitConeX[i+1],unitConeY[i+1],0.0f);
    vertex(0,0,h);
  }
  endShape();
  popMatrix();
}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#F0F0F0", "cone" });
  }
}
