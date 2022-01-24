
void keyPressed() {
  if (key == 'w') {
    player.velocity.y = -1;
  }
  
  if (key == 's') {
    player.velocity.y = 1;
  }
  
  if (key == 'a') {
    player.velocity.x = -1;

  }
  
  if (key == 'd') {
    player.velocity.x = 1;
  }
  
  if (key == 'e') {
    player.velocity.z--;
  }
  
  if (key == 'q') {
    player.velocity.z++;
  }
}
