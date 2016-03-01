import processing.opengl.*;

void setup()
{
  size(600,600,OPENGL);
  stroke(0);
  fill(128,128,128);
  background(241,253,11);
}

void draw()
{
  cone(width/2,780,(3/4)*width,(3/4)*height);
}

