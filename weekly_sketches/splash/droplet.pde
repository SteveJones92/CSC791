class droplet {
  private float size;
  private float density;
  private PVector position;
  private PVector velocity;
  private color col;
  
  
  public droplet(float size, float density, PVector position) {
    this.size = size;
    this.density = density;
    this.position = position;
    velocity = new PVector(0, 0);
    this.col = color(150, 150, 255);
  }
  
  public void display() {
    fill(col);
    ellipse(position.x, position.y, size, size);
  }
}
