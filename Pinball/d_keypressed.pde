// handles all key-Events
void keyPressed()
{
  if (GAME_STATE == STATE_MENUE)
  {

    if (noCams_connected == false)
    {
      //selection detection
      if (keyCode == RIGHT && selection < 4)
        selection++;

      else if (keyCode == RIGHT && selection == 4)
        selection = 1;

      else if (keyCode == LEFT && selection > 1)
        selection--;

      else if (keyCode == LEFT && selection == 1)
        selection = 4;

      if (key == ENTER)
      {
        switch(selection)
        {
        case 1: 
          GAME_STATE = STATE_PLAYING;
          break;
        case 2:
          GAME_STATE = STATE_README;
          break;
        case 3:
          GAME_STATE = STATE_EDITMODE;
          break;
        case 4:
          exit();
        }
      }
    } else
    {
      if (key == ENTER)
        exit();
    }
  }
  
  if(GAME_STATE == STATE_README)
  {
    if(info)
    {
      if(keyCode == ENTER)
      {
        info = false;
      }
    }
    
    if(key == 'M' || key == 'm')
    { 
       GAME_STATE = STATE_MENUE; 
    }
    
  }
  
  if(GAME_STATE == STATE_EDITMODE)
  {
    if(colorConfigureInfo)
    {
      if(keyCode == ENTER)
      {
        colorConfigureInfo = false;
      }
    }
    if(key == 'M' || key == 'm')
    { 
       GAME_STATE = STATE_MENUE; 
       //clean up all left points when breaking up in process
       if(singleShapePoints.size() > 0)
       {
         singleShapePoints.clear();
       }
    }
  }
  
  
  if(GAME_STATE == STATE_PLAYING)
  {
    if(keyCode == 't' || keyCode == 'T')
    {
      if(!toolbar)
        toolbar = true;
      else if(toolbar)
        toolbar = false;
    }
    
    //name input after game has ended
    //if(endCut_played && !scoreHandled)
    if(!scoreHandled)
    {
      if(keyCode >= 'A' && keyCode <= 'Z')
      {
        name = name + key;
      }
      else if(keyCode == BACKSPACE)
      {
        name = removeLastChar(name);
      }
      else if(keyCode == ENTER)
      {
        if(name.length() <= 7 && name.length() >= 1)
        {
          addEntry = true;
        }
      }
    }
    
    if(endCut_played)
    {
      if(keyCode == ENTER)
      {
        GAME_STATE = STATE_MENUE;
      }
    }
    
    if(keyCode == RIGHT && rflip)
    {
      fr.reverseSpeed();
      rflip = false;
    }
    if(keyCode == LEFT && lflip)
    {
      fl.reverseSpeed();
      lflip = false;
    }
  }
}

//resets paddles
void keyReleased( )
{
  if(GAME_STATE == STATE_PLAYING)
  {
    if(keyCode == RIGHT && !rflip)
    {
      fr.reverseSpeed();
      rflip = true;
    }
    if(keyCode == LEFT && !lflip)
    {
      fl.reverseSpeed();
      lflip = true;
    }
  }
}
