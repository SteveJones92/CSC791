public class Object {
  PVector position;
  float size;
  float speed = random(5, 10);
  
  public Object(PVector _position, float _size) {
    position = _position;
    size = _size;
  }
  
  public void UpdatePosition() {
    if (!start) return;
    int[] index = gridController.field.PositionToIndex(position);
    float direction = gridController.field.grid[index[0]][index[1]].direction;
    position.x += cos(radians(direction)) * speed;
    position.y -= sin(radians(direction)) * speed;
  }
  
  public void Display() {
    ellipse(position.x, position.y, size, size);
  }
}
