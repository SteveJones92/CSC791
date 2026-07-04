color background = color(0);
color mainTriangleCol = color(255);
color otherTrianglesCol = color(230);
color drawColor;
float num = 12;
float size = 400;
Triangle tri;
ArrayList<PVector> points = new ArrayList<PVector>();

PGraphics menu;
color redMenuColor = color(255, 0, 0);
color greenMenuColor = color(0, 255, 0);
color blueMenuColor = color(0, 0, 255);
color alphaMenuColor = color(100);


float red = 200;
float green = 50;
float blue = 50;
float alpha = 200;


void setup() {
  // set framerate, size of window, and overlay of that size for the path to draw on
  frameRate(60);
  // size of the window -- apparently can't use a variable, if edited then change the createGraphics()
  // and start locations throughout
  //size(1600, 900);
  fullScreen();
  background(background);
  menu = createGraphics( 100 + 20, 220);

  
  stroke(100);
  fill(255);
  strokeWeight(2);
  stroke(200);
  drawColor = color(red, blue, green, alpha);
  
  float split = 360 / num;
  PVector center = new PVector(width / 2, height / 2);
  tri = new Triangle(new PVector(center.x, center.y), size, split, 0);  
  reset();
}

void draw() {
  reset();

  //background(0);
  //strokeWeight(1);
  
  //tri.display();
  //if (hide) {
  //  float split = 360 / num;
  //  for (int i = 1; i < num; i++) {
  //    Triangle cpy = tri.copy();
  //    //cpy.col = otherTrianglesCol;
  //    cpy.rotate(split * i);
  //    if (i % 2 == 1)  {
  //      cpy.mirror();
  //    }
  //    cpy.display();
  //  }
  //}
  
  //for (PVector point : points) {
  //  strokeWeight(3);
  //  point(point.x, point.y);
  //  strokeWeight(1);
  //}
  //fill(drawColor);
  //rect(width - 150, 50, 100, 100);
}
