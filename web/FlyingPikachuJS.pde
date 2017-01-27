// Processing.js version of FlyingPikachu

Player thePlayer;
Pipe pipeOne;
Pipe pipeTwo;
PImage background;
Audio bgMusic;
Audio pika;
Audio pikaLose;
int height = 500;
int width = 500;
int score;
int gameState; // 0 = start, 1 = running, 2 = over

void setup() {
  size(500, 500);
  textAlign(CENTER);
  thePlayer = new Player();
  pipeOne = new Pipe(1);
  pipeTwo = new Pipe(2);
  background = loadImage("data/background.jpg");
  bgMusic = new Audio("data/bgMusic.wav");
  pika = new Audio("data/pika.wav");
  pikaLose = new Audio("data/pikaLose.wav");
  score = 0;
  gameState = 0;
  bgMusic.loop = true;
  bgMusic.play();
}

void draw() {
  image(background, 0, 0);
  if (gameState == 0) {
    gameStart();
  } else if (gameState == 1) {
    gameRun();
  } else { // gameState == 2
    gameOver();
  }
}

void gameRun() {
  // PHYSICS
  thePlayer.move();
  pipeOne.move();
  pipeTwo.move();

  // GAME LOGIC
  // increase score if passed pipe
  if (pipeOne.xPos + pipeOne.objWidth < thePlayer.xPos && pipeOne.counted == false) {
    score = score + 1;
    pipeOne.counted = true;
    pika.play();
  }
  if (pipeTwo.xPos + pipeTwo.objWidth < thePlayer.xPos && pipeTwo.counted == false) {
    score = score + 1;
    pipeTwo.counted = true;
    pika.play();
  }

  // game over if collision with pipe
  if (thePlayer.xPos < pipeOne.xPos + pipeOne.objWidth && thePlayer.xPos + thePlayer.objWidth > pipeOne.xPos 
    && thePlayer.yPos < pipeOne.yPos + pipeOne.objHeight && thePlayer.yPos + thePlayer.objHeight > pipeOne.yPos) {
    gameState = 2;
    pikaLose.play();
  }
  if (thePlayer.xPos < pipeTwo.xPos + pipeTwo.objWidth && thePlayer.xPos + thePlayer.objWidth > pipeTwo.xPos 
    && thePlayer.yPos < pipeTwo.yPos + pipeTwo.objHeight && thePlayer.yPos + thePlayer.objHeight > pipeTwo.yPos) {
    gameState = 2;
    pikaLose.play();
  }

  // game over if out of screen
  if (thePlayer.yPos < 0 || thePlayer.yPos + thePlayer.objHeight > height) {
    gameState = 2;  
    pikaLose.play();
  }

  // DISPLAY GRAPHICS
  thePlayer.show();
  pipeOne.show();
  pipeTwo.show();
  fill(0);
  textSize(30);
  text(score, width/2, 60);
}

void gameStart() {
  thePlayer.show();
  textSize(40);
  fill(50);
  text("Flying Pikachu", width/2, 80);
  textSize(20);
  text("Press space to start", width/2, 475);
}

void gameOver() {
  thePlayer.show();
  pipeOne.show();
  pipeTwo.show();

  textSize(30);
  fill(0);
  text(score, width/2, 60);
  textSize(50);
  text("Game Over", width/2, height/2);
  textSize(20);
  text("Press r to restart", width/2, height/2 + 30);
}

void resetGame() {
  thePlayer = new Player();
  pipeOne = new Pipe(1);
  pipeTwo = new Pipe(2);
  score = 0;
  gameState = 1; 
}

void keyPressed() {
  if (gameState == 0 && key == ' ') {
    gameState = 1;
  }
  if (gameState == 2 && key == 'r') {
    resetGame();
    thePlayer.jump();
  }
  if (gameState == 1 && key == ' ') {
    thePlayer.jump();
  }
}

class Pipe {
  float xPos;
  float yPos;
  float objWidth;
  float objHeight;
  boolean counted;
  float xVelocity;
  PImage rockPipe;

  Pipe(int num) {
    rockPipe = loadImage("data/rockPipe.png");
    xVelocity = -5;
    counted = false;
    objWidth = 50;
    objHeight = 250;
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
    pikachu = loadImage("data/flyingPikachu.png");
    yVelocity = 0;
    jumpImpulse = -9;
    gravity = 0.5;
    objWidth = 45;
    objHeight = 48;
    xPos = 50;
    yPos = (height/2) - objHeight;
  }

  // Show player
  void show() {
    image(pikachu, xPos, yPos, objWidth, objHeight);
  }

  // Move player down with gravity
  void move() {
    yVelocity = yVelocity + gravity;
    yPos = yPos + yVelocity;
  }

  // Player jumps
  void jump() {
    yVelocity = jumpImpulse;
  }
}