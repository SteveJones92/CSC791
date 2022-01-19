PGraphics menu;
ArrayList<Galaxy> galaxies;

color background = color(0);
int depth = 12;
color red = color(255, 100, 100);
color blue = color(100, 100, 255);



void setup() {
  // set framerate, size of window, and overlay of that size for the path to draw on
  frameRate(60);
  // size of the window -- apparently can't use a variable, if edited then change the createGraphics()
  // and start locations throughout
  size(1600, 900);
  background(background);
  menu = createGraphics(width, height);
  
  // empty ellipses used
  noFill();

  blendMode(LIGHTEST);
  galaxies = new ArrayList<Galaxy>();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      for (int z = depth; z > 0; z--) {
        // thinner lines farther, thicker lines closer
        strokeWeight(1.5 - z / depth);
         if (random(1) < 0.00001f * z * z) {
           if (z == depth) {
             stroke(color(random(50, 255), random(50, 255), random(50, 255)));
             strokeWeight(.5);
             point(x, y);
           } else {
             color newColor = lerpColor(red, blue, random(1) * random(1));
             // add square depth as control for size where farther gets smaller quickly, constant to move the scale around
             //galaxies.add(new Galaxy(new PVector(x, y), color(random(255), random(255), random(255)), z * z * .5));
             galaxies.add(new Galaxy(new PVector(x, y), lerpColor(newColor, color(255), random(1)), z * z * .5));
           }
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
