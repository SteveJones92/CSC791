class Bullet {
  PVector position;
  PVector velocity;
  int size;
  color col;
  
  public Bullet(PVector position, PVector velocity, int size, color col) {
    this.position = position;
    this.velocity = velocity;
    this.size = size;
    this.col = col;
  }
  
  public void update() {
    position.add(velocity);
    col = color(red(col) - 1, green(col) - 1, blue(col) - 1);;
  }
  
  public void display() {
    fill(col);
    ellipse(position.x, position.y, size, size);
  }
}
