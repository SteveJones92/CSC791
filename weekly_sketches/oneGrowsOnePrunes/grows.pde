ArrayList<GrowItem> growQueue = new ArrayList<>();

void grow() {
  int pos;
  PVector vect;
  
  while (true) {
    // try to add vertices and grow in distance
    for (GrowItem item : growQueue) {
      Shape shape = item.shape;
      if (item.executeTime.timeDone()) {
        pos = (int)random(shape.numPoints);
        
        vect = shape.vertices.get(pos);
        vect.mult(1.01 + 0.01 * (shape.size - vect.mag()) / shape.sizeBounds);
      }
    }
    delay(1);
  }
}

class GrowItem {
  boolean exists = true;
  Shape shape;
  Timer executeTime;
  
  public GrowItem(Shape shape, float seconds) {
    this.shape = shape;
    executeTime = new Timer(seconds);
  }
}
