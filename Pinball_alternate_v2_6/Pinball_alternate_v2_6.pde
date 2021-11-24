/*
**2D-Flipper-Game v2.6
**Author: Pico Lütjens
**
**last changed: 27.05.2020
**
**
**
**Resolutions: 1920x1080/ 1280x720
**
**NOTE: Sometimes there is a physics bug where the ballPosition-Update is not fast enough
**
**NOTE: On 1920x1080 resolution there seems to be a bug with the physics updating to slow and 
**resulting in the ball being stuck inside the paddle althogh motorTorque is lower than in 1280x720
**resolution and both are marked as bullet objects..
**
**NOTE: Game runs really slow in 1920x1080 resolution(if you want an fps display go to the j_game file and
**in game() change line 119 where is says "//text("FPS: " + frameRate, (width/20)*19, height/20);" to
**"text("FPS: " + frameRate, (width/20)*19, height/20);"
**
**NOTE: Save- and Load-System doesn't work reliable(sometimes) due to thread issues(java...)
**
**
**TIPP: avoid creating "V"-shaped objects otherwise the ball could get stuck on it
**and you have to go back to menue without continuing the game. The game won't kill
**and reset the ball on itself  -> (/\yes||\/no)
**
**
**CREDITS:
** - https://www.newgrounds.com/audio/listen/554504
** - https://www.youtube.com/watch?v=moqSDF7dz9o
** - https://dribbble.com/shots/3459746-06-Neon-Pinball
**
*/



//Import Lybraries
import processing.video.*;
import ddf.minim.*;
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import java.io.File;

//***Global Variables***
Box2DProcessing box2d;
Minim minim;
AudioPlayer player;
AudioPlayer men_player;
//PrintWriter output;
//BufferedReader reader;

//for displaying Image background
PImage baseGround;
float scale_factor;
float baseGroundWidth;
float baseGroundHeight;

//inside rect(edit mode)
int alpha = 0;
color insiderect = color(0, 255, 0, alpha);
boolean top_border = false;
boolean bottom_border = true;


//Scoreboard 
Table scoreboard;

//display
boolean saving = false;

// 0 = nothing, 1 = select, 2 = loading...
int loadstate =  0;

int saveindex;

ArrayList<PImage>thumbnails = new ArrayList();
ArrayList<Table> details = new ArrayList();

int thumbnail_selection = 0;

//arrayList for players(ganze Liste)
StringList pns = new StringList();

//arrayList for scores(ganze Liste)
IntList scs = new IntList();

//array for players(Anzeige)
StringList playernames = new StringList();

//array for scores(Anzeige)
IntList scores = new IntList();


//Gamestates
byte GAME_STATE;
final byte STATE_LOADING = 0;
final byte STATE_MENUE = 1;
final byte STATE_README = 2;
final byte STATE_EDITMODE = 3;
final byte STATE_PLAYING = 4;


//Menue video playback holder
Movie menue_playback;

//loading video holder
Movie endScreen_video;


//***Loading Variables***

//wartet solange, um nächsten Punkt zu zeichnen
float dot_wait = 1000;

//ist alles geladen?
boolean stuff_loaded = false;

//start-Wert, auf den der nächste Warte-Schritt druafgerechnet wird
float current_dot_time;

//wie lange geht eine Animation vom loading shape
float anim_cycle;

//start zeit des animation Cycles
float start_anim_cycle;

//erstes mal in der Loading schleife
boolean first_load = true;

//neue Punkte für neues Shape im Loading screen berechnen
boolean calculate_points = true;

//points positions
float[] xpoints = new float[16];
float[] ypoints = new float[16];

//booleans für Punkte(nur um nicht immer wieder text über text zu zeichen
boolean dot_one = false;
boolean dot_two = false;
boolean dot_three = false;


//***Menue Variables***

boolean noCams_connected;
int selection = 1;

//need to exist because we need to stop the playback_menue when not in menue and start again 
//when in menue to increase speed performance
boolean camConfigure_first_time = true;
boolean colorConfigure_first_time = true;
boolean game_first_time = true;


//***READ ME Variables***

//Informationen anzeigen am Anfang
boolean info = true;


//if in menue for first time set loop() to play background video
boolean menue_first_time = true;


//***EDIT MODE Variables***

//holds all shapes that are created
ArrayList<PShape> shapes = new ArrayList();

//scorehole, normal, bumper, random
color bumper = color(142, 12, 207), normal = color(31, 147, 153), scorehole = color(16, 19, 224), random = color(219, 172, 15);
color[]colors = {bumper, normal, scorehole, random};
String[]texts = {"Bumper", "Normal", "Score", "Random"};

//displays info in colorconfigure 
boolean colorConfigureInfo = true;

//points of one blob/shape
ArrayList<PVector>singleShapePoints = new ArrayList();

//points of every created blob/shape
ArrayList<ArrayList<PVector>>allShapePoints = new ArrayList();

//holds all shapes
ArrayList<PShape> allShapes = new ArrayList();

//holds all shape types
IntList allShapeTypes = new IntList();

//shape closed or not? -> 0 = false, 1 = true(only necessary for saving)
IntList SCON_List = new IntList();

//***Game Variables***

// 0 = playing, 1 = paused, 2 = ended
int ingame_State = 0;

//if analyze is already done or not
boolean imgAnalyzeDone = false;

// 0 = nothing, 1 = gotoMenue,
int toolbar_State = 0;

boolean toolbar = false;

//0 = nothing, 1 = beginShape, 2 = endShape
int shapedrawState = 0;

// if shape should be closed
boolean closeShape = false;

//the selected type to draw with
int typeselection = 0;

//for not selecting a different type within one shape
boolean typeselectionlocked = false;

//for rendering all objects or not except the ball
boolean renderObjects = false;


//lifes for game(two get added at the beginning by the %score function so you have 4)-> and one if less
int lifes = 2;

//score for game(shoot in scoreholes -> +10 score)/ 100 score -> lifes+1
int score = 0;

//for playing endScreenMovie
boolean playEndCut_firsttime = true;

//for plaing endcut
boolean endCut_played = false;

//for handling score Entry
boolean scoreHandled = false;

//holding player name
String name;

//should a new entry be added?
boolean addEntry = false;

//resets when ball hits in scorehole in collisions()
//boolean scoreholeReset = true;

//objects

//normal boundaries list
ArrayList<Norm_boundary>boundaries_pO = new ArrayList();
//Bumper list
ArrayList<Bumper>bumpers_pO = new ArrayList();
//scoreHole list
ArrayList<Score_Hole>scoreholes_pO = new ArrayList();

//add one life for every 1000 score
boolean lifesAdded = false;


//turning paddles on/off
boolean lflip;
boolean rflip;

PVector take_vec;

//testobjects
Ball ball;

Paddle fl;
Paddle fr;

boolean displayobjects = true;

//updated leaderboard?
boolean board_updated = false;

//setup function
void setup()
{
  //size(1920, 1080);
  size(1280, 720);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  if(width == 1920)
    //box2d.setGravity(0, -200);
    box2d.setGravity(0, -80);
  else if(width == 1280)
    box2d.setGravity(0, -20);
  //box2d.listenForCollisions();
  GAME_STATE = STATE_LOADING;
  current_dot_time = millis();
  minim = new Minim(this);
  noCursor();
  
  
  //test
  //ball = new Ball((width/40)*27, (height/20)*18, width/200);

  //load other data in other thread while display loading screen in this thread
  thread("thread_load");
}
