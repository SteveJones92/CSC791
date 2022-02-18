int startSize = 100;
int lowRes = 3;
int highRes = 3;
int numLayers = 4;
float scale = 1;
PVector camPosition;
PVector camPositionStart;
PVector translation;

Player player;
int speed = 10;

void setup() {
  frameRate(60);
  size(1600, 900);
  background(0);
  player = new Player(new PVector(width / 2, height / 2));
  camPosition = new PVector(player.position.x, player.position.y);
  camPositionStart = new PVector(camPosition.x, camPosition.y);
  translation = new PVector(0, 0);
  for (int i = 0; i < numLayers; i++) {
    player.addShape(startSize - i * (startSize / numLayers), (int)random(lowRes, highRes), color(random(100, 255), random(100, 255), random(100, 255)));
  }
  
  // basically worker threads to do things
  thread("grow");
  thread("shrink");
  thread("actions");
}

// should be used simply for rendering only, so framerate can handle efficiency of drawing itself
void draw() {
  background(0);
  translation.x = -(camPosition.x - camPositionStart.x);
  translation.y = -(camPosition.y - camPositionStart.y);
  camPosition.x += (player.position.x - camPosition.x) * .00005 * camPosition.dist(player.position);
  camPosition.y += (player.position.y - camPosition.y) * .00005 * camPosition.dist(player.position);
  
  translate(translation.x, translation.y);
  player.display();
  scale(scale);
  fill(255);
  rect(30, 30, 50, 50);
}
