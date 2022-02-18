ArrayList<ShrinkItem> shrinkQueue = new ArrayList<>();

void shrink() {
  int pos;
  PVector vect;
  while (true) {
    // try to add vertices and grow in distance
    for (ShrinkItem item : shrinkQueue) {
      if (item.executeTime.timeDone()) {
        Shape shape = item.shape;
        pos = (int)random(shape.numPoints);
        
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
  Timer executeTime;
  
  public ShrinkItem(Shape shape, float seconds) {
    this.shape = shape;
    executeTime = new Timer(seconds);
  }
  
}
