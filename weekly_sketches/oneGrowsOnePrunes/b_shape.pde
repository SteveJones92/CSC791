
// what kind of properties will my shape have?
// size? smaller means it needs to step faster on movement but at a smaller dist or it looks weird
// complexity? more or less edges - requires a faster update on vertice moving
// move speed - how many pixels per second can you travel, must have timing to enforce
// possibly collect into a ship, can maintain proper movement at different sizes as a group
// color
// volatility? look achieved by turning on or off vertices, or possibly larger random growth or limit beyond limit or faster rate
// growth? as a multiplication fact, larger shapes change distance much faster unless the rate changes by size
// growth limit? the set size might want to limit vertices from randomly getting too large or too small
// 
class Shape {
  float size;
  int numPoints;
  PVector position;
  color col;
  
  // for movement
  boolean[] moveList;

  ArrayList<PVector> vertices = new ArrayList<>();
  
  PVector tempVert;
  
  public Shape(PVector position, float startSize, int numPoints, color col) {
    this.col = col;
    this.numPoints = numPoints;
    this.position = position;
    this.size = startSize;
    this.moveList = new boolean[numPoints];
    float angle = 0;
    float step = radians(360f / numPoints);
    for (int i = 0; i < numPoints; i++) {
      vertices.add(new PVector(startSize * cos(angle), startSize * sin(angle)));
      angle += step;
      if (i % 2 == 0) moveList[i] = true;
    }
  }
  
  // recreate the shape and display it based on the vertex list
  void display() {    
    
    PShape shape = createShape();
    shape.beginShape();
    shape.fill(col);
    shape.stroke(0, 0, 0, 100);
    shape.strokeWeight(3);
    for (int i = 0; i < numPoints; i++) {
        tempVert = vertices.get(i);
        shape.vertex(tempVert.x, tempVert.y);
    }
    shape.endShape(CLOSE);
    shape(shape, position.x, position.y);
  }
  
  // take walking steps towards another shape
  public void moveTowards(Shape target, int time) {
    if (target.numPoints != numPoints) {
      println("Num points of target shape is not the same as current shape");
      return;
    }
    
    moveQ.add(new Move(this, target, 1, time));
  }
}
