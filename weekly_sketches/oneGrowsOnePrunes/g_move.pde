ArrayList<Move> moveQ = new ArrayList<>();

void moves() {
  int pos;
  PVector vect;
  int time = 0;
  
  while (true) {
    time = millis();
    
    // try to add vertices and grow in distance
    for (int i = 0; i < moveQ.size(); i++) {
      Move move = moveQ.get(i);
      if (move.rate < time - move.last_executed) {
        move.last_executed = millis();
        
        boolean[] moveList = move.shape.moveList;
        for (int j = 0; j < moveList.length; j++) {
          if (moveList[j]) {
            move.shape.vertices.get(j).add(move.stepDistances.get(j));
          }
        }
        println("here");
        if (time > move.end_time) {
          for (int j = 0; j < moveList.length; j++) {
            moveList[j] = !moveList[j];
          }
          moveQ.remove(i--);
        }
      }
    }
    delay(1);
  }
}

class Move {
  Shape shape;
  //Shape target;
  ArrayList<PVector> stepDistances = new ArrayList<>();
  int last_executed = 0;
  float rate;
  int time;
  int end_time;
  
  public Move(Shape shape, Shape target, int rate, int time) {
    this.shape = shape;
    //this.target = target;
    this.rate = rate;
    this.time = time;
    this.end_time = millis() + time;
    PVector one;
    PVector two;
    float ratio = (float)rate / time;
    for (int i = 0; i < shape.vertices.size(); i++) {
      one = shape.vertices.get(i);
      two = target.vertices.get(i);
      stepDistances.add(new PVector( (two.x - one.x + target.position.x - shape.position.x) * ratio, (two.y - one.y + target.position.y - shape.position.x) * ratio));
    }
  }
}
