int startSize = 300;
int startRes = 5;
int numLayers = 100;

Player player;

void setup() {
  frameRate(30);
  size(1600, 900);
  background(0);
  player = new Player(new PVector(width / 2, height / 2));
  for (int i = 0; i < numLayers; i++) {
    player.addShape(startSize - i * (startSize / numLayers), startRes, color(random(100, 255), random(100, 255), random(100, 255)));
  }
  
  // basically worker threads to do things
  thread("grow");
  thread("shrink");
  //thread("movement");
}

// should be used simply for rendering only, so framerate can handle efficiency of drawing itself
void draw() {
  background(0);
  player.display();
}
