/*
要件
- ChromeのDinosaur Gameをアレンジしたもの - chrome://dino
- Spaceでジャンプ
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

// ground
int groundY;

// dino
int dinoWidth, dinoHeight;
int dinoAX, dinoAY;
int dinoBX, dinoBY;
int dinoCX, dinoCY;
int dinoDX, dinoDY;

// obstacle
int obstacleWidth, obstacleHeight;
int obstacleAX, obstacleAY;
int obstacleBX, obstacleBY;
int obstacleCX, obstacleCY;
int obstacleDX, obstacleDY;

// action
boolean isJumping = false;
boolean isFalling = false;
int jumpSpeed = 10;
int fallSpeed = 5;
int gravity = 1;
int jumpHeight = 15;
int obstacleSpeed = 5;

void setup() {
  size(800, 400);
  
  // ground
  groundY = height - 50;
  
  // dino
  dinoWidth = 20;
  dinoHeight = 40;
  dinoAX = dinoCX = 50;
  dinoBX = dinoDX = dinoAX + dinoWidth;
  dinoAY = dinoBY = groundY - dinoHeight;
  dinoCY = dinoDY = groundY;
  
  // obstacle
  obstacleWidth = 20;
  obstacleHeight = 40;
  obstacleAX = obstacleCX = width;
  obstacleBX = obstacleDX = obstacleAX + obstacleWidth;
  obstacleAY = obstacleBY = groundY - obstacleHeight;
  obstacleCY = obstacleDY = groundY;
}

void draw() {
  background(255);
  drawGround();
  drawDino();
  drawObstacle();
  moveObstacle();
  checkCollision();
  handleJump();
}

void drawGround() {
  line(0, groundY, width, groundY);
}

void drawDino() {
  rect(dinoAX, dinoAY, dinoWidth, dinoHeight);
}

void drawObstacle() {
  rect(obstacleAX, obstacleAY, obstacleWidth, obstacleHeight);
}

void moveObstacle() {
  obstacleAX -= obstacleSpeed;
  if (obstacleBX < 0) {
    obstacleAX = width;
  }
  obstacleBX = obstacleAX + obstacleWidth;
}

void checkCollision() {
  if (false) {
    noLoop();
  }
}

void handleJump() {
 ;
}

void keyPressed() {
  if (key == ' ' && !isJumping && !isFalling) {
    isJumping = true;
  }
}
