//displays the menue
void menue()
{
  noCursor();
  //debug testing
  //noCams_connected = false;
  strokeWeight(5);
  textAlign(CENTER);
  
 
    
  image(menue_playback, 0, 0, width, height);



  //menu auswahl
  noStroke();
  fill(50, 50, 50, 150);
  rect(0, 0, width, (height/8)*2);
  stroke(255);
  textSize(width/40);
  fill(255);
  text("PLAY", width/5, height/8);
  text("INFO", (width/5)*2, height/8);
  text("EDITMODE", (width/5)*3, height/8);
  text("EXIT", (width/5)*4, height/8);

  noFill();
  rectMode(CENTER);
  if (selection == 1)
  {
    rect(width/5, height/9, width/10, height/12, 10);
  } else if (selection == 2)
  {
    rect((width/5)*2, height/9, width/10, height/12, 10);
  } else if (selection == 3)
  {
    rect((width/5)*3, height/9, width/6, height/12, 10);
  } else if (selection == 4)
  {
    rect((width/5)*4, height/9, width/10, height/12, 10);
  }
  rectMode(CORNER);
  
}
