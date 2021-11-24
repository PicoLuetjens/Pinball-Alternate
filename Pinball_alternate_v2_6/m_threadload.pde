//load all objects in the background when game is started(gets called in another thread)
void thread_load()
{
  //endScreen_video = new Movie(this, "ending.mp4");
  //endScreen_video.loop();

  menue_playback = new Movie(this, "menu.mov");
  //menue_playback.loop();
  
  scoreboard = loadTable("scoreboard.csv", "header");
  
  name = new String();
  //name ="";
  
  
  
  int savecount;
  File f = new File(sketchPath("data/saved/thumbnails"));
  if(f.list().length > 0)
    savecount = f.list().length;
  else
    savecount = 0;
    
  //man muss alles in die richtige reihenfolge bringen, falls durcheinander und neu benennen, falls es lücken gibt(save03, save05, save06...)
  //hatte probleme mit java.io.File.renameTo() unter windows(kann man aber sicher noch besser programmieren, wollte aber die reihenfolge ohne Lücken
  //beibehalten)
  if(savecount > 0)
  {
    String[]filenames = f.list();
    PImage thmb;
    for(int i = 0; i < savecount; i++)
    {
      thmb = loadImage("data/saved/thumbnails/" + filenames[i]);
      thumbnails.add(thmb);
      
      if(i == savecount-1)
      {
        //wir müssen den höchsten index rausbekommen falls dateien zwischendrin 
        //gelöscht wurden ist sonst der for loop offset
        String sub = filenames[i].substring(4);
        split(sub, ".");
        int in = int(sub);
        if(in > savecount)
          saveindex = in;
        else
          saveindex = savecount;
      }
    }
    //println("fileamount: " + filenames.length);
    //println("saveindex: " + saveindex);
  }
    
  baseGround = loadImage("Pinball Arena.png");
  
  scale_factor = baseGround.height/(height*0.95);
  baseGroundWidth = baseGround.width/scale_factor;
  baseGroundHeight = baseGround.height/scale_factor;
  
  if(width == 1920)
  {
    fl = new Paddle(1.098788*baseGroundWidth, 0.84999967*baseGroundHeight, 25, -QUARTER_PI/2, QUARTER_PI, true, 15, 10, 100);
    fr = new Paddle(1.551204*baseGroundWidth, 0.84999967*baseGroundHeight, 25, -QUARTER_PI/2, QUARTER_PI, false, 15, 10, 100);
  }
  else if(width == 1280)
  {
    fl = new Paddle(1.098788*baseGroundWidth, 0.84999967*baseGroundHeight, 25, -QUARTER_PI/2, QUARTER_PI, true, 8, 5, 80);
    fr = new Paddle(1.551205*baseGroundWidth, 0.84999967*baseGroundHeight, 25, -QUARTER_PI/2, QUARTER_PI, false, 8, 5, 80);
  }
  
  //keeps paddles in correct position
  rflip = true;
  lflip = true;
  
  men_player = minim.loadFile("Kevin MacLeod- Happy Bee.mp3");
  player = minim.loadFile("music.mp3");
  men_player.setGain(-10);
  
  GAME_STATE = STATE_MENUE;
}
