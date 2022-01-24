class Boid {
  int size;
  // in polar coordinates - radius, inclination, azimuth
  PVector position;
  // direction in unit polar
  PVector velocity;
  color c;
  PShape shape;
  
  
  
  public Boid (PVector pos, PVector vel, color col, int sz) {
    // position from center of screen
    position = pos;
    velocity = vel;
    c = col;
    size = sz;
    shape = createShape();
    shape.beginShape();
    shape.fill(c);
    shape.stroke(0);
    shape.vertex(0, -size / 2);
    shape.vertex(0, size / 2);
    shape.vertex(size, 0);
    shape.endShape();
    face();
  }
  
  
  void update() {
    position.add(velocity);
    // dont draw or scale too far away, possibly have functions to turn them around at edges
    if (position.z > width || position.z < -width) return;
    face();
    display();
  }
  
  void face() {
    // shouldn't have 0 velocity
    //if (velocity.equals(new PVector())) return;
    float dist_scale = max(1, abs(position.z / width) * 10);
    float scaled_size;
    if (position.z < 0) scaled_size = size / dist_scale;
    else scaled_size = size * dist_scale;
    float half_scaled_size = scaled_size / 2;
    float facing_point = scaled_size * 2;
    
    // scale facing point
    float scale = 1 - abs(velocity.z / velocity.mag());
    
    float angle = atan2(velocity.y, velocity.x);
    // set first point
    PVector new_vertex = new PVector();
    new_vertex.x = -(-half_scaled_size) * sin(angle);
    new_vertex.y = (-half_scaled_size) * cos(angle);
    shape.setVertex(0, new_vertex);
    
    // set second point
    new_vertex.x = -(half_scaled_size) * sin(angle);
    new_vertex.y = (half_scaled_size) * cos(angle);
    shape.setVertex(1, new_vertex);
    
    // set facing point
    new_vertex.x = (facing_point * scale) * cos(angle);
    new_vertex.y = (facing_point * scale) * sin(angle);
    shape.setVertex(2, new_vertex);
  }
  
  void display() {
    // this should scale the object (closest to camera = largest size)
    shape(shape, position.x, position.y);
  }
}
