//displays the gameinfo(when you press Info)
void readme()
{
  //print("cam_selection: " + cam_selection);
  //go here from menue when you need to select your cam, it will just cicle through and display the cams
  
  
  if(info)
  {
    text("Infos/Instructions:", width/2, height/7);
    text("first you need to create a ground to play on", width/2, (height/7)*2);
    text("to do that you need to go to 'EDITMODE'", width/2, (height/7)*3);
    text("by clicking on the type you select the type of wall", width/2, (height/7)*4);
    text("you are creating an obstacle with", width/2, (height/7)*5);
    text("Press Enter to continue", width/2, (height/7)*6);
  }
  else
  {
    text("set points of the obstacle by left-clicking", width/2, height/5);
    text("to close an obstacle select 'close Shape'", width/2, (height/5)*2);
    text("when you are done with one Shape click 'Shape Done'", width/2, (height/5)*3);
    text("hit 'M' to go back to menue", width/2, (height/5)*4);
  }
}
