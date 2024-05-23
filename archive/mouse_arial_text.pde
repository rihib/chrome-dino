String s = "";
PFont font;

void setup() {
  size(500, 500);
  fill(0);
  textSize(40);
  font = createFont("Arial", 24);
  textFont(font);
}

void draw() {
  background(255);
  textAlign(CENTER);
  text(s, mouseX, mouseY, width - mouseX, height - mouseY);
}

void keyPressed() {
  if (key == BACKSPACE && s.length() > 0) {
    s = s.substring(0, s.length() - 1);
    return;
  }
  
  s += key;
}
