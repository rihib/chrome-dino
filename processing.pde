/*
chrome://dino
*/

/*
TODO:
- display the number of obstacles avoided as the score
- display Game Over and Retry button, score when collision occurs
- ignore 0 pixels in Dino and Obstacle for collision detection
- speed up the obstacle as the game progresses
- prepare multiple types of obstacles (different heights and widths)
- use SAT for collision detection (https://developer.mozilla.org/ja/docs/Games/Techniques/2D_collision_detection)
*/

Ground ground;
Dino dino;
Obstacle obstacle;

int groundY;
int score;
int elapsedTime;
boolean isJumping;

void settings() {
  size(800, 600);
}

void setup() {
  groundY = height - 50;
  
  ground = new Ground(10);
  dino = new Dino(50);
  obstacle = new Obstacle(width);
  
  score = 0;
  elapsedTime = 0;
  isJumping = false;
}

void draw() {
  background(255);
  ground.show();
  dino.show();
  dino.jump(300, 50);
  obstacle.show();
  obstacle.move(10);
  collision();
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
    } , 5, originX);
  }
  
  void jump(int maxHeight, int hangTime) {
    if (isJumping) {
      if (hangTime < elapsedTime) {
        originY = initOriginY();
        elapsedTime = 0;
        isJumping = false;
        return;
      }
      int halfTime = hangTime / 2;
      if (elapsedTime <= halfTime) {
        originY -= maxHeight / halfTime;
      }
      if (halfTime < elapsedTime) {
        originY += maxHeight / halfTime;
      }
      elapsedTime++;
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
    } , 5, originX);
  }
  
  void move(int speed) {
    this.originX -= speed;
    if (this.originX + pixels[0].length * pixelSize < 0) {
      this.originX = width;
      score++;
    }
  }
}

abstract class Entity {
  int[][] pixels;
  int pixelSize;
  int originX;
  int originY;
  
  Entity(int[][] pixels, int pixelSize, int originX) {
    this.pixels = pixels;
    this.pixelSize = pixelSize;
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
    noLoop();
  }
}

void keyPressed() {
  if (key == ' ' && !isJumping) {
    isJumping = true;
  }
}
