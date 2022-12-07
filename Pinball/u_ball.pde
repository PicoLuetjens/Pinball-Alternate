//Ball object class which contains the ballShape and the physical Ball Object
class Ball
{
  Body body;
  float rad;
  boolean active;
  color col;
  PVector ret_vec;

  Ball(float x, float y, float r) {
    rad = r;
    makeBody(x,y,r);
    body.setUserData(this); //for collision detect
    col = color(224, 223, 219);
    ret_vec = new PVector(x, y);
  }

  void killBody() {
    box2d.destroyBody(body);
  }

  //destroys ball when it is off the screen
  boolean done() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.y > (height/2+baseGroundHeight/2)-rad*5) {
      killBody();
      return true;
    }
    return false;
  }

  
  PVector display()
  {
    
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    pushMatrix();
    translate(pos.x,pos.y);
    fill(col); //so color can change to match ball
    strokeWeight(1);
    stroke(0);
    rotate(a);
    //fill(0);
    ellipse(0,0,rad*2,rad*2);
    popMatrix();
    ret_vec.x = pos.x;
    ret_vec.y = pos.y;
    return ret_vec;
  }

  void makeBody(float x, float y, float r) {
    BodyDef bd = new BodyDef();
    bd.position = box2d.coordPixelsToWorld(x,y);
    bd.type = BodyType.DYNAMIC;
    bd.bullet = true; //fixes tunneling
    body = box2d.world.createBody(bd);

    CircleShape cs = new CircleShape();
    //cs.m_radius = box2d.scalarPixelsToWorld(rad);
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = 1;
    fd.friction = 0.01;
    fd.restitution = .7;
    
    body.createFixture(fd);
    
    if(width == 1920)
      //body.setLinearVelocity(new Vec2(0, 150000));
      body.setLinearVelocity(new Vec2(0, 150));
    else if(width == 1280)
      body.setLinearVelocity(new Vec2(0, 50));
    body.setAngularVelocity(random(-10, 10));
  }

}
