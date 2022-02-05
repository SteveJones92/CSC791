
float gravity = -9.81;


void setup () {
  size(1600, 900);
  frameRate(60);
  background(0);
  
  
}

void draw() {
  background(0);
  droplet drop = new droplet(10, 1, new PVector(width / 2, height / 2));
  drop.display();
}
