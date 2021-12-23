PImage swole_doge;
PImage cheems;
PImage pause_image;
PImage starting_image;
PImage winning_image;
PImage losing_image;
PImage pausing_image;
PFont title;
PFont subtitle;




void resetGUI () {
  st_red = 127;
  st_green = 127;
  st_blue = 10;
}




void initScreen() {
    if (userName == null || userName.isEmpty()) {
    starting_image = loadImage("launchscreen.png");
    background(255);
    image(starting_image, 0, 0, 800, 800);
    textAlign(CENTER);
    fill(10);
    title = createFont("Pixellettersfull-BnJ5.ttf", 70, true);
    subtitle = createFont("Pixellettersfull-BnJ5.ttf", 30, true);
    textFont(title);
    text("It is a doge eat doge", 415, 100);
    text("world out there", 405, 135);
    
    textSize(24);
    fill(0,0, 600);
    textSize(50);
    text("Enter a name here", (width/3)+134, (1.75*height/5)+95);
    text = cp5.addTextfield("").setFont(title).setSize(50, 50).setPosition(200, 400).setSize(400, 50).setAutoClear(true).setColorCaptionLabel(color(0, 0, 0));
    text.getCaptionLabel();
    bang = cp5.addBang("Submit").setFont(subtitle).setSize(50, 50).setPosition(200, (6 * height /9)-20).setSize(80, 40).setColorCaptionLabel(color(0, 0, 0));
    bang.getCaptionLabel();

  }
  if(gameWon) {
   gameLevel++; 
  }
  gameWon = false; // reset to !gameWon
}




void gameOverScreen() {
  resetGUI();
  // the top 5 display no matter of win/lose
  Table top5_table = loadTable("new.csv", "header");
  
  if(gameWon) {
    winning_image = loadImage("winning_background.png");
    background(255);
    image(winning_image, 0, 0, 800, 800);
    fill(0);
    textAlign(CENTER);
    textSize(48);
    text("Congrats, "+userName+", what a pogchamp! \n the Doge is no more!", width - 400, 200);
    text("Click anywhere to play again.", width - 400, 550);
    text("High Scores:", (width-675), 7*height/9);
    swole_doge = loadImage("swole_doge.png");
    image(swole_doge, 275,260, 240,240);
  } 
  
  else { // <==> if gameLost
    gameLevel = 0;
    losing_image = loadImage("losing_background.png");
    background(255);
    image(losing_image, 0,0,800,800);
    fill(255);
    textAlign(CENTER);
    textSize(48);
    text("Sorry, "+userName+", You Lose! \n You are more of a meme than doge! ", width - 400, 200);
    text("Click anywhere to play again.", width - 400, 550);
    text("High Scores:", (width-675), 7*height/9);
    cheems = loadImage("cheems.png");
    image(cheems, 275,260, 240,240);
 
  }
  
  // NEW - high scores (these print regardless of win or lose)
  textAlign(CORNER);
  int n = 0;
  for (TableRow row : top5_table.rows()) {
    score = row.getInt("score");
    String this_user = row.getString("player");
    // width changes, height does not
    text((n+1)+":   "+score+"  "+this_user, width-500, 7*height/9 + n*34);
    n++;
  }

}




void pause() {
    pausing_image = loadImage("pause_background.png");
    image(pausing_image, 0,0, 800,800);
    fill(255);
    textAlign(CENTER);
    textSize(48);
    text("Game is paw-sed!", width - 420, 3*height/9);
    text("Press c to unpaw-se.", width - 420, 6*height/9);
    pause_image = loadImage("pause_image.png");
    image(pause_image, 265,260, 240,240);
}
