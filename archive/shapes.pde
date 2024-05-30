float elapsedTime = 0, time = 0, timeStamp = 0;
int state = 0;

void setup() {
  size(800, 500);
  noStroke();
  rectMode(CENTER);
}

void draw() {
  elapsedTime = float(millis()) / 1000;
  time = elapsedTime - timeStamp;
  background(255);
  switch(state) {
    case 0:
      fill(255, 120, 180,(3 - time) * 255);
      ellipse(width / 2, height / 2, 100 * time, 100 * time);
      if (time >= 3.0) {
        state = 1;
        timeStamp = elapsedTime;
      }
      break;
    case 1:
      fill(120, 180, 255,(2 - time) * 255);
      rect(width / 2, height / 2, 100 * time, 100 * time);
      if (time >= 2.0) {
        state = 2;
        timeStamp = elapsedTime;
      }
      break;
    case 2:
      fill(180, 255, 120,(3 - time) * 255);
      rect(width / 2, height / 2, time * width / 3, time * height / 3);
      if (time >= 3.0) {
        state = 3;
        timeStamp = elapsedTime;
      }
      break;
    case 3:
      fill(255, 180, 120,(4 - time) * 255);
      triangle(width / 2, height / 2 - 100 * time, width / 2 - 100 * time, height / 2 + 100 * time, width / 2 + 100 * time, height / 2 + 100 * time);
      if (time >= 4.0) {
        state = 4;
        timeStamp = elapsedTime;
      }
      break;
    case 4:
      fill(180, 120, 255,(2 - time) * 255);
      beginShape();
      for (int i = 0; i < 5; i++) {
        float angle = TWO_PI / 5 * i + time * TWO_PI;
        float x = width / 2 + cos(angle) * 100;
        float y = height / 2 + sin(angle) * 100;
        vertex(x, y);
      }
      endShape(CLOSE);
      if (time >= 2.0) {
        state = 0;
        timeStamp = elapsedTime;
      }
      break;
  }
}
