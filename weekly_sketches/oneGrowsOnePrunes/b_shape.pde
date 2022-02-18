// size
// complexity? more or less edges
// move speed - how many pixels per second can you travel
// color
// growth
// growth limit
// 
class Shape {
  float size;
  float sizeBounds;
  int numPoints;
  PVector position;
  color col;
  float speedScale = 5;
  float rotation;
  
  ArrayList<PVector> vertices = new ArrayList<>();
  
  PVector tempVert;
  
  public Shape(PVector position, int startSize, int numPoints, color col) {
    this.col = col;
    this.numPoints = numPoints;
    this.position = position;
    this.size = startSize;
    this.sizeBounds = (int) sqrt(size) * 5;
    float angle = 0;
    float step = radians(360f / numPoints);
    for (int i = 0; i < numPoints; i++) {
      vertices.add(new PVector(startSize * cos(angle), startSize * sin(angle)));
      angle += step;
    }
    
    growQueue.add(new GrowItem(this, ( (360f / numPoints) / speedScale) / 1000));
    shrinkQueue.add(new ShrinkItem(this, ( (360f / numPoints) / speedScale) / 1000));
  }
  
  void addVertex() {
    vertices.clear();
    this.numPoints++;
    float angle = 0;
    float step = radians(360f / numPoints);
    for (int i = 0; i < numPoints; i++) {
      vertices.add(new PVector(size * cos(angle), size * sin(angle)));
      angle += step;
    }
  }
  
  // recreate the shape and display it based on the vertex list
  void display() {
    PShape shape = createShape();
    shape.beginShape();
    shape.fill(col);
    shape.stroke(0, 0, 0, 100);
    shape.strokeWeight(3);
    shape.rotate(rotation);
    for (int i = 0; i < vertices.size(); i++) {
        tempVert = vertices.get(i);
        shape.vertex(tempVert.x, tempVert.y);
    }
    shape.endShape(CLOSE);
    shape(shape, position.x, position.y);
    
    /*
    PShape shapeSize = createShape(ELLIPSE, 0, 0, size * 2, size * 2);
    shapeSize.setFill(false);
    shapeSize.setStroke(255);
    shape(shapeSize, position.x, position.y);
    
    PShape shapeBoundsOuter = createShape(ELLIPSE, 0, 0, size * 2 + sizeBounds, size * 2 + sizeBounds);
    shapeBoundsOuter.setFill(false);
    shapeBoundsOuter.setStroke(150);
    shape(shapeBoundsOuter, position.x, position.y);
    
    PShape shapeBoundsInner = createShape(ELLIPSE, 0, 0, size * 2 - sizeBounds, size * 2 - sizeBounds);
    shapeBoundsInner.setFill(false);
    shapeBoundsInner.setStroke(150);
    shape(shapeBoundsInner, position.x, position.y);
    */    
  }
}
