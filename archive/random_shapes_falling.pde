ArrayList<Shape> shapes;

void setup() {
  size(640, 480);
  shapes = new ArrayList<Shape>();
}

void draw() {
  background(255);
  for (int i = shapes.size() - 1; i >= 0; i--) {
    Shape s = shapes.get(i);
    s.update();
    s.display();
    if (s.isOffScreen()) {
      shapes.remove(i);
    }
  }
}

void mousePressed() {
  int shapeType = int(random(3));
  switch(shapeType) {
    case 0:
      shapes.add(new Circle(mouseX, mouseY));
      break;
    case 1:
      shapes.add(new Square(mouseX, mouseY));
      break;
    case 2:
      shapes.add(new Triangle(mouseX, mouseY));
      break;
  }
}

abstract class Shape {
  float x, y;
  float speedY = 2;
  
  Shape(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void update() {
    y += speedY;
  }
  
  boolean isOffScreen() {
    return y > height;
  }
  
  abstract void display();
}

class Circle extends Shape {
  float diameter = 30;
  
  Circle(float x, float y) {
    super(x, y);
  }
  
  void display() {
    ellipse(x, y, diameter, diameter);
  }
}

class Square extends Shape {
  float side = 30;
  
  Square(float x, float y) {
    super(x, y);
  }
  
  void display() {
    rect(x, y, side, side);
  }
}

class Triangle extends Shape {
  float side = 30;
  
  Triangle(float x, float y) {
    super(x, y);
  }
  
  void display() {
    triangle(x, y, x - side / 2, y + side, x + side / 2, y + side);
  }
}
