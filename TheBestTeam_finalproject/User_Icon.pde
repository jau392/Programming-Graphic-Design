class User {
PImage user = loadImage("user_doge.png");
int right = 0;
int left = 0;
int up = 0;
int down = 0;
color col;
int numEaten, frames;
boolean [] input;
boolean alive, powered;
boolean cooldown = false;
boolean active = false;
int cooldownTime = 10;
int activeTime = 180;
String type = "player";

  User(float _r) {
    r = _r;
    current = random(0,20);
    angle = random(0,2*PI);
    x = random(0,1000);
    y = random(0,1000);
    mag = 2;
    user.resize(50, 50);
    
    col = color(140,140,140);
    numEaten = 0;
    
    alive = true;
    powered = true;
    position = 0;
    frames = 10000;
  }
  
  void keyPressed() {
    if (key == ' ' && cooldown == false) {
      mag*=2;
      active = true;
      cooldown = true;
      frames = 10;
      cooldownTime = 0;
    
    }
    if (keyCode == LEFT) {
      left = 1;
      //print("left pressed");
    } else if (keyCode == RIGHT) {
      right = 1;
      //print("right pressed");

    } else if (keyCode == UP) {
      up = 1;
     //print("up pressed");

    } else if (keyCode == DOWN) {
      down = 1;
      //print("down pressed");
    }
  
  }
  
  void keyReleased() {
      if (keyCode == LEFT) {
      left = 0;
    } else if (keyCode == RIGHT) {
      right = 0;
    } else if (keyCode == UP) {
      up = 0;
    } else if (keyCode == DOWN) {
      down = 0;
    }
  
  }
  
  void update () {
  
    if (alive) {
      ellipseMode(RADIUS);
      updateAngle();
      
      if (angle != -1) {
        x += mag*cos(angle);
        y += mag*sin(angle);
      
      }
      
      if (y > height) {
        y = 0;
       
      } else if (y < 0) {
        y = height;
      
      }
      
      if (x > width) {
        x = 0;
      
      } else if (x < 0) {
        x = width;
      
      }
      fill(col);
      if (powered) {
        fill (0,0,100);
        image(user, x, y);
        position += .05;
        frames -=1;
        if (frames <= 0) {
        
          powered = false;
        }
        
        fill(255);      
      }
    
    }
  
  
 }

  void updateAngle() {
    if (right + left + up + down == 0) {
      angle = -1;    
      
     } else {
       int xDir = right - left;
       int yDir = down - up;
       angle = atan2(yDir,xDir);
     
     }
  
  }
  
  void updateCircle() {
    if (active) {
      activeTime -= 1;
      if (activeTime <=0) {
        mag /=1.1;
        active = false;
      }
    }
    if (cooldown) {
      cooldownTime += 1;
      if (cooldownTime >= 200) {
        cooldown = false;
      }
    
    }
    
    fill(10);
    rect(200,10,100,5);
    fill (255);  
  }
  


}
