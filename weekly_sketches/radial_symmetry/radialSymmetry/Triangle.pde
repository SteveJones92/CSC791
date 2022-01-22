class Triangle {
  PVector first;
  PVector second;
  PVector third;
  color col = color(255);
  float len;
  float angle = 0;
  float rotation;
  
  ArrayList<PShape> shapes = new ArrayList<PShape>();
  
  
  public Triangle(PVector center, float len, float angle, float rotation) {
    this.first = center;
    this.len = len;
    this.angle = angle;
    this.rotation = rotation;
    this.second = new PVector(center.x + len * cos(radians(rotation)), center.y + size * sin(radians(rotation)));
    this.third =  new PVector(center.x + len * cos(radians(rotation + angle)), center.y + len * sin(radians(rotation + angle)));
  }
  
  void display() {
    fill(col);
    triangle(first.x, first.y, second.x, second.y, third.x, third.y);
    for (PShape shape : shapes) {
      shape(shape);
    }
  }
  
  void rotate(float degrees) {
    this.second = new PVector(first.x + len * cos(radians(rotation + degrees)), first.y + size * sin(radians(rotation + degrees)));
    this.third =  new PVector(first.x + len * cos(radians(rotation + angle + degrees)), first.y + len * sin(radians(rotation + angle + degrees)));
    rotation += degrees;
    
    for (PShape shape : shapes) {
      for (int i = 0; i < shape.getVertexCount(); i++) {
        PVector vertex = shape.getVertex(i);
        PVector new_vertex = new PVector();
        new_vertex.x = (vertex.x - width / 2) * cos(radians(degrees)) - (vertex.y - height / 2) * sin(radians(degrees)) + width / 2;
        new_vertex.y = (vertex.x - width / 2) * sin(radians(degrees)) + (vertex.y - height / 2) * cos(radians(degrees)) + height / 2;
        shape.setVertex(i, new_vertex);
      }
    }
  }
  
  void mirror() {
    for (PShape shape : shapes) {
      for (int i = 0; i < shape.getVertexCount(); i++) {
        PVector vertex = shape.getVertex(i);
        PVector new_vertex = new PVector();
        new_vertex.x = (vertex.x - width / 2) * cos(-radians(rotation + angle / 2)) - (vertex.y - height / 2) * sin(-radians(rotation + angle / 2)) + width / 2;
        new_vertex.y = (vertex.x - width / 2) * sin(-radians(rotation + angle / 2)) + (vertex.y - height / 2) * cos(-radians(rotation + angle / 2)) + height / 2;
        new_vertex.y = (new_vertex.y - height / 2) * -1 + height / 2;
        shape.setVertex(i, new_vertex);
      }
    }
    for (PShape shape : shapes) {
      for (int i = 0; i < shape.getVertexCount(); i++) {
        PVector vertex = shape.getVertex(i);
        PVector new_vertex = new PVector();
        new_vertex.x = (vertex.x - width / 2) * cos(radians((rotation + angle / 2))) - (vertex.y - height / 2) * sin(radians((rotation + angle / 2))) + width / 2;
        new_vertex.y = (vertex.x - width / 2) * sin(radians((rotation + angle / 2))) + (vertex.y - height / 2) * cos(radians((rotation + angle / 2))) + height / 2;
        shape.setVertex(i, new_vertex);
      }
    }
  }
  
  Triangle copy() {
    Triangle ret = new Triangle(new PVector(first.x, first.y), len, angle, rotation);
    for (PShape shape : shapes) {
      ret.shapes.add(shape_clone(shape));
    }
    
    return ret;
  }
}
