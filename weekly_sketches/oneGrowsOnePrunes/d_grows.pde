ArrayList<GrowItem> growQueue = new ArrayList<>();

void grow() {
  int pos;
  PVector vect;
  int time = 0;
  
  while (true) {
    time = millis();
    
    // try to add vertices and grow in distance
    for (GrowItem item : growQueue) {
      Shape shape = item.shape;
      if (item.rate < time - item.last_executed) {
        item.last_executed = millis();
        pos = (int)random(shape.numPoints);
        
        // randomly activate or deactivate vertices
        //item.shape.active[pos] = true;
        
        vect = shape.vertices.get(pos);
        vect.mult(1.01 + 0.01 * (shape.size - vect.mag()));
      }
    }
    delay(1);
  }
}

class GrowItem {
  boolean exists = true;
  Shape shape;
  int last_executed = 0;
  int rate;
  
  public GrowItem(Shape shape, int rate) {
    this.shape = shape;
    this.rate = rate;
  }
}
