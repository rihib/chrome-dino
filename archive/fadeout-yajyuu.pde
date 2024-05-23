PImage img;

void setup() {
  img = loadImage("yajyuu.png");
  size(1000, 1000);
  noStroke();
}

void draw() {
  background(0);
  colorMode(HSB, 255);
  img.loadPixels();
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.pixels[y * img.width + x];
      float b = brightness(c);
      color newColor = color(hue(c), saturation(c), b + random( -50, 50));
      img.pixels[y * img.width + x] = newColor;
    }
  }
  img.updatePixels();
  image(img, 0, 0);
  colorMode(RGB, 255);
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    saveFrame("fadeout-scream_####.png");
  }
}
