class Ball {
  //ADD YOUR CODE HERE

  /*
   following method has been modified using the code   from
   http://processing.org/learning/topics/circlecollision.html
   Credit: Ira Greenberg, Keith Peter
   
   DO NOT MODIFY THIS METHOD
   
   */
  void collideWith(Ball other) {
    PVector bVect = new PVector();
    bVect.x = other.x - x;
    bVect.y = other.y - y;

    float bVectMag = sqrt(bVect.x * bVect.x + bVect.y * bVect.y);
    if (checkCollisionWith(other)) {
      // get angle of bVect
      float theta  = atan2(bVect.y, bVect.x);
      // precalculate trig values
      float sine = sin(theta);
      float cosine = cos(theta);

      Ball[] bTemp = {  
        new Ball(), new Ball()
        };

        /* b[1]'s position is relative to b[0]'s
         so you can use the vector between them (bVect) as the 
         reference point in the rotation expressions.
         bTemp[0].x and bTemp[0].y will initialize
         automatically to 0.0, which is what you want
         since b[1] will rotate around b[0] */
        bTemp[1].x  = cosine * bVect.x + sine * bVect.y;
      bTemp[1].y  = cosine * bVect.y - sine * bVect.x;

      // rotate Temporary velocities
      PVector[] vTemp = { 
        new PVector(), new PVector()
        };

      PVector[] v = { 
        new PVector(speedX, speedY), 
        new PVector(other.speedX, other.speedY)
        };
        vTemp[0].x  = cosine * v[0].x + sine * v[0].y;
      vTemp[0].y  = cosine * v[0].y - sine * v[0].x;
      vTemp[1].x  = cosine * v[1].x + sine * v[1].y;
      vTemp[1].y  = cosine * v[1].y - sine * v[1].x;

      /* Now that velocities are rotated, you can use 1D
       conservation of momentum equations to calculate 
       the final velocity along the x-axis. */
      PVector[] vFinal = {  
        new PVector(), new PVector()
        };
        // final rotated velocity for b[0]
        vFinal[0].x = ((m - other.m) * vTemp[0].x + 2 * other.m * 
          vTemp[1].x) / (m + other.m);
      vFinal[0].y = vTemp[0].y;
      // final rotated velocity for b[0]
      vFinal[1].x = ((other.m - m) * vTemp[1].x + 2 * m * 
        vTemp[0].x) / (m + other.m);
      vFinal[1].y = vTemp[1].y;

      // hack to avoid clumping
      bTemp[0].x += vFinal[0].x;
      bTemp[1].x += vFinal[1].x;

      /* Rotate ball positions and velocities back
       Reverse signs in trig expressions to rotate 
       in the opposite direction */
      // rotate balls
      Ball[] bFinal = { 
        new Ball(), new Ball()
        };
        bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
      bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
      bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
      bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;

      // update balls to screen position
      other.x = constrain(x + bFinal[1].x, other.diameter/2, width-other.diameter/2);
      other.y = constrain(y + bFinal[1].y, other.diameter/2, height-other.diameter/2);;
      x = constrain(x + bFinal[0].x, diameter/2, width-diameter/2);;
      y = constrain(y + bFinal[0].y, diameter/2, height-diameter/2);;

      // update velocities
      speedX = cosine * vFinal[0].x - sine * vFinal[0].y;
      speedY = cosine * vFinal[0].y + sine * vFinal[0].x;
      other.speedX = cosine * vFinal[1].x - sine * vFinal[1].y;
      other.speedY = cosine * vFinal[1].y + sine * vFinal[1].x;
    }
  }
}

