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
  private float targetSpeed = 5;
  private int cellSize = 2;

  ArrayList<ShipCell> formation = new ArrayList<>();
  ArrayList<PVector> positions = new ArrayList<>();

  
  GridController targetGrid;
  
  public Ship(PVector _position) {
    position = _position;
    target = new PVector(_position.x, _position.y);
    guiLayer = createGraphics(width, height);
    shipLayer = createGraphics(width, height);
    
    targetGrid = new GridController(gridDiameter, "ArrowGreen.png");
    targetGrid.display = displayGrid;
    int dist = cellSize * 2;
    int count = 0;
    for (int layers = 1; layers <= numLayers; layers++) {
      float rand = random(20, 50);
      for (int i = 0; i < 360; i+= 1) {
        if (i % 70 < rand) continue;
        PVector newP = new PVector(position.x + cos(radians(i)) * dist, position.y + sin(radians(i)) * dist);
        positions.add(newP);
        formation.add(new ShipCell(position, newP, cellSize));
        count++;
      }
      dist += cellSize;
    }
    println(count);
  }
  
  public void Move(PVector vect, int angle, float _speed) {
    vect.x += cos(radians(angle)) * _speed;
    vect.y += sin(radians(angle)) * _speed * -1;
  }
  
  public void Update() {
    if (keys[0] == 1) Move(target, 90, targetSpeed * 2);
    if (keys[1] == 1) Move(target, 180, targetSpeed * 2);
    if (keys[2] == 1) Move(target, 270, targetSpeed * 2);
    if (keys[3] == 1) Move(target, 0, targetSpeed * 2);

    targetGrid.UpdateField(position, positions, target);
    
    // get the direction at the position and move according to that, unless they are together
    float direction = targetGrid.GetDirection(position);
    if (direction != -1f) Move(position, (int)direction, min(targetSpeed / 1.5, sqrt(position.dist(target) / 2)));
    
    float direct;
    float power;
    // move formation
    for (ShipCell item : formation) {
      direct = targetGrid.GetDirection(item.rPos);
      power = targetGrid.GetWallPower(item.rPos);
      direct = item.UpdateDirection(direct, power);

      if (direct != -1f) Move(item.rPos, (int)direct, min(targetSpeed, sqrt(item.rPos.dist(item.GetFormationPos()) / 2)));
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
    shipLayer.noStroke();
    for (ShipCell item : formation) {
      item.Display(shipLayer);
    }
    shipLayer.endDraw();
    image(shipLayer, 0, 0);

  }
}
