boolean leftMousePressed;
boolean rightMousePressed;

// w a s d p
int keys[] = new int[] {0, 0, 0, 0, 0};

void keyPressed() {
  if (key == 'w') keys[0] = 1;
  else if (key == 'a') keys[1] = 1;
  else if (key == 's') keys[2] = 1;
  else if (key == 'd') keys[3] = 1;
  else if (key == 'p') {
    if (keys[4] == 0) {
      keys[4] = 1;
      noLoop();
    } else if (keys[4] == 1) {
      keys[4] = 0;
      loop();
    }
  }
}

void keyReleased() {
  if (key == 'w') keys[0] = 0;
  else if (key == 'a') keys[1] = 0;
  else if (key == 's') keys[2] = 0;
  else if (key == 'd') keys[3] = 0;
}


void mousePressed() {
  if (mouseButton == LEFT) {
    leftMousePressed = true;
  } else if (mouseButton == RIGHT) {
    rightMousePressed = true;  }
}

void mouseReleased() {
  if (mouseButton == LEFT) {
    leftMousePressed = false;
  } else if (mouseButton == RIGHT) {
    rightMousePressed = false;
  }
}
