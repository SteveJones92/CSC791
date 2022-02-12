ArrayList<MovementItem> movementQueue = new ArrayList<>();

void movement() {
  int pos;
  PVector vect;
  int time = 0;
  
  while (true) {
    time = millis();
    
    for (int i = 0; i < movementQueue.size(); i++) {
      if (movementQueue.get(i).completed) {
        movementQueue.remove(i);
        i--;
      }
    }
    
    // try to add vertices and grow in distance
    for (MovementItem item : movementQueue) {
      Shape shape = item.shape;
      if (item.rate < time - item.last_executed) {
        item.last_executed = millis();
      }
    }
    delay(1);
  }
}

class MovementItem {
  boolean completed = false;
  Shape shape;
  int last_executed = 0;
  float rate;
  float speed;
  PVector direction;
  
  public MovementItem(Shape shape, float rate, float speed) {
    this.shape = shape;
    this.rate = rate;
    this.speed = speed;
  }
}
