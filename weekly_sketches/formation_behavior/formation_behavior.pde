//GridController gridController;

Obstacles obstacles;

ArrayList<Object> objects = new ArrayList<>();

boolean start = false;

Ship player;

PImage arrow;
int arrowDiameter = 10;
float arrowRadius = arrowDiameter / 2;
int gridDiameter = 20;
float gridRadius = gridDiameter / 2;

float obstacleSize = 20;

void setup() {
  size(1600, 900);
  frameRate(60);
  
  obstacles = new Obstacles();
  //obstacles.display = false;
  
  player = new Ship(new PVector(width / 2 + 12, height / 2 + 12));
}

void draw() {
  background(0);
  if (rightMousePressed) {
    for (int i = 0; i < 10; i++) {
      obstacles.AddObstacle(new PVector(mouseX - i * obstacleSize, mouseY), obstacleSize);
      obstacles.AddObstacle(new PVector(mouseX + i * obstacleSize, mouseY), obstacleSize);
      obstacles.AddObstacle(new PVector(mouseX, mouseY - i * obstacleSize), obstacleSize);
      obstacles.AddObstacle(new PVector(mouseX, mouseY + i * obstacleSize), obstacleSize);
    }
  }
  
  if (leftMousePressed) {
    start = true;
    if (mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < height) {
      //gridController.field.ReportTarget(new PVector(mouseX, mouseY));
    }
  }
  
  player.Update();
  player.Display();
  obstacles.Display();
}
