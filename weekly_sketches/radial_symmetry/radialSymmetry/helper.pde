PShape tmp_shape;

void mousePressed() {
  if (mouseX >= width - 100 - 20 && mouseX <= width - 20 && mouseY > 20 && mouseY < 220) {
    if (mouseY > 40 && mouseY < 50) {
      red = (int) map(100 - (width - 20 - mouseX), 0, 100, 0, 365);
    }
    else if (mouseY > 80 && mouseY < 90) {
      green = (int) map(100 - (width - 20 - mouseX), 0, 100, 0, 365);
    }
    else if (mouseY > 120 && mouseY < 130) {
      blue = (int) map(100 - (width - 20 - mouseX), 0, 100, 0, 365);
    }
    else if (mouseY > 160 && mouseY < 170) {
      alpha = (int) map(100 - (width - 20 - mouseX), 0, 100, 0, 365);
    }
  }
  
  tmp_shape = createShape();
  tmp_shape.beginShape();
  tmp_shape.fill(0);
  tmp_shape.noStroke();
}

void reset() {
  background(0);
  
  drawColor = color(red, green, blue, alpha);

  // draw menu
  menu.beginDraw();
  menu.clear();
  menu.stroke(255);
  menu.strokeWeight(5);
  
  menu.text("Red: 0-365", 0, 20);
  menu.stroke(redMenuColor);
  menu.line(0, 25, 100, 25);
  menu.stroke(255);
  menu.point(map(red, 0, 365, 0, 100), 25);
  menu.text("" + red, 0, 40);
  
  menu.text("Green: 0-365", 0, 60);
  menu.stroke(greenMenuColor);
  menu.line(0, 65, 100, 65);
  menu.stroke(255);
  menu.point(map(green, 0, 365, 0, 100), 65);
  menu.text("" + green, 0, 80);
  
  menu.text("Blue: 0-365", 0, 100);
  menu.stroke(blueMenuColor);
  menu.line(0, 105, 100, 105);
  menu.stroke(255);
  menu.point(map(blue, 0, 365, 0, 100), 105);
  menu.text("" + blue, 0, 120);
  
  menu.text("Alpha: 0-365", 0, 140);
  menu.stroke(alphaMenuColor);
  menu.line(0, 145, 100, 145);
  menu.stroke(255);
  menu.point(map(alpha, 0, 365, 0, 100), 145);
  menu.text("" + alpha, 0, 160);
 
  menu.endDraw();
  image(menu, width - 100 - 20, 20);
  
  strokeWeight(0);
  tri.display();
  
  if (hide) {
    float split = 360 / num;
    for (int i = 1; i < num; i++) {
      Triangle cpy = tri.copy();
      cpy.col = otherTrianglesCol;
      cpy.rotate(split * i);
      if (i % 2 == 1)  {
        cpy.mirror();
      }
      cpy.display();
    }
  }
  
  fill(255);
  strokeWeight(2);
  stroke(150);
  for (PVector point : points) {
    //point(point.x, point.y);
    ellipse(point.x, point.y, 4, 4);
  }
  stroke(100);
  strokeWeight(3);
  fill(drawColor);
  rect(width - 250, 50, 100, 100);
}

void mouseDragged() {
  tmp_shape.vertex(mouseX, mouseY);
  points.add(new PVector(mouseX, mouseY));
}

void mouseReleased() {
  tmp_shape.vertex(mouseX, mouseY);
  tmp_shape.endShape(CLOSE);
  points = new ArrayList<PVector>();

  // Define the clipping polygon (triangle)
  PVector[] clipPolygon = {tri.first, tri.second, tri.third};

  // Get vertices of the subject polygon
  ArrayList<PVector> subjectPolygon = new ArrayList<PVector>();
  for (int i = 0; i < tmp_shape.getVertexCount(); i++) {
    subjectPolygon.add(tmp_shape.getVertex(i));
  }

  // Perform the Sutherland-Hodgman polygon clipping
  ArrayList<PVector> clippedPolygon = sutherlandHodgman(subjectPolygon, clipPolygon);

  // Create the new shape with clipped vertices
  if (clippedPolygon.size() > 0) {
    PShape new_shape = createShape();
    new_shape.beginShape();
    new_shape.fill(drawColor);
    new_shape.noStroke();
    for (PVector vertex : clippedPolygon) {
      new_shape.vertex(vertex.x, vertex.y);
    }
    new_shape.endShape(CLOSE);
    addShapeToTriangle(new_shape, drawColor);

    //tri.shapes.add(new_shape);
    //tri.shape_colors.add(drawColor);
  }
  
  tri.clear_redo();
}

// Sutherland-Hodgman algorithm implementation
ArrayList<PVector> sutherlandHodgman(ArrayList<PVector> subjectPolygon, PVector[] clipPolygon) {
  ArrayList<PVector> outputList = subjectPolygon;

  for (int i = 0; i < clipPolygon.length; i++) {
    PVector A = clipPolygon[i];
    PVector B = clipPolygon[(i + 1) % clipPolygon.length];
    ArrayList<PVector> inputList = outputList;
    outputList = new ArrayList<PVector>();

    if (inputList.size() == 0) {
      break;
    }

    PVector S = inputList.get(inputList.size() - 1);

    for (PVector E : inputList) {
      if (isInside(E, A, B)) {
        if (!isInside(S, A, B)) {
          PVector intersection = computeIntersection(S, E, A, B);
          if (intersection != null) {
            outputList.add(intersection);
          }
        }
        outputList.add(E);
      } else if (isInside(S, A, B)) {
        PVector intersection = computeIntersection(S, E, A, B);
        if (intersection != null) {
          outputList.add(intersection);
        }
      }
      S = E;
    }
  }
  return outputList;
}

// Check if point is inside the edge
boolean isInside(PVector p, PVector edgeStart, PVector edgeEnd) {
  return (edgeEnd.x - edgeStart.x) * (p.y - edgeStart.y) - (edgeEnd.y - edgeStart.y) * (p.x - edgeStart.x) >= 0;
}

// Compute intersection point of two lines
PVector computeIntersection(PVector s, PVector e, PVector a, PVector b) {
  float denominator = (s.x - e.x) * (a.y - b.y) - (s.y - e.y) * (a.x - b.x);
  if (denominator == 0) {
    return null; // Lines are parallel
  }
  float t = ((s.x - a.x) * (a.y - b.y) - (s.y - a.y) * (a.x - b.x)) / denominator;
  return new PVector(
    s.x + t * (e.x - s.x),
    s.y + t * (e.y - s.y)
  );
}


boolean hide = false;

void keyPressed() {
  if (key == 'h') {
    hide = !hide;
  } else if (keyCode == LEFT || key == BACKSPACE) {
    tri.undo();
    //if (tri.shapes.size() > 0) tri.shapes.remove(tri.shapes.size() - 1);
    //if (tri.shape_colors.size() > 0) tri.shape_colors.remove(tri.shape_colors.size() - 1);
  } else if (key == '0' || key == 'r') {    
    float randomValue = random(1); // Random value between 0 and 1

    int numVibrantColors;
    if (randomValue < 0.6) {
      numVibrantColors = 1; // 60% chance for 1 vibrant color
    } else if (randomValue < 0.9) {
      numVibrantColors = 2; // 30% chance for 2 vibrant colors
    } else {
      numVibrantColors = 3; // 10% chance for 3 vibrant colors
    }

    // Set color ranges based on the number of vibrant colors
    if (numVibrantColors == 1) {
      // One vibrant color, others low
      int vibrant = (int) random(1, 4);
      if (vibrant == 1) {
        red = (int) random(200, 255); green = (int) random(50, 150); blue = (int) random(50, 150);
      } else if (vibrant == 2) {
        green = (int) random(200, 255); red = (int) random(50, 150); blue = (int) random(50, 150);
      } else {
        blue = (int) random(200, 255); red = (int) random(50, 150); green = (int) random(50, 150);
      }
    } else if (numVibrantColors == 2) {
      // Two vibrant colors, one low
      int low = (int) random(1, 4);
      if (low == 1) {
        red = (int) random(50, 150); green = (int) random(200, 255); blue = (int) random(200, 255);
      } else if (low == 2) {
        green = (int) random(50, 150); red = (int) random(200, 255); blue = (int) random(200, 255);
      } else {
        blue = (int) random(50, 150); red = (int) random(200, 255); green = (int) random(200, 255);
      }
    } else {
      // All three vibrant
      red = (int) random(200, 255);
      green = (int) random(200, 255);
      blue = (int) random(200, 255);
    }

    // Set the alpha channel to be mostly high for opacity
    alpha = (int) random(180, 255); // Keeping opacity high
    if (key == 'r') {
      // Generate a random shape within the triangle
      int numPoints = (int) random(5, 25); // Random number of vertices between 3 and 6
      ArrayList<PVector> randomPoints = new ArrayList<PVector>();
      for (int i = 0; i < numPoints; i++) {
        PVector p = randomPointInTriangle(tri.first, tri.second, tri.third);
        randomPoints.add(p);
      }
  
      // Create the shape
      PShape randomShape = createShape();
      randomShape.beginShape();
      randomShape.fill(drawColor);
      randomShape.noStroke();
      for (PVector p : randomPoints) {
        randomShape.vertex(p.x, p.y);
      }
      randomShape.endShape(CLOSE);
      addShapeToTriangle(randomShape, drawColor);

      //// Add the shape to the triangle's list of shapes
      //tri.shapes.add(randomShape);
      //tri.shape_colors.add(drawColor);
    }
  } else if (keyCode == RIGHT) {
    tri.redo();
  } else if (key == 'c') {
    tri.clear_all();
  }
}

PVector randomPointInTriangle(PVector a, PVector b, PVector c) {
  float r1 = random(1);
  float r2 = random(1);

  if (r1 + r2 > 1) {
    r1 = 1 - r1;
    r2 = 1 - r2;
  }

  float x = a.x + r1 * (b.x - a.x) + r2 * (c.x - a.x);
  float y = a.y + r1 * (b.y - a.y) + r2 * (c.y - a.y);
  return new PVector(x, y);
}


//https://discourse.processing.org/t/copying-a-pshape/1081/2
PShape shape_clone(PShape obj) {
  PShape new_shape = createShape();
  new_shape.beginShape();
  new_shape.noStroke();
  for(int i = 0; i < obj.getVertexCount(); i++) {
    PVector vertex = obj.getVertex(i);
    new_shape.vertex(vertex.x, vertex.y);
  }
  new_shape.endShape(CLOSE);

  return new_shape;
}

void addShapeToTriangle(PShape shape, color c) {
  tri.shapes.add(shape);
  tri.shape_colors.add(c);
  if (tri.shapes.size() > 100) {
    tri.shapes.remove(0);
    tri.shape_colors.remove(0);
  }
}
