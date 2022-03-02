// 2 flow fields for control attempt
public class Ship {
  PGraphics guiLayer;
  PVector position;
  PVector target;
  
  PVector point;
  
  int speed = 5;
  
  GridController positionGrid;
  GridController targetGrid;
  
  public Ship(PVector _position) {
    position = _position;
    target = new PVector(_position.x, _position.y);
    point = new PVector(_position.x + 20, _position.y + 20);
    guiLayer = createGraphics(width, height);
    
    positionGrid = new GridController(gridDiameter, "ArrowGreen.png");
    positionGrid.display = false;
    positionGrid.field.reverse = true;
    targetGrid = new GridController(gridDiameter, "ArrowGreen.png");
    //targetGrid.display = false;
  }
  
  public void Move(PVector vect, int angle, int _speed) {
    vect.x += cos(radians(angle)) * _speed;
    vect.y += sin(radians(angle)) * _speed * -1;
  }
  
  public void Update() {
    if (keys[0] == 1) Move(target, 90, speed * 2);
    if (keys[1] == 1) Move(target, 180, speed * 2);
    if (keys[2] == 1) Move(target, 270, speed * 2);
    if (keys[3] == 1) Move(target, 0, speed * 2);
    
    // update both grid directions
    int[] positionIndex = positionGrid.field.PositionToIndex(position);
    //positionGrid.field.UpdateGrid(positionGrid.field.grid[positionIndex[0]][positionIndex[1]]);
    int[] targetIndex = targetGrid.field.PositionToIndex(target);
    targetGrid.field.UpdateGrid(targetGrid.field.grid[targetIndex[0]][targetIndex[1]]);
    
    // merge the directions into the position grid
    positionGrid.MergeDirections(targetGrid.field);
    float direction = positionGrid.field.grid[positionIndex[0]][positionIndex[1]].direction;
    if (positionIndex[0] != targetIndex[0] || positionIndex[1] != targetIndex[1]) Move(position, (int)direction, speed);
    
    int[] pointIndex = positionGrid.field.PositionToIndex(point);
    direction = positionGrid.field.grid[pointIndex[0]][pointIndex[1]].direction;
    Move(point, (int)direction, speed);
  }
  
  public void Display() {
    positionGrid.Display();
    targetGrid.Display();
    guiLayer.beginDraw();
    guiLayer.clear();
    guiLayer.fill(0, 255, 0);
    guiLayer.ellipse(position.x, position.y, 10, 10);
    guiLayer.fill(255, 0, 0);
    guiLayer.ellipse(target.x, target.y, 10, 10);
    guiLayer.endDraw();
    image(guiLayer, 0, 0);
    
    ellipse(point.x, point.y, 5, 5);
  }
}
