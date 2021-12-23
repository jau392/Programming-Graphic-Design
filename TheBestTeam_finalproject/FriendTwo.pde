class FriendTwo {
  float angle = random(0, TWO_PI);
  float size = 10;
  float spark;
  int randR = int(random(0, 255));
  int randG = int(random(0, 255));
  int randB = int(random(0, 255));
  
  //initialize floats for the ellipse at the center of the star
  float centerX, centerY;
  float centerRadius;
  
  //initialize floats for the string rays off the star
  float ray1;
  float ray2;
  float ray3;
  float ray4;
  
  
  
  
  FriendTwo(int startX, int startY){
    centerRadius = 4;
    centerX = startX;
    centerY = startY;
  }
  
  
  
  
  void spin() {
    float change = random(-0.005, 0.02);
    angle += change;
  }
  
  
  
  
  void sparkle() {
    float change = random(0, 20);
    size = change;
  }
  
  
  
  
  void show() {
    pushMatrix();
    
    translate(width/2, height/2);
    rotate(angle);
      
    //draw line shaped rays
    stroke(255,255,204);
    line(centerX, centerY, centerX, centerY-size);
    line(centerX, centerY, centerX, centerY+size);
    line(centerX, centerY, centerX-size, centerY);
    line(centerX, centerY, centerX+size, centerY);
    stroke(0);
      
    //draw ellipse
    strokeWeight(1);
    noFill();
    stroke(randR, randG, randB);
    fill(randR, randG, randB);
    ellipse(centerX, centerY, centerRadius, centerRadius);
    strokeWeight(2);
    float sx = screenX(centerX, centerY);
    float sy = screenY(centerX, centerY);
    update(sx, sy);
    popMatrix();
  }
  
  
  
  
  void update(float sx, float sy) {
    float xRangeR = x + 40;
    float xRangeL = x - 40;
    float yRangeU = y - 40;
    float yRangeD = y + 40;
    
    if (xRangeL < sx && sx < xRangeR) {
      if (yRangeU < sy && sy < yRangeD) {
        score += 30;
        centerX = int(random(-300, 300));
        centerY = int(random(-300, 300));
      }
    }
  }
}
