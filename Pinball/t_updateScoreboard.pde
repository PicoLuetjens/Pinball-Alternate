//this updates the scoreoard in the beginning or after a new entry
void updateScoreboard()
{
  //clear all 
  if(pns.size() > 0)
  {
    pns.clear();
  }
  
  if(scs.size() > 0)
  {
    scs.clear();
  }
  
  if(playernames.size() > 0)
  {
    playernames.clear();
  }
  
  if(scores.size() > 0)
  {
    scores.clear();
  }
  
  
  int listObjectAmount = 0;
  for(TableRow row : scoreboard.rows())
  {
    String player = row.getString("Player");
    int score = row.getInt("Score");
    
    pns.append(player);
    scs.append(score);
    
  }
  if(pns.size() > 15)
  {
    while(listObjectAmount < 15)
    {
      for(int i = 0; i < scs.size(); i++)
      { 
          int max = scs.max();
          
          //find index in list
          if(scs.get(i) == max)
          {
            scores.append(scs.get(i));
            playernames.append(pns.get(i));         
            pns.remove(i);
            scs.remove(i);
            listObjectAmount++;
          }
        
      }
    }
  }
  else
  {
    int count = pns.size();
    while(listObjectAmount < count)
    {
      for(int i = 0; i < scs.size(); i++)
      { 
          int max = scs.max();
          
          //find index in list
          if(scs.get(i) == max)
          {
            scores.append(scs.get(i));
            playernames.append(pns.get(i));         
            pns.remove(i);
            scs.remove(i);
            listObjectAmount++;
          }
        
      }
    }
  }
}
