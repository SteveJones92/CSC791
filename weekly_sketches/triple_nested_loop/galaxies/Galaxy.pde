class Galaxy {
  PVector position;
  int max_size = 100;
  int sizeX;
  int sizeY;
  color colour;
  
  public Galaxy(PVector position, color colour, float distance) {
    this.position = position;
    // avoid projecting larger than max_size
    distance = max(1, distance);
    // 1 ends up too small for an ellipse
    sizeX = distance < max_size ? (int)(max_size / distance) : 2;
    sizeY = distance < max_size ? (int)(max_size / distance) : 2;
    float squishX = random(0.2, 1.3);
    sizeX *= squishX;
    this.colour = colour;
    
    drawElliptical();
  }
  
  void drawElliptical() {
    translate(position.x, position.y);
    // amount to rotate
    float rotation = radians( (int) random(360) );
    // darken color as reaches edges
    float portion;
    rotate(rotation);
    // draw ellipse in layers outside in, increase randomly to give some texture
    for (int i = 0; i <= sizeX; i+=random(.5,4)) {
      portion = 255 * (1 - (float) i / sizeY);
      stroke(color(red(colour) - portion, green(colour) - portion, blue(colour) - portion));
      ellipse(0, 0, sizeX - i, sizeY - i);
    }
    
    rotate(-rotation);
    translate(-position.x, -position.y);
  }
  
  
}
