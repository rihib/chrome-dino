let ground;
let dino;
let obstacle;

let groundY;
let score;
let speed;
let isJumping;
let isMoonMode;

let font;

function setup() {
  createCanvas(1200, 750);
  groundY = height / 2;
  score = 0;
  speed = 10;
  isJumping = false;
  isMoonMode = false;

  ground = new Ground(10);
  dino = new Dino(50);
  obstacle = new Obstacle(width);
}

function draw() {
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
  text(`Score: ${score}  Speed: ${speed}`, width - 20, groundY - 300);
}

class Ground {
  constructor(offsetY) {
    this.offsetY = offsetY;
  }

  show() {
    stroke(95, 99, 104);
    strokeWeight(3);
    line(0, groundY - this.offsetY, width, groundY - this.offsetY);
  }
}

class Entity {
  constructor(pixels, originX) {
    this.pixels = pixels;
    this.pixelSize = 4;
    this.originX = originX;
    this.originY = this.initOriginY();
  }

  show() {
    noStroke();
    for (let i = 0; i < this.pixels.length; i++) {
      for (let j = 0; j < this.pixels[0].length; j++) {
        if (this.pixels[i][j] === 1) {
          fill(95, 99, 104);
          rect(this.originX + j * this.pixelSize, this.originY + i * this.pixelSize, this.pixelSize, this.pixelSize);
        }
      }
    }
  }

  initOriginY() {
    return groundY - this.pixels.length * this.pixelSize;
  }
}

class Dino extends Entity {
  constructor(originX) {
    super([
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0] ,
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1] ,
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1] ,
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1] ,
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1] ,
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1] ,
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0] ,
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0] ,
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0] ,
      [1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0] ,
      [1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0] ,
      [1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0] ,
      [1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0] ,
      [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0] ,
      [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0] ,
      [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0] ,
      [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0] ,
      [0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0] ,
      [0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0] ,
      [0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] ,
      [0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] ,
      [0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] ,
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] ,
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    ], originX);
    this.velocityY = 0;
    this.gravity = 0.98;
    this.jumpPower = 25;
  }

  jump(maxHeight, hangTime) {
    if (isMoonMode) {
      this.gravity = 0.162;
      this.jumpPower = 10;
    }
    if (isJumping) {
      if (this.originY > this.initOriginY()) {
        this.velocityY = 0;
        this.originY = this.initOriginY();
        isJumping = false;
      } else {
        this.velocityY += this.gravity;
        this.originY += this.velocityY;
      }
    }
  }
}

class Obstacle extends Entity {
  constructor(originX) {
    super([
      [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] ,
      [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0] ,
      [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0] ,
      [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0] ,
      [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0] ,
      [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0] ,
      [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0] ,
      [0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0] ,
      [0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0] ,
      [0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0] ,
      [0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0] ,
      [0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0] ,
      [0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0] ,
      [0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0] ,
      [0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0] ,
      [0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0] ,
      [0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0] ,
      [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0] ,
      [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0] ,
      [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0] ,
      [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0] ,
      [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0] ,
      [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0] ,
      [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0] ,
      [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0] ,
      [0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    ], originX);
  }

  move() {
    this.originX -= speed;
    if (this.originX + this.pixels[0].length * this.pixelSize < 0) {
      this.originX = width;
      score++;
      if (score % 5 === 0) {
        speed++;
      }
    }
  }
}

function collision() {
  let dinoWidth = dino.pixels[0].length * dino.pixelSize;
  let dinoHeight = dino.pixels.length * dino.pixelSize;
  let obstacleWidth = obstacle.pixels[0].length * obstacle.pixelSize;
  let obstacleHeight = obstacle.pixels.length * obstacle.pixelSize;

  if (dino.originX < obstacle.originX + obstacleWidth &&
      dino.originX + dinoWidth > obstacle.originX &&
      dino.originY < obstacle.originY + obstacleHeight &&
      dino.originY + dinoHeight > obstacle.originY) {
    for (let i = 0; i < dino.pixels.length; i++) {
      for (let j = 0; j < dino.pixels[i].length; j++) {
        if (dino.pixels[i][j] === 1) {
          let dinoPixelX = dino.originX + j * dino.pixelSize;
          let dinoPixelY = dino.originY + i * dino.pixelSize;
          for (let k = 0; k < obstacle.pixels.length; k++) {
            for (let l = 0; l < obstacle.pixels[k].length; l++) {
              if (obstacle.pixels[k][l] === 1) {
                let obstaclePixelX = obstacle.originX + l * obstacle.pixelSize;
                let obstaclePixelY = obstacle.originY + k * obstacle.pixelSize;
                if (dinoPixelX === obstaclePixelX && dinoPixelY === obstaclePixelY) {
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

function keyPressed() {
  if (key === ' ' && !isJumping) {
    isJumping = true;
    dino.velocityY = -dino.jumpPower;
  }
  if (key === 'm' && !isJumping) {
    isMoonMode = true;
  }
}
