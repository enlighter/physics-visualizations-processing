void setup()
{
    size(200,200);
    stroke(0);
}

void draw()
{
    rectMode(CENTER);
    rect(width/2, height/2, 20, height/2);
    ellipse(width/2, 70, 60, 60);
    ellipse(81,70,16,32);
    ellipse(119,70,16,32);
    line(90,150,80,160);
    line(110,150,120,160);
    saveFrame("output.png");
}


