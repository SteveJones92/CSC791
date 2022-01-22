void mouseDragged() {
  if (isInside(new PVector(mouseX, mouseY), tri.first, tri.second, tri.third)) {
    tri.drawover.beginDraw();
    tri.drawover.stroke(0);
    tri.drawover.ellipse(mouseX, mouseY, 2, 2);
    tri.drawover.endDraw();
    tri.drawover_cpy = tri.drawover.get();
  }
}

void mouseReleased() {
}


// https://www.geeksforgeeks.org/check-whether-a-given-point-lies-inside-a-triangle-or-not/
float area(PVector first, PVector second, PVector third) {
   return abs( (first.x * (second.y - third.y) +
                second.x * (third.y - first.y) +
                third.x * (first.y - second.y)) / 2.0);
}

boolean isInside(PVector point, PVector first, PVector second, PVector third)
  {  
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
