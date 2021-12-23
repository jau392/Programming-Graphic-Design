class Enemy {
 
  //load enemy dog image
  PImage dog2 = loadImage("dog2.png");
  PImage dog3 = loadImage("dog3.png");
  
  //store desired image size             
  int standardWidth = 50;
  int standardHeight = 50;
  
  int rand = int(random(0, 2));
  int EstartX, EstartY;
  
  //store values to simulate gravity
  float v = 0.025;
  float a = 0.3;
  float friction = 0.999;
  
 
 
  Enemy(int startX, int startY) {
    EstartX = startX;
    EstartY = startY;
  }
  
  
  
  
  void show() {
    dog2.resize(standardWidth, standardHeight);
    dog3.resize(standardWidth, standardHeight);
    
    
    if (rand == 1) {
      image(dog2, EstartX, EstartY);
    } else {
      image(dog3, EstartX, EstartY);
    }
  }
 
  
  
  
  void move() {
    if (EstartX < 750) {
      EstartX += 2;
    }
    if (EstartX > 749) {
      EstartX = -50;
    }
    
    v += a;   //constant accelaration is gravity
    v *= friction; //add friction
    EstartY += v;
  
    if (EstartY > (740)) {
      v = -v;
    }
    
    //loop the ball drop
    if (EstartY > height) {
      EstartY = 0;
    }
  
    if (rand == 1) {
      image(dog2, EstartX, EstartY);
    } else {
      image(dog3, EstartX, EstartY);
    }
    
    float sx = screenX(EstartX, EstartY);
    float sy = screenY(EstartX, EstartY);
    update(sx, sy);
    
  }
 
 
 
 
  void update(float sx, float sy) {
    float xRangeR = x + 50;
    float xRangeL = x - 50;
    float yRangeU = y - 50;
    float yRangeD = y + 50;
    
    if (xRangeL < sx && sx < xRangeR) {
      if (yRangeU < sy && sy < yRangeD) {
        score -= 30;
        EstartX = 0;
        EstartY = int(random(0, 750));
      }
    }
  }
}
