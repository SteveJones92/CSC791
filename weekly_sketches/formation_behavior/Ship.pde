// 1 target flow field
public class Ship {
  // drawing layer for the ship non-physical items
  private PGraphics guiLayer;
  // drawing layer for the physical ship
  private PGraphics shipLayer;
  // non-physical ship position, used in flowfield creation
  private PVector position;
  // target item, representing move direction and is the target for the flow field
  private PVector target;
  // speed of the ship's flow field target
  private int targetSpeed = 5;

  // needs a formation
  ArrayList<PVector> formation = new ArrayList<PVector>();
  
  GridController targetGrid;
  
  public Ship(PVector _position) {
    position = _position;
    target = new PVector(_position.x, _position.y);
    guiLayer = createGraphics(width, height);
    shipLayer = createGraphics(width, height);
    
    targetGrid = new GridController(gridDiameter, "ArrowGreen.png");
    //targetGrid.display = false;
    
    for (int i = 0; i < 10; i++) {
      formation.add(new PVector(position.x + random(50), position.y + random(50)));
    }
  }
  
  public void Move(PVector vect, int angle, int _speed) {
    vect.x += cos(radians(angle)) * _speed;
    vect.y += sin(radians(angle)) * _speed * -1;
  }
  
  public void Update() {
    if (keys[0] == 1) Move(target, 90, targetSpeed * 2);
    if (keys[1] == 1) Move(target, 180, targetSpeed * 2);
    if (keys[2] == 1) Move(target, 270, targetSpeed * 2);
    if (keys[3] == 1) Move(target, 0, targetSpeed * 2);

    targetGrid.UpdateField(position, formation, target);
    
    // get the direction at the position and move according to that, unless they are together
    float direction = targetGrid.GetDirection(position);
    if (direction != -1f) Move(position, (int)direction, targetSpeed);
    
    // move formation
    for (PVector item : formation) {
      direction = targetGrid.GetDirection(item);
      if (direction != -1f) Move(item, (int)direction, (int)max(1, targetSpeed * random(1)));
    }
  }
  
  public void Display() {
    // maintains its own guiLayer
    targetGrid.Display();

    // draw ship items like position and target
    guiLayer.beginDraw();
    guiLayer.clear();
    guiLayer.fill(0, 255, 0);
    guiLayer.ellipse(position.x, position.y, 10, 10);
    guiLayer.fill(255, 0, 0);
    guiLayer.ellipse(target.x, target.y, 10, 10);
    guiLayer.endDraw();
    image(guiLayer, 0, 0);
    
    // draw ship physical items
    shipLayer.beginDraw();
    shipLayer.clear();
    shipLayer.fill(100, 100, 100);
    for (PVector item : formation) {
      shipLayer.ellipse(item.x, item.y, 10, 10);
    }
    shipLayer.endDraw();
    image(shipLayer, 0, 0);

  }
}
