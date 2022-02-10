class Player {
  ArrayList<Shape> shapes = new ArrayList<Shape>();
  int moveSpeed;
  PVector position;
  PVector direction = new PVector(0, 0);
  
  
  public Player(PVector position) {
    this.position = position;
    this.moveSpeed = 10;
  }
  
  public void addShape(int size, int resolution, color col) {
    shapes.add(new Shape(this.position, size, resolution, col));
  }
  
  public void move() {
    for (Shape shape : shapes) {
      // try to move if it isnt already
      if (!shape.isMoving) shape.move(moveSpeed, direction);
    }
  }
  
  void display() {
    for (Shape shape : shapes) {
      shape.display();
    }
  }
}
