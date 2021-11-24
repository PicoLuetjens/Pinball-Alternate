//displays the game itself(when you press play)
void game()
{
  noStroke();
  cursor(ARROW);
  background(100);
  imageMode(CENTER);
  //image(baseGround, width/2, height/2, baseGroundWidth, height);
  image(baseGround, width/2, height/2-height/60, baseGroundWidth, baseGroundHeight);
  imageMode(CORNER);
  
  
  for(PShape shape : allShapes)
  {
    shape(shape);
  }
  
  //left side Buttons
  fill(255, 0, 0);
  rectMode(CENTER);
  rect(width/10, (height/5)*2, width/5.5, height/10, 5); 
  rect(width/10, (height/5)*3, width/5.5, height/10, 5); 
  rect(width/10, (height/5)*4, width/5.5, height/10, 5);
  
  //left side Buttons texts
  fill(0);
  text("back", width/10, (height/5)*2);
  text("to menue?", width/10, (height/5)*2+height/25);
  text("render physical", width/10, (height/5)*3);
  text("boundaries", width/10, (height/5)*3+height/25);
  text("pause", width/10, (height/5)*4);
  text("Game?", width/10, (height/5)*4+height/25);
  
  
  fill(0);
  if(lifes >= 0)
  {
    text("Lifes: " + lifes, (width/6)*5, height/10);
  }
  else
  {
    text("Lifes: 0", (width/6)*5, height/10);
  }
  text("Score: " + score, width/6, height/10);
  
  if(score % 1000 == 0)
  {
    if(!lifesAdded)
    {
      lifes++;
      lifesAdded = true;
    }
  }
  else
  {
    lifesAdded = false;
  }

  //playing
  if(ingame_State == 0)
  {
    if(ball.done())
    {
      lifes--;
      ball = new Ball((width/40)*27, (height/20)*18, width/200);
    }
    
    else
    {
      take_vec = ball.display();
    }
    
    fl.display();
    fr.display();
    
    //if display enables display all physics boundaries
    if(renderObjects)
    {
      for(Norm_boundary boundary : boundaries_pO)
      {
        boundary.display();
      }
      
      for(Bumper bumper : bumpers_pO)
      {
        bumper.display();
      }
      
      for(Score_Hole scorehole : scoreholes_pO)
      {
        scorehole.display();
      }
      
    }
    
    for(Score_Hole sc : scoreholes_pO)
    {
      //while or if?
      if(sc.collision(take_vec.x, take_vec.y))
      {
        score+=10;
      }
    }
    
    if(lifes < 0)
    {
      ingame_State = 2;
    }
    box2d.step();
    
    //check music if it ends
    if(player.position() == player.length())
    {
      player.rewind();
      player.play();
    }
    
    fill(255);
    //text("FPS: " + frameRate, (width/20)*19, height/20);
  }
  
  //paused
  else if(ingame_State == 1)
  {
      ball.display();
      fl.display();
      fr.display();
      if(renderObjects)
      {
        for(Norm_boundary boundary : boundaries_pO)
        {
          boundary.display();
        }
        
        for(Bumper bumper : bumpers_pO)
        {
          bumper.display();
        }
        
        for(Score_Hole scorehole : scoreholes_pO)
        {
          scorehole.display();
        }
        
      }
      //maybe display paused or so and dont update physics
      fill(255, 0, 0);
      rectMode(CENTER);
      rect(width/2, height/2, width/3, height/4, 5);
      fill(0);
      text("Game Paused", width/2, (height/16)*7);
      text("click this Rect to continue", width/2, (height/16)*9);
  }
  //ended
  else if(ingame_State == 2)
  {
    if(!scoreHandled)
    {
      handleScoreboardEntry();
    }
    else
    {
      if(!board_updated)
      {
        updateScoreboard();
        board_updated = true;
      }
      if(!endCut_played)
        playEndCut();
      else if(endCut_played)
      {
        displayScoreBoard();
        //GAME_STATE = STATE_MENUE;
      }
    }
    if(player.isPlaying())
    {
      player.pause();
      player.rewind();
    }
    
  }
  
  if(!imgAnalyzeDone)
  {
    rectMode(CENTER);
    rect(width/2, height/2, width/2, height/2);
    fill(255);
    text("Image analyzing", width/2, (height/3));
    text("please wait", width/2, height/2);
  }
  
  if(toolbar_State == 1)
  {
    fill(50, 50, 50);
    noStroke();
    rectMode(CENTER);
    rect(width/2, height/2, width/2, height/2);
    fill(255, 0, 0);
    rect((width/16)*6, (height/3)*2, width/8, height/16, 5);
    rect((width/16)*10, (height/3)*2, width/8, height/16, 5);
    rectMode(CORNER);
    fill(255);
    text("go back to menue?", width/2, (height/3));
    text("(no results will be saved)", width/2, height/2);
    text("yes", (width/16)*6, (height/3)*2);
    text("no", (width/16)*10, (height/3)*2);
  }
  
 
}

//generates all physics objects from the shapes(gets called when in another thread)
void imgAnalyze()
{
  deleteAllPhysicsObjects();
  ArrayList<PVector> ellipsePoints = new ArrayList();
  //instanciate and place all physics objects with angle
  //from the lists 
  //for(ArrayList<PVector> list : allShapePoints)
  for(int i = 0; i < allShapePoints.size(); i++)
  {
    ArrayList<PVector> list = allShapePoints.get(i);
    int randomtypeInstance = int(random(0, 4));
    int shapeType = allShapeTypes.get(i);
    
    
    
    //save points coordinates and type and game resolution to file(if save was enabled in editMode)
    //...
    //...
    
    
    
    for(int j = 0; j < list.size()-1; j++)
    {
      //calculate angle and instance the right type of object
      PVector point1 = list.get(j);
      PVector point2 = list.get(j+1);
      PVector middlepoint = new PVector((point2.x+point1.x)/2, (point2.y+point1.y)/2);
      float instanceLength = dist(point1.x, point1.y, point2.x, point2.y);
      float angle = atan2(point2.y-point1.y, point2.x-point1.x);
      //println("innere sCHLEIFE2");
      
      switch(shapeType)
      {
        case 0:
          Bumper bumper = new Bumper(middlepoint.x, middlepoint.y, instanceLength, height/100, angle);
          bumpers_pO.add(bumper);
          //println("erzeuge Bumper Instanz");
          break;
          
        case 1:
          Norm_boundary boundary = new Norm_boundary(middlepoint.x, middlepoint.y, instanceLength, height/100, angle);
          boundaries_pO.add(boundary);
          //println("erzeuge Normal Instanz");
          break;
        
        case 2:
          Score_Hole scorehole = new Score_Hole(middlepoint.x, middlepoint.y, instanceLength, height/100, angle);
          scoreholes_pO.add(scorehole);
          //println("erzeuge Scorehole Instanz");
          break;
        
        case 3:
          switch(randomtypeInstance)
          {
            case 0: 
             Bumper bumperR = new Bumper(middlepoint.x, middlepoint.y, instanceLength, height/100, angle);
             bumpers_pO.add(bumperR);
             break;
             
           case 1: 
             Norm_boundary boundaryR = new Norm_boundary(middlepoint.x, middlepoint.y, instanceLength, height/100, angle);
             boundaries_pO.add(boundaryR);
             break;
             
           case 2:
             Score_Hole scoreholeR = new Score_Hole(middlepoint.x, middlepoint.y, instanceLength, height/100, angle);
             scoreholes_pO.add(scoreholeR);
             break;
             
           default:
             Norm_boundary boundaryD = new Norm_boundary(middlepoint.x, middlepoint.y, instanceLength, height/100, angle);
             boundaries_pO.add(boundaryD);
             break;
          }
          break;
          
        default:
          Norm_boundary boundaryDD = new Norm_boundary(middlepoint.x, middlepoint.y, instanceLength, height/50, angle);
          boundaries_pO.add(boundaryDD);
          break;
      }
    }
  }
  
  //add the outer boundary
  boundaries_pO.add(new Norm_boundary(1.783999*baseGroundWidth, 1.0029997*baseGroundHeight, 0.089999974*baseGroundWidth, 0.010000015*baseGroundHeight, 0));
  boundaries_pO.add(new Norm_boundary(1.7529985*baseGroundWidth, 0.71499985*baseGroundHeight, 0.015999984*baseGroundWidth, 0.5719994*baseGroundHeight, 0));
  boundaries_pO.add(new Norm_boundary(1.6639986*baseGroundWidth, 0.7949998*baseGroundHeight, 0.2*baseGroundWidth, 0.010000015*baseGroundHeight, -0.50799984));
  boundaries_pO.add(new Norm_boundary(0.95199966*baseGroundWidth, 0.78099984*baseGroundHeight, 0.28199962*baseGroundWidth, 0.010000015*baseGroundHeight, 0.5049999));
  boundaries_pO.add(new Norm_boundary(0.83299965*baseGroundWidth, 0.6379999*baseGroundHeight, 0.014999984*baseGroundWidth, 0.7399997*baseGroundHeight, 0));
  boundaries_pO.add(new Norm_boundary(1.8189984*baseGroundWidth, 0.6379999*baseGroundHeight, 0.014999984*baseGroundWidth, 0.7399997*baseGroundHeight, 0));
  boundaries_pO.add(new Norm_boundary(1.2889992*baseGroundWidth, 1.0039997*baseGroundHeight, 0.9259995*baseGroundWidth, 0.010000015*baseGroundHeight, 0));
  
  //ellipse at the top
  
  float ellipseWidth = 0.98599875*baseGroundWidth;
  float ellipseHeight = (((0.6379999 - 0.7399997/2)-0.010000015/2)*baseGroundHeight)-width/160;
  //println(ellipseWidth, ellipseHeight);
  //calculate edge points on the ellipse(with 50 points -> size of sketch is not influencing the amount(will always be 50 resolution))
  //for(float i = 1.8189984*baseGroundWidth; i <= 1.8189984*baseGroundWidth+ellipseWidth; i+=ellipseWidth/50
  for(float i = -ellipseWidth/2; i <= ellipseWidth/2; i+=ellipseWidth/50)
  {
    float a = ellipseWidth/2;
    float pow1 = pow(i, 2);
    float pow2 = pow(a, 2);
    float wurzel = sqrt(1-pow1/pow2);
    float yPoint = ellipseHeight*wurzel;
    PVector ellipsePoint = new PVector(i+0.83299965*baseGroundWidth+ellipseWidth/2, -yPoint+0.6379999*baseGroundHeight-0.7399997*baseGroundHeight/2);
    //print(ellipsePoint);
    ellipsePoints.add(ellipsePoint);
  }
  
  for(int i = 0; i < ellipsePoints.size()-1; i++)
  {
    PVector pos = ellipsePoints.get(i);
    PVector pos2 = ellipsePoints.get(i+1);
    PVector mittelpunkt = new PVector((pos.x+pos2.x)/2, (pos.y+pos2.y)/2);
    float laenge = dist(pos.x, pos.y, pos2.x, pos2.y);
    float winkel = atan2(pos2.y-pos.y, pos2.x-pos.x);
    boundaries_pO.add(new Norm_boundary(mittelpunkt.x, mittelpunkt.y, laenge, 0.010000015*baseGroundHeight, winkel));
  }
  
  //first solution to fix 1280p boundary bug 
  if(width == 1280)
  {
    boundaries_pO.add(new Norm_boundary(1.8089987*baseGroundWidth, 0.23000023*baseGroundHeight, 0.015999984*baseGroundWidth, .09*baseGroundHeight, -0.22000003));
  }
  
  //println("scoreholes_po-size: " + scoreholes_pO.size());
  //println("bumpers_po-size: " + bumpers_pO.size());
  //println("ending thread...");
  
  imgAnalyzeDone = true;
  ingame_State = 0;
}
