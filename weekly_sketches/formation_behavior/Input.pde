boolean leftMousePressed;
boolean rightMousePressed;

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
