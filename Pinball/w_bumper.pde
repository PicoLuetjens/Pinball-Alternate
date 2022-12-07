//Bumper Object class which contains the bumperShape and the physical Bumper Object
class Bumper
{
  float x, y, w, h;
  
  Body b;
  
  Bumper(float x, float y, float w, float h, float a)
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
    bd.angle = -a;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    bd.bullet = true;
    b = box2d.createBody(bd);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density = 1;
    fd.friction = 0.01;
    fd.restitution = 1;
    
    //b.createFixture(sd, 1);
    b.createFixture(fd);
    
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
    float a = b.getAngle();
    pushMatrix();
    translate(x, y);
    rotate(-a);
    rect(0, 0, w, h);
    popMatrix();
    rectMode(CORNER);
  }
}
