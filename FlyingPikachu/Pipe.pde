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

  void show() {
    image(rockPipe, xPos, yPos, objWidth, objHeight);
  }

  void move() {
    xPos = xPos + xVelocity;
    if (xPos + objWidth < 0) {
      reset();
    }
  }

  void reset() {
    counted = false;
    xPos = width;
    yPos = chooseYPos();
  }

  float chooseYPos() {
    int location = (int)random(2);
    if (location == 0) {
      return 0;
    } else {
      return height - objHeight;
    }
  }
}