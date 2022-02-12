class Player {
  // the player shape
  ArrayList<Shape> shapes = new ArrayList<Shape>();
  // the formation or target
  ArrayList<Shape> targets = new ArrayList<Shape>();
  
  int moveSpeed = speed;
  PVector position;
  
  
  public Player(PVector position) {
    this.position = position;
  }
  
  public void addShape(int size, int resolution, color col) {
    shapes.add(new Shape(this.position, size, resolution, col));
    targets.add(new Shape(new PVector(300, 300), size, resolution, color(100)));
  }
  
  public void move() {
    for (int i = 0; i < shapes.size(); i++) {
      shapes.get(i).moveTowards(targets.get(i), 1000);
    }
  }
  
  void display() {
    for (Shape shape : shapes) {
      shape.display();
    }
    for (Shape target : targets) {
      target.display();
    }
  }
}
