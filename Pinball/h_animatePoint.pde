//calculates point positions for the loading function
float animate_point(float startX, float endX, float startTime, float endTime)
{
  float percent_anim;

  long zeit = millis();

  //vor Beginn der Animation?
  if (zeit < startTime)
    return startX;

  if (zeit > endTime)
    percent_anim = 1.0;
  else
    percent_anim = (zeit-startTime) / (endTime - startTime);

  return percent_anim*(endX - startX) + startX;
}
