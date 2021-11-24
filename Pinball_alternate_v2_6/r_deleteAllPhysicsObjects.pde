//deletes all boundary-Objects from the box2d-World
void deleteAllPhysicsObjects()
{
  if(boundaries_pO.size() > 0)
  {
    for(Norm_boundary b : boundaries_pO)
    {
      b.killBody();
    }
    boundaries_pO.clear();
  }
  
  if(bumpers_pO.size() > 0)
  {
    for(Bumper b : bumpers_pO)
    {
      b.killBody();
    }
    bumpers_pO.clear();
  }
  
  if(scoreholes_pO.size() > 0)
  {
    scoreholes_pO.clear();
  }
  
  //destroy paddles
  //fl.killBody();
  //fr.killBody();
}

//delets all the shape-Data Lists
void deleteLists()
{
  if(allShapePoints.size() > 0)
  {
    allShapePoints.clear();
  }
  if(allShapeTypes.size() > 0)
  {
    allShapeTypes.clear();
  }
  if(allShapes.size() > 0)
  {
    allShapes.clear();
  }
  if(SCON_List.size() > 0)
  {
    SCON_List.clear();
  }
}
