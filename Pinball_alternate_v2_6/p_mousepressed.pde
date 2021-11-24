//handles all Mouse-Events
void mouseReleased()
{   
  if(GAME_STATE == STATE_PLAYING)
  {
    //playing
    if(ingame_State == 0)
    {
      // rect(width/10, (height/5)*2, width/5.5, height/10, 5);
        //abfrage über rect(button 1)-> back to menue?
        
        if(mouseX >= width/10 - (width/5.5)/2 && mouseX <= width/10 + (width/5.5)/2)
        {
          if(mouseY >= (height/5)*2 - (height/10)/2 && mouseY <= (height/5)*2 + (height/10)/2)
          {
            //back to menue?
            toolbar_State = 1;
          }
        
        
        //abfrage über rect(button 2)-> render boundaries?
        
          if(mouseY >= (height/5)*3 - (height/10)/2 && mouseY <= (height/5)*3 + (height/10)/2)
          {
            //set boolean true for render objects over image in game-scope
            if(renderObjects)
            {
              renderObjects = false;
            }
            else if(!renderObjects)
            {
              renderObjects = true;
            }
          }
         
        //abfrage über rect(button 3)-> pause?
        
          if(mouseY >= (height/5)*4 - (height/10)/2 && mouseY <= (height/5)*4 + (height/10)/2)
          {
            //game paused
            ingame_State = 1;
          }
        }
     
    }
    
    //if in pause state
    if(ingame_State == 1 && mouseX > width/2-(width/3)/2 && mouseX < width/2+(width/3)/2 && mouseY > height/2-(height/4)/2 && mouseY < height/2+(height/4)/2)
    {
      //set back to playing
      ingame_State = 0;
    }
    
    if(toolbar_State == 1)
    {
      //yes button
      if(mouseX >= (width/16)*6-width/16 && mouseX <= (width/16)*6+width/16 && mouseY >= (height/3)*2-height/32 && mouseY <= (height/3)*2+height/32)
      {
        GAME_STATE = STATE_MENUE;
        toolbar_State = 0;
        //reset values
        lifes = 2;
        score = 0;
        ball.killBody();
      }
      
      //no button
      if(mouseX >= (width/16)*10-width/16 && mouseX <= (width/16)*10+width/16 && mouseY >= (height/3)*2-height/32 && mouseY <= (height/3)*2+height/32)
      {
        toolbar_State = 0;
      }
    }
    
  }
  if(GAME_STATE == STATE_EDITMODE)
  {
    if(!saving && loadstate == 0)
    {  
      //right side buttons
      if(mouseX >= (width/6)*5 - (width/6)/2 && mouseX <= (width/6)*5 + (width/6)/5)
      {
        if(!typeselectionlocked)
        {
          //button 1
          if(mouseY >= height/5 - (width/10)/2 && mouseY <= height/5 + (width/10)/2)
          {
            typeselection = 0;
          }
          
          //button 2
          if(mouseY >= (height/5)*2 - (width/10)/2 && mouseY <= (height/5)*2 + (width/10)/2)
          {
            typeselection = 1;
          }
          
          //button 3
          if(mouseY >= (height/5)*3 - (width/10)/2 && mouseY <= (height/5)*3 + (width/10)/2)
          {
            typeselection = 2;
          }
          
          //button 4
          if(mouseY >= (height/5)*4 - (width/10)/2 && mouseY <= (height/5)*4 + (width/10)/2)
          {
            typeselection = 3;
          } 
        }
      }
      
      //left side buttons
      if(mouseX >= width/6 - (width/6)/2 && mouseX <= width/6 + (width/6)/2)
      {
        //button 1
        if(mouseY >= height/5 - (width/10)/2 && mouseY <= height/5 + (width/10)/2)
        {
          shapedrawState = 1;
          typeselectionlocked = true;
        }
        
        //button 2
        if(mouseY >= (height/5)*2 - (width/10)/2 && mouseY <= (height/5)*2 + (width/10)/2)
        {
          if(singleShapePoints.size() > 2)
          {
            closeShape = true;
          }
        }
        
        //button 3
        if(mouseY >= (height/5)*3 - (width/10)/2 && mouseY <= (height/5)*3 + (width/10)/2)
        {
          if(singleShapePoints.size() > 1)
          {
            if(shapedrawState == 1)
            {
              shapedrawState = 2;
              PShape shape = createShape();
              shape.beginShape();
              for(PVector vec : singleShapePoints)
              {
                shape.vertex(vec.x, vec.y);
              }
              
              if(closeShape)
              {
                shape.fill(colors[typeselection]);
                shape.endShape(CLOSE);
                
                //add close point from the beginning to simplify algorithm for later
                PVector endvalue = singleShapePoints.get(0);
                singleShapePoints.add(endvalue);
              }
              else
              {
                shape.noFill();
                shape.endShape();
              }
              //add shape to display later
              allShapes.add(shape);
              //add shape points for calculating boundaries later
              allShapePoints.add(singleShapePoints);
              //add the type for spawning objects later
              allShapeTypes.append(typeselection);
              //println(allShapePoints.get(allShapePoints.size()-1).size());
              //clear the list for the single shape for the next one
              //by setting it to a new  empty instance of Arraylist
              //since it is still referenced with the one added to allShapePoints-list
              singleShapePoints = new ArrayList<PVector>();
              //println(allShapePoints.get(allShapePoints.size()-1).size());
              //save closed or not state
              if(closeShape)
              {
                SCON_List.append(1);
              }
              else
              {
                SCON_List.append(0);
              }
              //reset close shape for next shape
              closeShape = false;
              typeselectionlocked = false;
            }
          }
        }
        
        //button 4
        if(mouseY >= (height/5)*4 - (width/10)/2 && mouseY <= (height/5)*4 + (width/10)/2)
        {
          // delete last point
          if(shapedrawState == 1)
          {
            if(singleShapePoints.size() > 0)
            {
              singleShapePoints.remove(singleShapePoints.size()-1);
            }
          }
        }
      }
      
      // in green rect
      if(mouseX >= (width/2)-((baseGroundWidth*0.8)/2) && mouseX <= (width/2)+((baseGroundWidth*0.8)/2))
      {
        if(mouseY >= ((height/2)-(height/15))-((baseGroundHeight*0.6)/2) && mouseY <= ((height/2)-(height/15))+((baseGroundHeight*0.6)/2))
        {
          if(shapedrawState == 1)
          {
            PVector point = new PVector(mouseX, mouseY);
            singleShapePoints.add(point);
            
            // to block bug
            // you could select closeShape and then delete all points in shape and then 
            // still have closeShape enabled when having under 3 points
            if(singleShapePoints.size() < 3)
            {
              closeShape = false;
            }
          }
        }
      }
      
      //two top Buttons
      if(mouseY >= height/20-(height/12)/2 && mouseY <= height/20+(height/12)/2)
      {
        //clear Frame Button
        if(mouseX >= width/8-(width/4)/2 && mouseX <= width/8+(width/4)/2)
        {
          deleteAllPhysicsObjects();
          deleteLists();
        }
        //save Frame Button
        if(mouseX >= (width/8)*7-(width/4)/2 && mouseX <= (width/8)*7+(width/4)/2)
        {
          //save the PShape-Coordinates to an external file
          if(!saving && shapedrawState != 1)
          {
            //save a thumbnail
            //image(baseGround, width/2, height/2-height/60, baseGroundWidth, baseGroundHeight);
            PImage img;
            noCursor(); 
            img = get(int(width/2-baseGroundWidth/2), int((height/2-height/60)-baseGroundHeight/2), int(baseGroundWidth), int(baseGroundHeight));
            String ss = "save" + str(saveindex) + ".png";
            if(width != 1280 && height != 720)
            {
              img.resize(482, 684);
            }
            img.save(sketchPath("data/saved/thumbnails/" + ss));
            saving = true;
            thread("saveGround");
          }
        }
      }
      //two Bottom Buttons
      if(mouseY >= (height-height/20)-(height/12)/2 && mouseY <= (height-height/20)+(height/12)/2)
      {
        //Del last Shape Button
        if(mouseX >= width/8-(width/4)*2 && mouseX <= width/8+(width/4)*2)
        {
          if(shapedrawState != 1)
          {
            if(allShapes.size() > 0)
            {
              allShapePoints.remove(allShapePoints.size()-1);
              allShapeTypes.pop();
              allShapes.remove(allShapes.size()-1);
            }
          }
        }
        //loadGround Button
        if(mouseX >= (width/8)*7-(width/4)*2 && mouseX <= (width/8)*7+(width/4)*2)
        {
          loadstate = 1;
          //thread("loadGround");
        }
      }
    }
    if(loadstate == 1)
    {
      //load button
      if(mouseX >= (width/16)*6-width/16 && mouseX <= (width/16)*6+width/16 && mouseY >= (height/4)*3-height/32 && mouseY <= (height/4)*3+height/32)
      {
        loadstate = 2;
        thread("loadGround");
      }
      
      //cancel button
      if(mouseX >= (width/16)*10-width/16 && mouseX <= (width/16)*10+width/16 && mouseY >= (height/4)*3-height/32 && mouseY <= (height/4)*3+height/32)
      {
        loadstate = 0;
      }
      
      //left scroll
      if(mouseX >= width/4 && mouseX <= width/2 && mouseY >= (height/5)*2 && mouseY <= (height/5)*3)
      {
        if(thumbnail_selection > 0)
        {
          thumbnail_selection--;
        }
        else
        {
          thumbnail_selection = thumbnails.size()-1;
        }
      }
      
      //right scroll
      if(mouseX >= width/2 && mouseX <= (width/4)*3 && mouseY >= (height/5)*2 && mouseY <= (height/5)*3)
      {
        if(thumbnail_selection < thumbnails.size()-1)
        {
          thumbnail_selection++;
        }
        else
        {
          thumbnail_selection = 0;
        }
      }
    }    
  }
}
