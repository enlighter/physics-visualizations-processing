void setup( )
{
  size(150, 150);
  background(255);
  smooth();

  ellipse(50, 75, 5, 5); // endpoints of curve
  ellipse(100, 75, 5, 5);
  fill(255, 0, 0);
  ellipse(25, 25, 5, 5);  // control points
  ellipse(125, 25, 5, 5); 
  noFill();
  stroke(0);
  bezier(50, 75, 25, 25, 125, 25, 100, 75);
}
