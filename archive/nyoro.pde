void setup() {
  size(500, 500);
  noStroke();
}

void draw() {
  background(0);
  nyoro(10, width / 3 , height / 3);
  nyoro(20, width, height / 4);
  nyoro(35, width * 2, 2 * height / 3);
}

void nyoro(int n, int x, int y) {
  for (int i = 0; i < n; i++) {
    ellipse(
      x - i * n * width / 500,
      y + 50 * cos(radians(i * n)),
     (n - i) * 2,
     (n - i) * 2
     );
  }
}
