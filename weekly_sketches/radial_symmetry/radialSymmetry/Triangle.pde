class Triangle {
  PVector first;
  PVector second;
  PVector third;
  color col = color(255);
  float len;
  float angle = 0;
  float rotation;
  
  PGraphics drawover;
  PImage drawover_cpy;
  
  
  public Triangle(PVector center, float len, float angle, float rotation) {
    this.first = center;
    this.len = len;
    this.angle = angle;
    this.rotation = rotation;
    this.second = new PVector(center.x + len * cos(radians(rotation)), center.y + size * sin(radians(rotation)));
    this.third =  new PVector(center.x + len * cos(radians(rotation + angle)), center.y + len * sin(radians(rotation + angle)));
    
    drawover = createGraphics(width, height);
    drawover.beginDraw();
    drawover.endDraw();
    drawover_cpy = drawover.get();
  }
  
  void display() {
    fill(col);
    triangle(first.x, first.y, second.x, second.y, third.x, third.y);
    image(drawover_cpy, 0, 0);
    
  }
  
  void rotate(float degrees) {
    this.second = new PVector(first.x + len * cos(radians(rotation + degrees)), first.y + size * sin(radians(rotation + degrees)));
    this.third =  new PVector(first.x + len * cos(radians(rotation + angle + degrees)), first.y + len * sin(radians(rotation + angle + degrees)));
  }
  
  Triangle copy() {
    Triangle ret = new Triangle(new PVector(first.x, first.y), len, angle, rotation);
    ret.drawover_cpy = drawover_cpy.copy();//copy(drawover, 0, 0, drawover.width, drawover.height, 0, 0, ret.drawover.width, ret.drawover.height);
    return ret;
  }
}
