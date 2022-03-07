Obstacles obstacles;

ArrayList<Object> objects = new ArrayList<>();

boolean displayGrid = true;

Ship player;

int gridDiameter = 20;
float gridRadius = gridDiameter / 2;
PImage arrow;
int arrowDiameter = (int)gridDiameter / 2;
float arrowRadius = arrowDiameter / 2;

float obstacleSize = 20;

void setup() {
  size(1600, 900);
  frameRate(20);
  
  obstacles = new Obstacles();
  //obstacles.display = false;
  
  player = new Ship(new PVector(width / 2, height / 2));
}

void draw() {
  background(0);
  if (rightMousePressed) {
    obstacles.AddObstacle(new PVector(mouseX, mouseY), obstacleSize);
  }
  
  if (leftMousePressed) {
    player.target = new PVector(mouseX, mouseY);
  }
  
  player.Update();
  player.Display();
  obstacles.Display();
}
