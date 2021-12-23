class Friend {
 
  //load friendly dog image
  PImage dog1 = loadImage("dog1.png");

  //store desired image size            
  int standardWidth = 30;
  int standardHeight = 30;
  
  int EstartX, EstartY;
  float angle = 0;
  
 
 
 
  Friend(int startX, int startY) {
    EstartX = startX;
    EstartY = startY;
  }
  
  
  
  
  void show() {
    //Resize all the images to size based on score
    dog1. resize(standardWidth, standardHeight);
    
    image(dog1, EstartX, EstartY);
    
    float sx = screenX(EstartX, EstartY);
    float sy = screenY(EstartX, EstartY);
    update(sx, sy);
  }
  
  
  
  
  void update(float sx, float sy) {
    float xRangeR = x + 40;
    float xRangeL = x - 40;
    float yRangeU = y - 40;
    float yRangeD = y + 40;
    
    if (xRangeL < sx && sx < xRangeR) {
      if (yRangeU < sy && sy < yRangeD) {
        score += 20;
        EstartX = int(random(0, 800));
        EstartY = int(random(0, 800));
      }
    }
  }
}
