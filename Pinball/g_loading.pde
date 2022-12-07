//displays the loading screen until all objects are loaded
void loading()
{ 
  //einmal am Anfang setzen
  if(first_load)
  {
    start_anim_cycle = millis();
    anim_cycle = start_anim_cycle + 800;
    first_load = false;
  }
  
  //loading animation and start other thread to load content
  textSize(width/20);
  fill(255);
  textAlign(CENTER);
  if (millis() >= current_dot_time + dot_wait/3)
  {
    dot_one = true;
    dot_two = false;
    dot_three = false;
  }

  if (millis() >= current_dot_time + (dot_wait/3)*2)
  {
    dot_one = false;
    dot_two = true;
    dot_three = false;
  }

  if (millis() >= current_dot_time + dot_wait)
  {
    dot_one = false;
    dot_two = false;
    dot_three = true;
    if (millis() >= (current_dot_time + dot_wait) + dot_wait)
      current_dot_time = millis();
  }

  if (dot_one)
    text("Loading.", width/2, (height/4)*3);
  if (dot_two)
    text("Loading..", width/2, (height/4)*3);
  if (dot_three)
    text("Loading...", width/2, (height/4)*3);

  //animate shape-thing over loading text(only line yet)
  strokeWeight(5);
  stroke(255);
  
  
  if(calculate_points)
  {
    for(int i = 0;  i < 16; i++)
    {
      xpoints[i] = random((width/8)*3, (width/8)*5);
      ypoints[i] = random((height/8)*3, (height/8)*5);
    }
    
    calculate_points = false;
  }
  
  float x1 = animate_point(xpoints[0], xpoints[1], start_anim_cycle, anim_cycle);
  float y1 = animate_point(ypoints[0], ypoints[1], start_anim_cycle, anim_cycle);
  float x2 = animate_point(xpoints[2], xpoints[3], start_anim_cycle, anim_cycle);
  float y2 = animate_point(ypoints[2], ypoints[3], start_anim_cycle, anim_cycle);
  float x3 = animate_point(xpoints[4], xpoints[5], start_anim_cycle, anim_cycle);
  float y3 = animate_point(ypoints[4], ypoints[5], start_anim_cycle, anim_cycle);
  float x4 = animate_point(xpoints[6], xpoints[7], start_anim_cycle, anim_cycle);
  float y4 = animate_point(ypoints[6], ypoints[7], start_anim_cycle, anim_cycle);
  float x5 = animate_point(xpoints[8], xpoints[9], start_anim_cycle, anim_cycle);
  float y5 = animate_point(ypoints[8], ypoints[9], start_anim_cycle, anim_cycle);
  float x6 = animate_point(xpoints[10], xpoints[11], start_anim_cycle, anim_cycle);
  float y6 = animate_point(ypoints[10], ypoints[11], start_anim_cycle, anim_cycle);
  float x7 = animate_point(xpoints[12], xpoints[13], start_anim_cycle, anim_cycle);
  float y7 = animate_point(ypoints[12], ypoints[13], start_anim_cycle, anim_cycle);
  float x8 = animate_point(xpoints[14], xpoints[15], start_anim_cycle, anim_cycle);
  float y8 = animate_point(ypoints[14], ypoints[15], start_anim_cycle, anim_cycle);
  
  //draw lines between points
  line(x1, y1, x2, y2);
  line(x2, y2, x3, y3);
  line(x3, y3, x4, y4);
  line(x4, y4, x5, y5);
  line(x5, y5, x6, y6);
  line(x6, y6, x7, y7);
  line(x7, y7, x8, y8);
  line(x8, y8, x1, y1);
  
  if(millis() >= anim_cycle)
  {
    start_anim_cycle = millis();
    anim_cycle = start_anim_cycle + 800;
    
    calculate_points = true;
  }
}
