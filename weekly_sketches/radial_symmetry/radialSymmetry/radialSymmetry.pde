int paper_folds;
color background = color(0);
float num = 12;
float size = 400;
Triangle tri;

void setup() {
  // set framerate, size of window, and overlay of that size for the path to draw on
  frameRate(10);
  // size of the window -- apparently can't use a variable, if edited then change the createGraphics()
  // and start locations throughout
  size(1600, 900);
  background(background);
  
  stroke(100);
  fill(255);
  strokeWeight(2);
  stroke(200);
  
  float split = 360 / num;
  PVector center = new PVector(width / 2, height / 2);
  tri = new Triangle(new PVector(center.x, center.y), size, split, 0);
  
  
}

float val = 0;

void draw() {
  background(255);
  tri.display();
  float split = 360 / num;
  for (int i = 1; i < num; i++) {
    Triangle cpy = tri.copy();
    cpy.col = color(100);
    cpy.rotate(split * i);
    cpy.display();
  }
}

void keyPressed() {
  println(val);
  val++;
}
