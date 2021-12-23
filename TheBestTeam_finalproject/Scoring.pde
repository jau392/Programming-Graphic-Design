// detect gameWon, gameLost, and new high score
void score() {
  color stroke_color; // local variable for score textbox strokecolor
  
  if (score >= 200) { // WIN gameover
    top5(score);
    table = loadTable("new.csv", "header"); // correct every time after first run
    get_csv_high();
    gameWon = true;
    gameOver = true;
  }
  else if (score <= -110) { // LOSE gameover; high score won't change but top5 might
    top5(score);
    table = loadTable("new.csv", "header");
    get_csv_high();
    gameLost = true;
    gameOver = true;
  }

  if (init_score < score) {
    high_score = score;
    error = false;
    st_red -= 40;
    st_blue += 20;
    st_green += 40;
  } else if (init_score > score) { // if (error)
    error = true;
    st_red += 40;
    st_blue -= 2;
    st_green -= 40;
  }
  
  if (abs(score) < 20) {
    resetGUI();
  }

  // high_score is now updated, but what if cvs_high is higher?
  // ==> make high_score equal to this csv_high
  if (high_score < csv_high) {
    high_score = csv_high;
  }
  
  // modify stroke color by game performance (score)
  stroke_color = color(st_red, st_green, st_blue);
  
  // END
  
  // VISUAL GUI code ; plain grey rect+textbox at top left
  textSize(24);
  //String str, high_str;
  str = "Score: " + score;
  high_str = "High Score: " + high_score;
  String instructions = "Use arrows to move. Press p to pause. Press m to mute music.";
  int strSize = (int)textWidth(str);
  fill(255);
  stroke(stroke_color);
  rect(5, 5, strSize+40, 20, 7); // rect to hold string text (current score)
  // first at X,Y=5,5
  // so second at X = 5 + 10 + strSize, Y=5
  rect(100 + strSize, 5, (int)textWidth(high_str)+40, 20, 7); // rect to hold HIGH score
  
  int instruction_length = (int)textWidth(instructions);
  fill(255);
  rect(5,35, instruction_length+40, 20, 7);
  fill(0);
  noStroke();
  
  
  // FIXME: increase text(X) by a few units to move right
  // condition below fixes a small glitch
  if (first_round) {
    text(str, 45, 20);
    text(high_str, 166 + strSize, 20);
    text(instructions, 275, 50);
  }
  else {
    text(str, 10, 20);
    text(high_str, 105 + strSize, 20);
    text(instructions, 10, 50);

  }
}




// top 5 handler: when gameOver, check if score belongs in top 5
// FIXME: add in parameter of the NAME of the user, for addition to the CSV
void top5(int high_score) {
  // get the index that this high score belongs at
  int high_score_index = 0;
  
  for (TableRow row : table.rows()) { // note ':' is "in" for Java
    int row_score = row.getInt("score");
    if (row_score > high_score) {
      high_score_index++; // this is the CSV index that we want to replace at
    }
  }
  
  // if the score doesn't even make top 5, do nothing (return)
  if (high_score_index == 5) {
    return;
  }
  
  // we now have index 0 through 4 that marks the index of replacement
  table.setInt(high_score_index, "id", high_score_index);
  table.setInt(high_score_index, "score", high_score);
  table.setString(high_score_index, "player", userName); // FIXME: name
  saveTable(table, "new.csv"); // save every highscores but the original as new.csv
}
