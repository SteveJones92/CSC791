GridController gridController;

Obstacles obstacles;

ArrayList<Object> objects = new ArrayList<>();

boolean start = false;

void setup() {
  size(1600, 900);
  frameRate(60);
  gridController = new GridController(12.5);
  //grid.display = false;
  
  obstacles = new Obstacles();
  //obstacles.display = false;
  
  for (int i = 0; i < 100; i++) {
    objects.add(new Object(new PVector(random(width), random(height)), 5));
  }
}

void draw() {
  background(0);
  if (rightMousePressed) {
    for (int i = 0; i < 10; i++) {
      obstacles.AddObstacle(new PVector(mouseX - i * 10, mouseY), 10);
      obstacles.AddObstacle(new PVector(mouseX + i * 10, mouseY), 10);
      obstacles.AddObstacle(new PVector(mouseX, mouseY - i * 10), 10);
      obstacles.AddObstacle(new PVector(mouseX, mouseY + i * 10), 10);
    }
  }
  
  if (leftMousePressed) {
    start = true;
    if (mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < height) {
      gridController.field.ReportTarget(new PVector(mouseX, mouseY));
    }
  }
  
  gridController.Display();
  obstacles.Display();
  
  for (Object object : objects) {
    object.UpdatePosition();
    object.Display();
  }
}
