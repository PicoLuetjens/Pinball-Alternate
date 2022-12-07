//plays the end-Video after the game has ended and the name entered
void playEndCut()
{
  if(playEndCut_firsttime)
  {
    endScreen_video.play();
    playEndCut_firsttime = false;
  }
  imageMode(CENTER);
  image(endScreen_video, width/2, height/2);
  imageMode(CORNER);
  
  if(endScreen_video.time() >= endScreen_video.duration()-0.5)
  {
    endCut_played = true;
    endScreen_video.stop();
  }
}
//overrides the old scoreboard with the new which contains the new entry(maybe add to the existing one
//would be better here)
void handleScoreboardEntry()
{
  fill(50, 50, 50);
  rectMode(CENTER);
  rect(width/2, height/2, width/2, height/2);
  rectMode(CORNER);
  fill(0);
  text("Enter your name(max. 7):" , width/2, (height/20)*9);
  text(name , width/2, (height/20)*11);
  //println("name: "+name);
  
  //debug
  //addEntry = true;
  if(addEntry)
  {
    int thisScore = score;
    String thisName = name;
    TableRow row = scoreboard.addRow();
    row.setString("Player", thisName);
    row.setInt("Score", thisScore);
    saveTable(scoreboard, "data/scoreboard.csv");
    scoreHandled = true;
  }
}

//removes last letter of the entry when you press Backspace
String removeLastChar(String s)
{
    return (s == null || s.length() == 0)
      ? ""
      : (s.substring(0, s.length() - 1));
}
