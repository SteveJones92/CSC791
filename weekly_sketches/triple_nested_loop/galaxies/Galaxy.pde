class Galaxy {
  PVector position;
  int max_size = 100;
  int sizeX;
  int sizeY;
  color colour;
  
  public Galaxy(int type, PVector position, color colour, float distance, float squish) {
    this.position = position;
    sizeX = distance <= max_size ? (int)(max_size / distance) : 2;
    sizeY = distance <= max_size ? (int)(max_size / distance) : 2;
    float squishX = random(0.2, 1.5);
    sizeX *= squishX;
    this.colour = colour;
    
    if (type == 0) {
      drawElliptical();
    }
  }
  
  void drawElliptical() {
    translate(position.x, position.y);
    int rotation = (int)random(360);
    rotate(radians(rotation));
    for (int i = 1; i <= sizeX; i++) {
      float portion = 255 - 255 * ((float)i / sizeY);
      stroke(color(red(colour) - portion, green(colour) - portion, blue(colour) - portion));
      ellipse(0, 0, sizeX - i, sizeY - i);
    }
    
    rotate(radians(-rotation));
    translate(-position.x, -position.y);
  }
  
  
}
