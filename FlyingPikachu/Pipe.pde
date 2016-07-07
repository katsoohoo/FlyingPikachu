class Pipe {
  float xPos;
  float yPos;
  float objWidth;
  float objHeight;
  boolean counted;
  float xVelocity;
  PImage rockPipe;

  Pipe(int num) {
    rockPipe = loadImage("rockPipe.png");
    xVelocity = -5;
    counted = false;
    objWidth = rockPipe.width;
    objHeight = rockPipe.height;
    xPos = width + (num * (width/2));
    yPos = chooseYPos();
  }

  // Show pipe
  void show() {
    image(rockPipe, xPos, yPos, objWidth, objHeight);
  }

  // Move pipe across screen
  void move() {
    xPos = xPos + xVelocity;
    if (xPos + objWidth < 0) {
      reset();
    }
  }

  // Reset pipe to end of screen
  void reset() {
    counted = false;
    xPos = width;
    yPos = chooseYPos();
  }

  // Randomize pipe to either top or bottom
  float chooseYPos() {
    int location = (int)random(2);
    if (location == 0) {
      return 0;
    } else {
      return height - objHeight;
    }
  }
}