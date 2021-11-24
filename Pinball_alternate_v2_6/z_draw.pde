//normal draw loop
void draw()
{
  background(0);
  //GAMESTATE sets function to go to(Gamelogic Main)
  switch(GAME_STATE)
  {
  case 0: 
    loading();
    break;

  case 1:
    if(menue_first_time)
    {
      menue_playback.loop();
      menue_first_time = false;
      camConfigure_first_time = true;
      colorConfigure_first_time = true;
      playEndCut_firsttime = true;
      game_first_time = true;
      endCut_played = false;
      scoreHandled = false;
      addEntry = false;
      toolbar_State = 0;
      lifesAdded = false;
      name = "";
      board_updated = false;
      if(player.isPlaying())
      {
        player.pause();
        player.rewind();
      }
      men_player.play();
      //deleteAllPhysicsObjects();
      //deleteLists();
      //may move this to update and display after the game has ended
      //updateScoreboard();
    }
    menue();
    break;

  case 2:
    if(camConfigure_first_time)
    {
      info = true;
      menue_playback.stop();
      menue_first_time = true;
      camConfigure_first_time = false;
    }
    readme();
    break;

  case 3:
    if(colorConfigure_first_time)
    {
      colorConfigureInfo = true;
      menue_playback.stop();
      menue_first_time = true;
      colorConfigure_first_time = false;
    }
    editMode();
    break;

  case 4:
    if(game_first_time)
    {
      menue_playback.stop();
      menue_first_time = true;
      game_first_time = false;
      lifes = 3;
      score = 0;
      //println("starting thread..");
      thread("imgAnalyze");
      displayobjects = true;
      ball = new Ball((width/40)*27, (height/20)*18, width/200);
      //endScreen_video.jump(0);
      endScreen_video = new Movie(this, "ending.mp4");
      if(men_player.isPlaying())
      {
        men_player.pause();
        men_player.rewind();
      }
      player.play();
    }
    game();
    break;

  default:
    menue();
    break;
  }
  //print("GAMESTATE: "+GAME_STATE);
}
