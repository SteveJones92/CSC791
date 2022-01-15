int step = 30;

void setup() {
  frameRate(60);
  size(400, 400);
  background(0);
  stroke(255, 255, 255, 200);
}

void draw() {
  
}

void draw_10print() {
  int x = mouseX;
  int y = mouseY;
  
  strokeWeight(step / 2);
  
  //for (; x < 400; x += step) {
    //for (; y < 400; y += step) {
      line(x, y, x + step, y + step);
    //}
  //}
}

void mousePressed() {
  draw_10print();
}
