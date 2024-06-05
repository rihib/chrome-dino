void setup() {
  size(800, 800);
  background(255);
  noLoop();
  noStroke();
  drawCircle(width / 2, height / 2, 400);
}

void drawCircle(float x, float y, float radius) {
  fill(random(255), random(255), random(255), 150);
  ellipse(x, y, radius * 2, radius * 2);
  
  if (radius > 10) {
    float newRadius = radius / 2;
    drawCircle(x + newRadius, y, newRadius);
    drawCircle(x - newRadius, y, newRadius);
    drawCircle(x, y + newRadius, newRadius);
    drawCircle(x, y - newRadius, newRadius);
  }
}
