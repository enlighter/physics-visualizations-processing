void setup( )
{
  size(150, 150);
  background(255);
  smooth();
  // don't show where control points are
  noFill();
  stroke(0);
  beginShape();
  vertex(50, 75); // first point
  bezierVertex(25, 25, 125, 25, 100, 75);
  endShape();
  beginShape();
vertex(30, 70); // first point
bezierVertex(25, 25, 100, 50, 50, 100);
bezierVertex(20, 130, 75, 140, 120, 120);
endShape();
}
