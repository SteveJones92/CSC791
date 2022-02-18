class Player {
  // shapes that make up the player
  ArrayList<Shape> shapes = new ArrayList<Shape>();
  // bullets that the player fires
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  
  PVector position;
  Timer fireRate = new Timer(.1);
  Timer moveRate = new Timer(0.01);
  Timer rotateRate = new Timer(0.01);
  int moveSpeed = 10;
  int rotationSpeed = 2;
  float growRate = 1;
  
  
  public Player(PVector position) {
    this.position = position;
  }
  
  public void addShape(int size, int resolution, color col) {
    shapes.add(new Shape(this.position, size, resolution, col));
  }
  
  void move(PVector step, float rotateAmount) {
    if (moveRate.timeDone()) {
      position.x += step.x * moveSpeed;
      position.y += step.y * moveSpeed;
    }
    
    if (rotateRate.timeDone()) {
      for (Shape shape : shapes) {
        shape.rotation += rotateAmount * rotationSpeed;
      }
    }
  }
  
  void fire() {
    if (fireRate.timeDone()) {
      for (Shape shape : shapes) {
        for (PVector vertex : shape.vertices) {
          //if (random(1) > 0.8)
          PVector vertexPos = new PVector( vertex.x * cos(shape.rotation) - vertex.y * sin(shape.rotation),
                                           vertex.x * sin(shape.rotation) + vertex.y * cos(shape.rotation));
                                           
          PVector velocity = new PVector(mouseX - translation.x - (vertexPos.x + shape.position.x), mouseY - translation.y - (vertexPos.y + shape.position.y));
          velocity.normalize();
          velocity.mult(sqrt(shape.size));

          bullets.add(new Bullet(new PVector(vertexPos.x + shape.position.x, vertexPos.y + shape.position.y), velocity, (int)sqrt(shape.size), shape.col));
          //shape.size -= (int)sqrt(shape.size / shape.numPoints);
        }
      }
    }
  }
  
  // display and clean up bullets
  void display() {
    for (Shape shape : shapes) {
      shape.display();
    }
    for (int i = 0; i < bullets.size(); i++) {
      if (bullets.get(i).col == color(0)) {
        bullets.remove(i--);
        continue;
      }
      bullets.get(i).update();
      bullets.get(i).display();
    }
  }
}
