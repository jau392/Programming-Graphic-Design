// use CSV to display top 5 scores and update them as needed. KEEP IN ORDER!
// order will eliminate the need for an array. CSV contains id=0,score,player
Table table;
TableRow row, newRow;

// required libraries
import java.util.Arrays;
import java.util.Collections;

import controlP5.*;
ControlP5 cp5;
controlP5.Bang bang;
controlP5.Textfield text;
String userName;
User userOne;
boolean run = true;
float position;
float r, x, y, angle, mag, current;
int score;
PImage bg;

//initialize Friend class 
int startX, startY;
int populationSize = 8;
Friend [] FriendGroup = new Friend[populationSize];

//initialize FriendTwo class
FriendTwo [] FriendTwoGroup = new FriendTwo[populationSize];

//initialze Enemy class
Enemy [] EnemyGroup = new Enemy[populationSize];


// victory, defeat and GUI notes:
// GUI for high score and current score
// Defeat&Victory screens: final score, option of "try again". vict=100
// initial screen: informs player of rules and controls
// friend += 20. enemy += 20 or += 50, depending on type

boolean error; // to detect if score went down or not
int st_red;
int st_green;
int st_blue;

int account; // what the hell is the use of this
int start;
int time;
boolean gameOver = false;
boolean gameWon = false;
boolean gameLost = true;
int gameScreen = 0; // will display initScreen, gameOver, etc.
// optional
int gameTime = 30 * 1000;
int gameLevel = 1;
// end optional
boolean pause = false;

// test int variable to detect scorechange
String str, high_str;
int init_score;
int high_score; // this updates in real time if/when it's higher than CSV high
// csv_high only for comparison purposes
int csv_high;

// REMOVE - ghetto fix
boolean first_round = true;

// SOUND ~~~~~~~~~~~~~
// NEW MUSIC SECTION
// Music Credit:
// http://www.dl-sounds.com/royalty-free/time-portal/
import processing.sound.*;
SoundFile file;
boolean mute = false; // on keyPressed('m'), sound mutes

void setup() {
  size(800,800);
  resetGUI();
  
  // play music function
  // NEW MUSIC SECTION
  file = new SoundFile(this, "music.mp3");
  playMusic();
  
  // get all-time high score
  table = loadTable("new.csv", "header");
  csv_high = get_csv_high(); // only needed once
  score = 0;
  
  cp5 = new ControlP5(this);
  userOne = new User(30);
  initScreen();
  
  //Friend class
  for (int i = 0; i < FriendGroup.length; i++) {
    //set starting positions
    startX = int(random(0, 800));
    startY = int(random(0, 800));
    
    FriendGroup[i] = new Friend(startX, startY);
  }
  
  //FriendTwo class
  for (int i = 0; i < FriendTwoGroup.length; i++) {
    startX = int(random(-300, 300));
    startY = int(random(-300, 300));
    
    FriendTwoGroup[i] = new FriendTwo(startX, startY);
  }
  
  //Enemy class
   for (int i = 0; i < EnemyGroup.length; i++) {
    //set starting positions
    startX = 0;
    startY = int(random(0, 750));
    
    EnemyGroup[i] = new Enemy(startX, startY);
  }
}




void Submit() {
  // FIXME: see below
  userName = cp5.get(Textfield.class, "").getText(); // this NEEDS to be run in setup(), otherwise uses previous!
  bang.hide();
  text.hide();
  gameScreen = 1;
  bg = loadImage("dogecoin space elon musk.png");
}




void draw () {
  // pause can be handled with loop() and noLoop() if needed
  init_score = score; // NOTE:init comes at beginning, before any potential score changes
  
  if (pause == false) { // only run draw if game is unpaused, i.e. if "r" typed
    if (gameScreen == 0) {
      //if (mousePressed) {
      //  gameScreen = 1; // run the "else {}" body
      //}
    }
    
    else { // if NOT paused
      if (run) {
        background(bg);
        userOne.update();
      //some implementation with userOne absorbing all the circles around it. 
      
      } 
      else {
        noLoop(); // redundant
      }
      
      for (int i = 0; i < FriendGroup.length; i++) {
        FriendGroup[i].show();
      }
      
      for (int i = 0; i < FriendTwoGroup.length; i++) {
        FriendTwoGroup[i].show();
        FriendTwoGroup[i].spin();
        FriendTwoGroup[i].sparkle();
      }
      
      for (int i = 0; i < EnemyGroup.length; i++) {
        EnemyGroup[i].show();
        EnemyGroup[i].move();
      }
      
      // FIXME: this scores when UCObject moves into or away from an object
      // NOT when an enemy/friend just runs into the UCObject
      // need to handle this case  
      
      score(); // last thing in draw
    }
  }
  if (gameOver) {
    first_round = false;
    gameOverScreen(); // display top 5 here
    if (mousePressed) {
      // reset score but KEEP high score, even if it's negative
      gameOver = false;
      score = 0;
    }
  }
}




// CSV functions ~~~
// read CSV and get all-session high score from it
// this runs only once, in setup
int get_csv_high() {
  // initialize
  csv_high = 0;
  for (TableRow row : table.rows()) {
    score = row.getInt("score");
    if (score > csv_high) {
      csv_high = score;
    }
  }
  return csv_high;
}




// p or s keys for control
void keyPressed() {
  if (key == 'p') {
    run = false;
    pause = true;
    pause();
    //print("game is paused");
  
  } else if (key == 'c') {
    pause = false;
    run = true;
    //print("game is started");
  } 
  
   else if (key == 'e') {
    // exit game
    //print("game is started");
  }
  
  else if (key == 'm' && gameScreen != 0) {
    if (mute) {
      mute = false;
    } else {
      mute = true;
    }
    playMusic();
  }
  
  else {
    userOne.keyPressed();
  }

}




// NEW MUSIC SECTION
void playMusic() {
  if (mute == false) {
    file.play();
  } else {
    file.pause();
  }
}




void keyReleased() {
  userOne.keyReleased();

}
