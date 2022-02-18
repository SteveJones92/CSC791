void keyPressed() {
  if (key == '=') {
    bigger = true;
  } else if (key == '-') {
    smaller = true;
  } else if (key == 'w') {
    up = true;
  } else if (key == 's') {
    down = true;
  } else if (key == 'a') {
    left = true;
  } else if (key == 'd') {
    right = true;
  } else if (key == 'e') {
    rightRotate = true;
  } else if (key == 'q') {
    leftRotate = true;
  } else if (key == '1') {
    player.shapes.get(0).addVertex();
  } else if (key == '2') {
    player.addShape(max(5, startSize - player.shapes.size() * 5), (int)random(lowRes, highRes), color(random(100, 255), random(100, 255), random(100, 255)));
  }
}

void keyReleased() {
  if (key == '=') {
    bigger = false;
  } else if (key == '-') {
    smaller = false;
  } else if (key == 'w') {
    up = false;
  } else if (key == 's') {
    down = false;
  } else if (key == 'a') {
    left = false;
  } else if (key == 'd') {
    right = false;
  } else if (key == 'e') {
    rightRotate = false;
  } else if (key == 'q') {
    leftRotate = false;
  }
}

void mousePressed() {
  firing = true;
}

void mouseReleased() {
  firing = false;
}

boolean up = false;
boolean down = false;
boolean left = false;
boolean right = false;
boolean bigger = false;
boolean smaller = false;
boolean firing = false;
boolean rightRotate = false;
boolean leftRotate = false;
PVector moveVect = new PVector(0, 0);
float rotateAmount = 0;

void actions() {
  while (true) {
    if (bigger) {
      for (Shape shape : player.shapes)  {
        shape.size *= 1.01;
        shape.sizeBounds = (int) sqrt(shape.size) * 3;
      }
      //player.growRate = 2;
      //scale *= 1.1;
    } else {
      //player.growRate = 1;
    }
    if (smaller) {
      for (Shape shape : player.shapes) {
        shape.size *= .99;
        shape.sizeBounds = (int) sqrt(shape.size) * 3;
      }
      //player.growRate = .5;
      //scale /= 1.1;
    } else {
      //player.growRate = 1;
    }
    
    moveVect.x = 0;
    moveVect.y = 0;
    rotateAmount = 0;
    
    if (up) {
      moveVect.y = -1;
    }
    if (down) {
      moveVect.y = 1;
    }
    if (left) {
      moveVect.x = -1;
    }
    if (right) {
      moveVect.x = 1;
    }
    if (rightRotate) {
      rotateAmount = radians(1);
    }
    if (leftRotate) {
      rotateAmount = -radians(1);
    }
    
    player.move(moveVect, rotateAmount);
    
    if (firing) {
      player.fire();
    }
    delay(10);
  }
}
