//displays the editMode
void editMode()
{
  //background(255);
  //go here from menue to configure the colors you are drawing with a color picker
  cursor(ARROW);

  if (colorConfigureInfo)
  {
    fill(255);
    text("this is the 'EDITMODE'", width/2, height/5);
    text("here you create your ground to play", width/2, (height/5)*2);
    text("to start draw just click anywhere in the green rect area of the ground", width/2, (height/5)*3);
    text("when done editing hit 'M' to go back to menue", width/2, (height/5)*4);
  } 
  else 
  {
    background(100);
    //display base ground
    imageMode(CENTER);
    //image(baseGround, width/2, height/2, baseGroundWidth, height);
    image(baseGround, width/2, height/2-height/60, baseGroundWidth, baseGroundHeight);
    imageMode(CORNER);


    //Buttons
    fill(255, 0, 0);
    rectMode(CENTER);
    noStroke();
    rect(width/6, height/5, width/6, height/10, 10);
    rect(width/6, (height/5)*2, width/6, height/10, 10);
    rect(width/6, (height/5)*3, width/6, height/10, 10);
    rect(width/6, (height/5)*4, width/6, height/10, 10);
    //corner buttons
    rect(width/8, height/20, width/4, height/12, 5);
    rect((width/8)*7, height/20, width/4, height/12, 5);
    rect(width/8, height-height/20, width/4, height/12, 5);
    rect((width/8)*7, height-height/20, width/4, height/12, 5);
    fill(0);
    text("New Shape", width/6, height/5 + height/60);
    text("Close Shape", width/6, (height/5)*2 + height/60);
    text("Shape Done", width/6, (height/5)*3 + height/60);
    text("DEL last Point", width/6, (height/5)*4 + height/60);
    text("Clear Frame", width/8, height/20 + height/60);
    text("Save Frame", (width/8)*7, height/20 + height/60);
    text("DEL last Shape", width/8, (height-height/20)+height/60);
    text("Load Frame", (width/8)*7, (height-height/20)+height/60);

    for (int i = 0; i < colors.length; i++)
    {
      fill(colors[i]);
      rect((width/6)*5, (height/(colors.length+1))*(i+1), width/6, height/10, 10);
      fill(0);
      text(texts[i], (width/6)*5, (height/(colors.length+1))*(i+1) + height/60);
    }
    //typeselection rect
    noFill();
    stroke(0, 255, 0);
    rect((width/6)*5, height/(colors.length+1)*(typeselection+1), width/5.9, height/9.9, 10);
    fill(0);


    if (alpha >= 255)
    {
      top_border = true;
      bottom_border = false;
    }
    if (alpha <= 0)
    {
      bottom_border = true;
      top_border = false;
    }

    if (bottom_border)
    {
      alpha+=10;
    }
    if (top_border)
    {
      alpha-=10;
    }
    insiderect = color(0, 255, 0, alpha);
    stroke(insiderect);
    noFill();
    //inside rect
    rectMode(CENTER);
    rect(width/2, height/2-height/15, baseGroundWidth*0.8, baseGroundHeight*0.6);

    fill(255, 0, 0);
    noStroke();

    if (singleShapePoints.size() > 0)
    {
      //display all contoures and if shape is finished display the shape
      for (int i = 0; i < singleShapePoints.size(); i++)
      {
        PVector shapepoint = singleShapePoints.get(i);
        PVector shapepoint2 = new PVector(0, 0);
        if (i < singleShapePoints.size()-1)
        {
          shapepoint2 = singleShapePoints.get(i+1);
        }
        stroke(colors[typeselection]);
        fill(colors[typeselection]);
        ellipse(shapepoint.x, shapepoint.y, width/150, width/150);
        if (i < singleShapePoints.size()-1)
        {
          line(shapepoint.x, shapepoint.y, shapepoint2.x, shapepoint2.y);
        } else
        {
          line(shapepoint.x, shapepoint.y, mouseX, mouseY);
        }
      }
    }

    if (allShapes.size() > 0)
    {
      for (PShape shape : allShapes)
      {
        shape(shape);
        //println("shapesize in edit mode" + allShapes.size());
      }
    }

    if (saving)
    {
      fill(100);
      rect(width/2, height/2, width/4, height/4);
      fill(255);
      text("saving data...", width/2, height/2-width/60);
    }

    if (loadstate == 1)
    {
      fill(60);
      rect(width/2, height/2, width/1.5, height/1.5);
      fill(255, 0, 0);
      rect((width/16)*6, (height/4)*3, width/8, height/16, 5);
      rect((width/16)*10, (height/4)*3, width/8, height/16, 5);
      fill(255);
      text("Select Frame", width/2, (height/16)*3+height/40);
      text("load", (width/16)*6, (height/4)*3+height/60);
      text("cancel", (width/16)*10, (height/4)*3+height/60);
      text("Frame"+thumbnail_selection, (width/4)*3, (height/4));
      text("<", width/4, height/2);
      text(">", (width/4)*3, height/2);
      imageMode(CENTER);
      image(thumbnails.get(thumbnail_selection), width/2, height/2, baseGroundWidth*0.4, baseGroundHeight*0.4);
      imageMode(CORNER);
    }

    if (loadstate == 2)
    {
      fill(60);
      rect(width/2, height/2, width/4, height/4);
      fill(255);
      text("loading data...", width/2, height/2+width/60);
    }
  }
  //println("loadstate: " + loadstate);
}

//saves the current Frame to data(gets called in another thread)
void saveGround()
{
  //per line-> coordinatepoints, ClosedShapeorNot, type
  if (saving)
  {
    try
    {
      Table savedata;
      savedata = new Table();
      //find longest list for setting the column count
      int ll = 0;
      int asl = allShapePoints.size();
      for (ArrayList<PVector> list : allShapePoints)
      {
        if (list.size() > ll)
        {
          ll = list.size();
        }
      }

      //println("ll: " + ll);
      //println("asl: " + asl);

      //also need to save the type and state(+2)
      for (int j = 0; j < ll + 2; j++)
      {
        savedata.addRow();
      }

      //closed or not?
      //savedata.addRow();

      //type
      //savedata.addRow();

      //write data into table object
      for (int col = 0; col < asl; col++)  //cols is equal to amount of shapes
      {
        savedata.addColumn();
        for (int row = 0; row < ll; row++)  //rows is equal to max_amount
        {
          ArrayList<PVector> takelist = allShapePoints.get(col);
          if (row < takelist.size())
          {
            PVector vec = takelist.get(row);
            float x = vec.x/width;
            float y = vec.y/height;
            String gen_str = str(x) + "/" + str(y);
            savedata.setString(row, col, gen_str);
          } else
          {
            savedata.setString(row, col, "&");
            //savedata.setString(row, col, "");
          }
        }
        //closed or not?
        savedata.setInt(ll, col, SCON_List.get(col));
        //types
        savedata.setInt(ll+1, col, allShapeTypes.get(col));
      }
      String ss = "data"+ str(saveindex) + ".csv";
      saveTable(savedata, sketchPath("data/saved/details/" + ss));
    }

    catch(Exception e)
    {
      println(e);
      println("Saving error!!!");
      println("couldn't write game Data to table Data");
      println("resuming without saving...");
      println("INFO: Error occured in editMode -> saveGround() -> saving block");

      //delete the already saved thumbnail file to keep the same index(otherwise there will be no data for some thumbnails)
      String path = "data/saved/thumbnails/save"+saveindex+".png";
      File f = new File(sketchPath(path));
      if (f.exists())
      {
        f.delete();
      }
    }
    saveindex++;
    saving = false;
  }
}

//loads the selected Frame Data into the game(gets called in another thread)
void loadGround()
{
  if (loadstate == 2)
  {
    //println("clear lists");
    deleteAllPhysicsObjects();
    deleteLists();
    File f = new File(sketchPath("data/saved/details"));
    String[] filelist = f.list();
    try
    {
      Table loaddata;
      loaddata = loadTable(sketchPath("data/saved/details/" + filelist[thumbnail_selection]));

      //auslesen(letzte Koordinate muss gelöscht/ignoriert werden->zumindest für das Shape, wenn closed)
      //String str;
      String[] list;
      float convstr, convstr2;
      //PVector vec = new PVector();
      ArrayList<PVector> vecs = new ArrayList();
      int con;
      int type;
      ArrayList<PVector>takelist = new ArrayList();
      //println("columns: " + loaddata.getColumnCount());
      //println("rows: " + loaddata.getRowCount());
      for (int col = 0; col < loaddata.getColumnCount(); col++)
      {
        for (int row = 0; row < loaddata.getRowCount()-2; row++)
        {
          String str = loaddata.getString(row, col);
          //println("String: /" + str + "/");
          if (str.charAt(0) != '&')
          //if (str != "")
          {
            //println("NOT FOUND &");
            PVector vec = new PVector();
            list = split(str, "/");
            //println("list: "+ list[0], list[1]);
            convstr = float(list[0]);
            convstr2 = float(list[1]);
            //println("convstr: "+ convstr);
            //println("convstr2: "+ convstr2);
            vec.x = convstr*width;
            vec.y = convstr2*height;
            //println("vec:"+vec);
            //EDIT: musste beide Listen hier beschreiben, hatte Probleme beim Kopieren einer Liste ohne Referenz
            vecs.add(vec);
            takelist.add(vec);
            //println("VECS-LIST: " + vecs);
            //println("Take-LIST: " + takelist);
            //println("vecs:"+vecs.size());
          }
          else
          {
            //println("FOUND &");
          }
        }
        allShapePoints.add(vecs);
        //takelist = vecs;
        vecs = new ArrayList<PVector>();
        //println("takelist: " + takelist.size());
        //println("vecs: " + vecs.size());
     
        type = loaddata.getInt(loaddata.getRowCount()-1, col);
        //println("type: " + type);
        allShapeTypes.append(type);
        //println("allShapeTypesLength: " + allShapeTypes.size());
        con = loaddata.getInt(loaddata.getRowCount()-2, col);
        //println("con: " + con);
        SCON_List.append(con);
        //println("SCON_size: " + SCON_List.size());
        if (con == 1)
        {
          //println("HERE");
          takelist.remove(takelist.size()-1);
        }
        //println("takelist[4]: "+ takelist.get(4));
        PShape shape = createShape();
        shape.beginShape();
        for (int i = 0; i < takelist.size(); i++)
        {
          //println("takevec: " + takelist.get(i));
          PVector takevec = takelist.get(i);
          shape.vertex(takevec.x, takevec.y);
          //println("takevec.x" + takevec.x);
          //println("takevec.y" + takevec.y);
        }
        if (con == 1)
        {
          shape.fill(colors[type]);
          shape.endShape(CLOSE);
        } 
        else
        {
          shape.stroke(colors[type]);
          shape.noFill();
          shape.endShape();
        }
        allShapes.add(shape);

        /*debug start(testShape)
        PShape s = createShape();
        s.beginShape();    
        s.vertex(300, 600);
        s.vertex(350, 500);
        s.vertex(320, 650);
        s.vertex(130, 200);
        s.vertex(760, 450);
        s.stroke(colors[0]);
        s.noFill();
        s.endShape();
        allShapes.add(s);
        debug end(testShape)
*/
        takelist = new ArrayList<PVector>();
      }
    }

    catch(Exception e)
    {
      println(e);
      println("Loading error!!!");
      println("couldn't load table Data to game Data");
      println("resuming without loading...");
      println("INFO: Error occured in editMode -> loadGround() -> loading block");
    }
  }
  loadstate = 0;
  //println("allShapePoints: " + allShapePoints.size());
  //println("allShapeTypes: " + allShapeTypes.size());
  //println("allShapes: " + allShapes.size());
  //println("loadstate: " + loadstate);
}
