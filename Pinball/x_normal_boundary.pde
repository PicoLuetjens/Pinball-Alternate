//Normal_boundary Object class which contains the normalBoundaryShape and the physical normalBoundary Object
class Norm_boundary
{
  float x, y, w, h;
  
  Body b;
  
  Norm_boundary(float x, float y, float w, float h, float a)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    
    PolygonShape sd = new PolygonShape();
    
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    
    sd.setAsBox(box2dW, box2dH);
    
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    //nicht sicher ob wir überhaupt einen Angle brauchen bei statics
    bd.angle = -a;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    b = box2d.createBody(bd);
    bd.bullet = true;
    
    b.createFixture(sd, 1);
    
    bd.setUserData(this);
  }
  
  void killBody()
  {
    box2d.destroyBody(b);
  }
  
  void display()
  {
    noStroke();
    fill(255, 20, 147);
    rectMode(CENTER);  
    Vec2 pos = box2d.getBodyPixelCoord(b);
    float a = b.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    rect(0, 0, w, h);
    popMatrix();
    rectMode(CORNER);
  }
}
