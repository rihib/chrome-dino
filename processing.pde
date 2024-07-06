/*
要件
- ChromeのDinosaur Gameをアレンジしたもの - chrome://dino
- Spaceでジャンプ
- ジャンプの時は対空時間と移動するX軸とY軸を変数とする
- 障害物との衝突判定 - https://developer.mozilla.org/ja/docs/Games/Techniques/2D_collision_detection
- ゲームが進むにつれて障害物の速度が加速していく
- 障害物の種類を複数用意する（高低、幅の違い）
- 避けた障害物の数をスコアとする
- 衝突したらスコアとGAME OVERという文字とRetryボタンを表示する
- クラスを使うようにリファクタする
*/

/*
A-----B
|     |
|     |
C-----D
*/

final int DISPLAY_WIDTH = 800;
final int DISPLAY_HEIGHT = 400;
final int GROUND_Y = DISPLAY_HEIGHT - 50;
final int DINO_WIDTH = 60;
final int DINO_HEIGHT = 120;
final int OFFSET = 50;
final int OBSTACLE_WIDTH = 40;
final int OBSTACLE_HEIGHT = 80;
final int OBSTACLE_SPEED = 5;
final int JUMP_HEIGHT = 400;
final int JUMP_DURATION = 50;

Ground ground;
Dino dino;
Obstacle obstacle;

int dinoAX, dinoAY;
int dinoBX, dinoBY;
int dinoCX, dinoCY;
int dinoDX, dinoDY;
int obstacleAX, obstacleAY;
int obstacleBX, obstacleBY;
int obstacleCX, obstacleCY;
int obstacleDX, obstacleDY;
int currJumpDuration;
boolean isJumping;

// Jump_old
int jumpSpeed = 15;
int fallSpeed = 2;
int gravity = 1;

void settings() {
  size(DISPLAY_WIDTH, DISPLAY_HEIGHT);
}

void setup() {
  ground = new Ground();
  dino = new Dino();
  obstacle = new Obstacle();
  
  //dino
  dinoAX = dinoCX = OFFSET;
  dinoBX = dinoDX = dinoAX + DINO_WIDTH;
  dinoAY = dinoBY = GROUND_Y - DINO_HEIGHT;
  dinoCY = dinoDY = GROUND_Y;
  
  // obstacle
  obstacleAX = obstacleCX = DISPLAY_WIDTH;
  obstacleBX = obstacleDX = obstacleAX + OBSTACLE_WIDTH;
  obstacleAY = obstacleBY = GROUND_Y - OBSTACLE_HEIGHT;
  obstacleCY = obstacleDY = GROUND_Y;
  
  // Jump
  currJumpDuration = 0;
  isJumping = false;
}

void draw() {
  background(255);
  ground.show();
  dino.show();
  dino.jump();
  obstacle.show();
  obstacle.move();
  collision();
}

class Ground {
  void show() {
    line(0, GROUND_Y, DISPLAY_WIDTH, GROUND_Y);
  }
}

class Dino {
  void show() {
    rect(dinoAX, dinoAY, DINO_WIDTH, DINO_HEIGHT);
  }
  
  void jump() {
    if (isJumping) {
      if (JUMP_DURATION < currJumpDuration) {
        dinoAY = GROUND_Y - DINO_HEIGHT;
        currJumpDuration = 0;
        isJumping = false;
        return;
      }
      if (currJumpDuration <= JUMP_DURATION / 2) {
        dinoAY -= JUMP_HEIGHT / JUMP_DURATION;
      }
      if (JUMP_DURATION / 2 < currJumpDuration) {
        dinoAY += JUMP_HEIGHT / JUMP_DURATION;
      }
      currJumpDuration++;
    }
  }
}

class Obstacle {
  void show() {
    rect(obstacleAX, obstacleAY, OBSTACLE_WIDTH, OBSTACLE_HEIGHT);
  }
  
  void move() {
    obstacleAX -= OBSTACLE_SPEED;
    if (obstacleBX < 0) {
      obstacleAX = DISPLAY_WIDTH;
    }
    obstacleBX = obstacleAX + OBSTACLE_WIDTH;
  }
}

void collision() {
  if (false) {
    noLoop();
  }
}

void keyPressed() {
  if (key == ' ' && !isJumping) {
    isJumping = true;
  }
}
