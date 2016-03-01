import processing.core.*; 

import controlP5.*; 

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

public class controlp5_sliderTest extends PApplet {



ControlP5 controlP5;
int myColorBackground = color(0,0,0);
public int sliderValue = 100;

public void setup() {
  size(400,400);
  controlP5 = new ControlP5(this);
  controlP5.addSlider("slider",100,167,128,100,160,10,100);
  controlP5.addSlider("sliderValue",0,255,12,200,200,10,100);
}

public void draw() {
  background(myColorBackground);
  fill(sliderValue);
  rect(0,0,width,100);
}

public void slider(float theColor) {
  myColorBackground = color(theColor);
  println("a slider event. setting background to "+theColor);
}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#F0F0F0", "controlp5_sliderTest" });
  }
}
