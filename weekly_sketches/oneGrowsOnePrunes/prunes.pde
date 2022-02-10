ArrayList<ShrinkItem> shrinkQueue = new ArrayList<>();

void shrink() {
  int pos;
  PVector vect;
  int time = 0;
  
  while (true) {
    time = millis();
    
    // try to add vertices and grow in distance
    for (ShrinkItem item : shrinkQueue) {
      if (item.rate < time - item.last_executed) {
        item.last_executed = millis();
        Shape shape = item.shape;
        pos = (int)random(shape.numPoints);
        
        // randomly activate or deactivate vertices
        //item.shape.active[pos] = true;
        
        vect = shape.vertices.get(pos);
        vect.mult(0.99 + 0.01 * (shape.size - vect.mag()) / shape.sizeBounds);

      }
    }
    delay(1);
  }
}

class ShrinkItem {
  boolean exists = true;
  Shape shape;
  int last_executed = 0;
  int rate;
  
  public ShrinkItem(Shape shape, int rate) {
    this.shape = shape;
    this.rate = rate;
  }
  
}
