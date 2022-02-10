void keyPressed() {
  if (key == '=') {
    for (Shape shape : player.shapes) {
      shape.size += 20;
    }
  }
  
  if (key == '-') {
    for (Shape shape : player.shapes) {
      shape.size -= 20;
    }
  }
  
  if (key == 'w') {
    player.direction.y = -1;
    //player.position.y += -1;
  }
  
  if (key == 's') {
    player.direction.y = 1;
    //player.position.y += 1;
  }
  
  if (key == 'a') {
    player.direction.x = -1;
    //player.position.x += -1;
  }
  
  if (key == 'd') {
    player.direction.x = 1;
    //player.position.x += 1;
  }
  
  player.move();
}

void keyReleased() {
  if (key == 'w' || key == 's') {
    player.direction.y = 0;
  }
  
  if (key == 'a' || key == 'd') {
    player.direction.x = 0;
  }
}
