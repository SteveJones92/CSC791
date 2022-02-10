
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
  int size;
  int sizeBounds = 10;
  int numPoints;
  PVector position;
  color col;
  float speedScale = 1;
  
  // for movement
  boolean isMoving = false;
  IntList moveList = new IntList();
  
  ArrayList<PVector> vertices = new ArrayList<>();
  boolean[] active;
  
  PVector tempVert;
  
  public Shape(PVector position, int startSize, int numPoints, color col) {
    this.col = col;
    active = new boolean[numPoints];
    this.numPoints = numPoints;
    this.position = position;//new PVector(position.x, position.y);
    this.size = startSize;
    float angle = 0;
    float step = radians(360f / numPoints);
    for (int i = 0; i < numPoints; i++) {
      vertices.add(new PVector(startSize * cos(angle), startSize * sin(angle)));
      angle += step;
      active[i] = true;
    }
    growQueue.add(new GrowItem(this, (int)( (360 / numPoints) / speedScale) ));
    shrinkQueue.add(new ShrinkItem(this, (int)( (360 / numPoints) / speedScale)));
  }
  
  // speed is pixels per second, or 1 sec per move basically
  void move(float speed, PVector direction) {
    isMoving = true;
    if (moveList.size() == 0) {
      for (int i = 0; i < numPoints; i++) {
        moveList.append(i);
      }
    }
    // should be based on size and number of points
    // smaller items move smaller amounts but quicker
    // more points means it needs to be quicker too
    // should uniquely move each point, no double picking
    // higher values = longer time to do
    movementQueue.add(new MovementItem(this, (360 / numPoints), speed, direction));
  }
  
  // recreate the shape and display it based on the vertex list
  void display() {
    PShape shape = createShape();
    shape.beginShape();
    shape.fill(col);
    //shape.stroke(0, 0, 0, 100);
    //shape.strokeWeight(3);
    shape.noStroke();
    shape.strokeJoin(ROUND);
    for (int i = 0; i < active.length; i++) {
      if (active[i]) {
        tempVert = vertices.get(i);
        shape.vertex(tempVert.x, tempVert.y);
      }
    }
    shape.endShape(CLOSE);
    shape(shape, position.x, position.y);
    
    //PShape shapeSize = createShape(ELLIPSE, 0, 0, size * 2, size * 2);
    //shapeSize.setFill(false);
    //shapeSize.setStroke(255);
    //shape(shapeSize, position.x, position.y);
    
    //PShape shapeBoundsOuter = createShape(ELLIPSE, 0, 0, size * 2 + sizeBounds, size * 2 + sizeBounds);
    //shapeBoundsOuter.setFill(false);
    //shapeBoundsOuter.setStroke(150);
    //shape(shapeBoundsOuter, position.x, position.y);
    
    //PShape shapeBoundsInner = createShape(ELLIPSE, 0, 0, size * 2 - sizeBounds, size * 2 - sizeBounds);
    //shapeBoundsInner.setFill(false);
    //shapeBoundsInner.setStroke(150);
    //shape(shapeBoundsInner, position.x, position.y);
  }
}
