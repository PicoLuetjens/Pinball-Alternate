//this handles collision of the Ball with a Bumper Object, but is not used in the 
//final game. It only gets called when box2d.lsitenForCollisions() in setup() is called
void beginContact(Contact cp)
{
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
  
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  
  
  if(o1 == null || o2 == null)
  {
    return;
  }
  
  if(o1 instanceof Ball && o2 instanceof Bumper)
  //if(o1.getClass() == Ball.class && o2.getClass() == Bumper.class)
  {
    //apply force to ball
    Ball b = (Ball) o1;
    b.body.applyAngularImpulse(10000000);
    //print("hit");
  }
  
  if(o1 instanceof Bumper && o2 instanceof Ball)
  //if(o1.getClass() == Bumper.class && o2.getClass() == Ball.class)
  {
    //apply force to ball
    Ball b = (Ball) o2;
    b.body.applyAngularImpulse(10000000);
    //print("hit");
  }
}

void endContact(Contact cp)
{
  //do nothing on endContact(scorehole collision will 
  //be handled by own class and not by box2d)
}
