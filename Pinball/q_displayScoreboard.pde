//displays the scoreboard in the end
void displayScoreBoard()
{
  //debug
  //println("playernames-size: " + playernames.size());
  background(0);
  String player;
  String score;
  //String complete;
  fill(255);
  text("Current Leaderboard", width/2, height/20);
  for(int i = 0; i < scores.size(); i++)
  {
    player = playernames.get(i);
    
    
    if(scores.get(i) < 1000000000)
    {
      score = str(scores.get(i));
    }
    
    else
    {
      score = "to High for datatype";
    }
    
    //display scores
    text(i+1 + ".", width/4, (height/19)*(4+i));
    
    text(player, (width/4)*2, (height/19)*(4+i));
    
    text(score, (width/4)*3, (height/19)*(4+i));
    
    //complete = str((i+1)) + "." + "  " + player + "  " + score;
    //text(complete, width/3, (height/19)*(4+i));
  }
}
