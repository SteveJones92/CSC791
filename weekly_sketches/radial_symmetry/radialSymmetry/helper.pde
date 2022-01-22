PShape tmp_shape;

void mousePressed() {
  tmp_shape = createShape();
  tmp_shape.beginShape();
  tmp_shape.fill(0);
  tmp_shape.noStroke();
  //tmp_shape.vertex(mouseX, mouseY);
}

void mouseDragged() {
  if (isInside(new PVector(mouseX, mouseY), tri.first, tri.second, tri.third)) {
    //PVector lastVertex = tmp_shape.getVertex(tmp_shape.getVertexCount() - 1);
    //if (dist(lastVertex.x, lastVertex.y, mouseX, mouseY) > 5) tmp_shape.vertex(mouseX, mouseY);
    tmp_shape.vertex(mouseX, mouseY);
  }
}

void mouseReleased() {
  //tmp_shape.vertex(mouseX, mouseY);
  tmp_shape.endShape(CLOSE);
  //println(tmp_shape.getVertexCount());
  tri.shapes.add(tmp_shape);
}


// https://www.geeksforgeeks.org/check-whether-a-given-point-lies-inside-a-triangle-or-not/
float area(PVector first, PVector second, PVector third) {
   return abs( (first.x * (second.y - third.y) +
                second.x * (third.y - first.y) +
                third.x * (first.y - second.y)) / 2.0);
}

boolean isInside(PVector point, PVector first, PVector second, PVector third) {  
   /* Calculate area of triangle ABC */
    double A = area (first, second, third);
  
   /* Calculate area of triangle PBC */ 
    double A1 = area (point, second, third);
  
   /* Calculate area of triangle PAC */ 
    double A2 = area (first, point, third);
  
   /* Calculate area of triangle PAB */  
    double A3 = area (first, second, point);
    
   /* Check if sum of A1, A2 and A3 is same as A */
    return (A == A1 + A2 + A3);
}

//https://discourse.processing.org/t/copying-a-pshape/1081/2
PShape shape_clone(PShape obj) {
  PShape new_shape = createShape();
  new_shape.beginShape();
  new_shape.fill(0);
  new_shape.noStroke();
  for(int i = 0; i < obj.getVertexCount(); i++) {
    PVector vertex = obj.getVertex(i);

    new_shape.vertex(vertex.x, vertex.y);
  }

  new_shape.endShape(CLOSE);

  return new_shape;
}
