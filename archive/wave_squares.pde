void setup() {
  size(500, 500);
  rectMode(CENTER);
  noFill();
}

void draw() {
  background(255);
  
  for (int j = 0; j < 10; j++) {
    for (int i = 0; i < 10; i++) {
      float maxSize = 50;
      float minSize = 10;
      float sizeRange = maxSize - minSize;
      
      float size = minSize + sizeRange * 0.5 * (1 + sin(frameCount * 0.1 - (i + j) * 0.2));
      
      int x = width / 20 + i * width / 10;
      int y = height / 20 + j * height / 10;
      
      stroke(0, j * 25, i * 25);
      strokeWeight(5 - size / 10);
      rect(x, y, size, size);
    }
  }
}
