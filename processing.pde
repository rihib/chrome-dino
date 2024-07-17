Ground ground;
Dino dino;
Obstacle obstacle;

int groundY;
int score;
int speed;
boolean isJumping;
boolean isMoonMode;

PFont font;

void settings() {
  size(1200, 750);
}

void setup() {
  groundY = height / 2;
  score = 0;
  speed = 10;
  isJumping = false;
  isMoonMode = false;
  
  ground = new Ground(10);
  dino = new Dino(50);
  obstacle = new Obstacle(width);
  
  font = loadFont("HanziPenSC-W5-48.vlw");
  textFont(font);
}

void draw() {
  background(255);
  ground.show();
  dino.show();
  dino.jump(300, 50);
  obstacle.show();
  obstacle.move();
  collision();
  
  fill(95, 99, 104);
  textSize(32);
  textAlign(RIGHT, TOP);
  text("Score: " + score + "  Speed: " + speed, width - 20, groundY - 300);
}

class Ground {
  int offsetY;
  
  Ground(int offsetY) {
    this.offsetY = offsetY;
  }
  
  void show() {
    stroke(95, 99, 104);
    strokeWeight(3);
    line(0, groundY - this.offsetY, width, groundY - this.offsetY);
  }
}

class Dino extends Entity {
  float velocityY;
  float gravity = 0.98;
  int jumpPower = 25;
  
  Dino(int originX) {
    super(new int[][]{
      {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0} ,
      {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1} ,
      {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1} ,
      {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1} ,
      {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1} ,
      {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1} ,
      {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0} ,
      {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0} ,
      {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0} ,
      {1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0} ,
      {1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0} ,
      {1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0} ,
      {1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0} ,
      {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0} ,
      {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0} ,
      {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0} ,
      {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0} ,
      {0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0} ,
      {0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0} ,
      {0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} ,
      {0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} ,
      {0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} ,
      {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} ,
      {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0} ,
    } , originX);
  }
  
  void jump(int maxHeight, int hangTime) {
    if (isMoonMode) {
      gravity = 0.162;
      jumpPower = 10;
    }
    if (isJumping) {
      if (originY > initOriginY()) {
        velocityY = 0;
        originY = initOriginY();
        isJumping = false;
      } else {
        velocityY += gravity;
        originY += velocityY;
      }
    }
  }
}

class Obstacle extends Entity {
  Obstacle(int originX) {
    super(new int[][]{
      {0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} ,
      {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0} ,
      {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0} ,
      {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0} ,
      {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0} ,
      {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0} ,
      {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0} ,
      {0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0} ,
      {0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0} ,
      {0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0} ,
      {0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0} ,
      {0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0} ,
      {0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0} ,
      {0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0} ,
      {0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0} ,
      {0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0} ,
      {0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0} ,
      {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0} ,
      {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0} ,
      {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0} ,
      {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0} ,
      {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0} ,
      {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0} ,
      {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0} ,
      {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0} ,
      {0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0} ,
    } , originX);
  }
  
  void move() {
    this.originX -= speed;
    if (this.originX + pixels[0].length * pixelSize < 0) {
      this.originX = width;
      score++;
      if (score % 5 == 0) {
        speed++;
      }
    }
  }
}

abstract class Entity {
  int[][] pixels;
  int pixelSize;
  int originX;
  int originY;
  
  Entity(int[][] pixels, int originX) {
    this.pixels = pixels;
    this.pixelSize = 4;
    this.originX = originX;
    this.originY = initOriginY();
  }
  
  void show() {
    noStroke();
    for (int i = 0; i < pixels.length; i++) {
      for (int j = 0; j < pixels[0].length; j++) {
        if (pixels[i][j] == 1) {
          fill(95, 99, 104);
          rect(this.originX + j * pixelSize, originY + i * pixelSize, pixelSize, pixelSize);
        }
      }
    }
  }
  
  int initOriginY() {
    return groundY - pixels.length * pixelSize;
  }
}

void collision() {
  int dinoWidth = dino.pixels[0].length * dino.pixelSize;
  int dinoHeight = dino.pixels.length * dino.pixelSize;
  int obstacleWidth = obstacle.pixels[0].length * obstacle.pixelSize;
  int obstacleHeight = obstacle.pixels.length * obstacle.pixelSize;
  
  if (dino.originX < obstacle.originX + obstacleWidth && dino.originX + dinoWidth > obstacle.originX && 
    dino.originY < obstacle.originY + obstacleHeight && dino.originY + dinoHeight > obstacle.originY) {
    for (int i = 0; i < dino.pixels.length; i++) {
      for (int j = 0; j < dino.pixels[i].length; j++) {
        if (dino.pixels[i][j] == 1) {
          int dinoPixelX = dino.originX + j * dino.pixelSize;
          int dinoPixelY = dino.originY + i * dino.pixelSize;
          for (int k = 0; k < obstacle.pixels.length; k++) {
            for (int l = 0; l < obstacle.pixels[k].length; l++) {
              if (obstacle.pixels[k][l] == 1) {
                int obstaclePixelX = obstacle.originX + l * obstacle.pixelSize;
                int obstaclePixelY = obstacle.originY + k * obstacle.pixelSize;
                if (dinoPixelX == obstaclePixelX && dinoPixelY == obstaclePixelY) {
                  noLoop();
                  fill(95, 99, 104);
                  textSize(64);
                  textAlign(CENTER, CENTER);
                  text("GAME OVER!!", width / 2, groundY - 100);
                  return;
                }
              }
            }
          }
        }
      }
    }
  }
}


void keyPressed() {
  if (key == ' ' && !isJumping) {
    isJumping = true;
    dino.velocityY = -dino.jumpPower;
  }
  if (key == 'm' && !isJumping) {
    isMoonMode = true;
  }
}
