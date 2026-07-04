PShape tmp_shape;

void mousePressed() {
  if (mouseX >= width - 100 - 20 && mouseX <= width - 20 && mouseY > 20 && mouseY < 220) {
    if (mouseY > 40 && mouseY < 50) {
      red = map(100 - (width - 20 - mouseX), 0, 100, 0, 365);
    }
    else if (mouseY > 80 && mouseY < 90) {
      green = (int) map(100 - (width - 20 - mouseX), 0, 100, 0, 365);
    }
    else if (mouseY > 120 && mouseY < 130) {
      blue = map(100 - (width - 20 - mouseX), 0, 100, 0, 365);
    }
    else if (mouseY > 160 && mouseY < 170) {
      alpha = map(100 - (width - 20 - mouseX), 0, 100, 0, 365);
    }
  }
  //drawColor = color(red, green, blue, alpha);

  
  tmp_shape = createShape();
  tmp_shape.beginShape();
  tmp_shape.fill(0);
  tmp_shape.noStroke();
}

void reset() {
  background(0);
  strokeWeight(1);
  // draw menu
  menu.beginDraw();
  menu.clear();
  menu.stroke(255);
  menu.strokeWeight(5);
  
  menu.text("Red: 0-365", 0, 20);
  menu.line(0, 25, 100, 25);
  menu.stroke(redMenuColor);
  menu.point(map(red, 0, 365, 0, 100), 25);
  menu.stroke(255);
  menu.text("" + red, 0, 40);
  
  menu.text("Green: 0-365", 0, 60);
  menu.line(0, 65, 100, 65);
  menu.stroke(greenMenuColor);
  menu.point(map(green, 0, 365, 0, 100), 65);
  menu.stroke(255);
  menu.text("" + green, 0, 80);
  
  menu.text("Blue: 0-365", 0, 100);
  menu.line(0, 105, 100, 105);
  menu.stroke(blueMenuColor);
  menu.point(map(blue, 0, 365, 0, 100), 105);
  menu.stroke(255);
  menu.text("" + blue, 0, 120);
  
  menu.text("Alpha: 0-365", 0, 140);
  menu.line(0, 145, 100, 145);
  menu.stroke(alphaMenuColor);
  menu.point(map(alpha, 0, 365, 0, 100), 145);
  menu.stroke(255);
  menu.text("" + alpha, 0, 160);
 
  menu.endDraw();
  image(menu, width - 100 - 20, 20);
  
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
  
  for (PVector point : points) {
    strokeWeight(3);
    point(point.x, point.y);
    strokeWeight(1);
  }
  fill(drawColor);
  rect(width - 250, 50, 100, 100);
}

void mouseDragged() {
  tmp_shape.vertex(mouseX, mouseY);
  points.add(new PVector(mouseX, mouseY));
  //reset();
}

void mouseReleased() {
  tmp_shape.vertex(mouseX, mouseY);
  tmp_shape.endShape(CLOSE);
  points = new ArrayList<PVector>();
  PShape new_shape = createShape();
  new_shape.beginShape();
  new_shape.fill(drawColor);
  new_shape.noStroke();
  for (int i = 0; i < tmp_shape.getVertexCount(); i++) {
    PVector vertex = tmp_shape.getVertex(i);
    if (isInside(new PVector(vertex.x, vertex.y), tri.first, tri.second, tri.third)) {
      new_shape.vertex(vertex.x, vertex.y);
    }
  }
  new_shape.endShape(CLOSE);
  tri.shapes.add(new_shape);
  tri.shape_colors.add(drawColor);
  //reset();
}

boolean hide = false;

void keyPressed() {
  if (key == 'h') {
    hide = !hide;
  } else if (key == BACKSPACE) {
    if (tri.shapes.size() > 0) tri.shapes.remove(tri.shapes.size() - 1);
    if (tri.shape_colors.size() > 0) tri.shape_colors.remove(tri.shape_colors.size() - 1);
  } else if (key == '0') {    
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
    int red, green, blue;
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
    int alpha = (int) random(180, 255); // Keeping opacity high

    drawColor = color(red, green, blue, alpha);
    //redMenuColor = red;
    //greenMenuColor = green;
    //blueMenuColor = blue;
    //alphaMenuColor = alpha;
  }
  //reset();
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
  new_shape.noStroke();
  for(int i = 0; i < obj.getVertexCount(); i++) {
    PVector vertex = obj.getVertex(i);
    new_shape.vertex(vertex.x, vertex.y);
  }
  new_shape.endShape(CLOSE);

  return new_shape;
}
