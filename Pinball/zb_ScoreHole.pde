//Score_Hole Object class which contains the scoreHoleShape but no physics Object because 
//there is no physics calculation needed for this one. It detects collision with the ball
//by itself
class Score_Hole
{
  float x, y, w, h;
  float a; 
 
  
  Score_Hole(float x, float y, float w, float h, float a)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.a = a;
  }
  
  //takes ball position as input
  boolean collision(float x_ball, float y_ball)
  {
    //muss nicht plus den radius sein, da ein Ball da sonst nicht reinfallen würde, sondern 
    //wieder rausrollen würde -> also würde man dann auch keine Punkte dafür kriegen
    if(x_ball >= x - w/2 && x_ball <= x + w/2)
    {
      if(y_ball >= y - h/2 && y_ball <= y + h/2)
      {
        return true;
      }
    }
    return false;
  }
  
  void display()
  {
    noStroke();
    fill(255, 20, 147);
    rectMode(CENTER);  
    pushMatrix();
    translate(x, y);
    rotate(a);
    rect(0, 0, w, h);
    popMatrix();
    rectMode(CORNER);
  }
}
