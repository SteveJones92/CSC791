int paper_folds;
color background = color(0);
Paper paper;


void setup() {
  // set framerate, size of window, and overlay of that size for the path to draw on
  frameRate(10);
  // size of the window -- apparently can't use a variable, if edited then change the createGraphics()
  // and start locations throughout
  size(1600, 900);
  background(background);
  
  stroke(100);
  fill(255);
  strokeWeight(0.5);
  
  paper = new Paper();
}

void draw() {
  background(0);
  paper.display();
}
