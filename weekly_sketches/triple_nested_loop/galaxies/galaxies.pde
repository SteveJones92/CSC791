PGraphics menu;
ArrayList<Galaxy> galaxies;

color background = color(0);
int depth = 12;

void setup() {
  // set framerate, size of window, and overlay of that size for the path to draw on
  frameRate(60);
  // size of the window -- apparently can't use a variable, if edited then change the createGraphics()
  // and start locations throughout
  size(1600, 900);
  background(background);
  menu = createGraphics(width, height);
  
  noFill();
  blendMode(LIGHTEST);
  
  galaxies = new ArrayList<Galaxy>();
  //galaxies.add(new Galaxy(0, new PVector(100, 100), color(random(255), random(255), random(255)), 1, 0, 0));
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      for (int z = depth; z > 0; z--) {
         if (random(1) < 0.00001f * z * z) {
           galaxies.add(new Galaxy(0, new PVector(x, y), color(random(255), random(255), random(255)), z * z, z));
         }
      }
    }
  }
}

void draw() {
  // draw menu
  menu.beginDraw();
  menu.clear();
  menu.stroke(255);
  menu.fill(255);
  menu.rect(width - 125, 15, 75, 15);
  menu.fill(0);
  menu.text("Generate", width - 115, 25);
  menu.endDraw();
  image(menu, 0, 0);
}

void mousePressed() {
  if (mouseX >= width - 125 && mouseX <= width - 50 && mouseY > 15 && mouseY < 30) {
    galaxies = new ArrayList<Galaxy>();
    setup();
  }
}
