class Player {
  float xPos;
  float yPos;
  float objWidth;
  float objHeight;
  float yVelocity;
  float jumpImpulse;
  float gravity;
  PImage pikachu;

  Player() {
    pikachu = loadImage("flyingPikachu.png");
    yVelocity = 0;
    jumpImpulse = -9;
    gravity = 0.5;
    objWidth = pikachu.width;
    objHeight = pikachu.height;
    xPos = 50;
    yPos = (height/2) - objHeight;
  }

  void show() {
    image(pikachu, xPos, yPos, objWidth, objHeight);
  }

  void move() {
    yVelocity = yVelocity + gravity;
    yPos = yPos + yVelocity;
  }

  void jump() {
    yVelocity = jumpImpulse;
  }
}