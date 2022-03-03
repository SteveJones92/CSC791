public class FlowCell {
  private PVector guiPosition;
  private PVector position;
  private float diameter;
  private float radius;
  
  private int cost = 1;
  private int bestCost = Integer.MAX_VALUE;
  private float direction = -1;
  
  boolean set = false;
  boolean needsCovering = false;
  
  ArrayList<FlowCell> neighbors = new ArrayList<>();
  
  public FlowCell(int x, int y, float _diameter) {
    diameter = _diameter;
    radius = _diameter / 2;
    // topleft corner for displaying
    guiPosition = new PVector(x * diameter, y * diameter);
    // offset by radius to be the center of the rect
    position = new PVector(x * diameter + radius, y * diameter + radius);
  }

  public FlowCell(int x, int y, float _diameter, int _cost) {
    this(x, y, _diameter);
    cost = _cost;
  }
  
  // add only up until 255
  public void IncreaseCost(int amount) {
      if (amount + cost > 255) cost = 255;
      else cost += amount;
  }
  
  public void SetBestCost(int _bestCost) {
    bestCost = _bestCost;
  }
  
  
  public void Display(PGraphics guiLayer) {
    if (!set) return;
    if (cost == 255) {
      guiLayer.fill(255, 0, 0);
      guiLayer.rect(guiPosition.x, guiPosition.y, diameter, diameter);
      guiLayer.noFill();
    }
    // draw arrow
    guiLayer.translate(position.x, position.y);
    guiLayer.rotate(-radians(direction));
    guiLayer.image(arrow, -arrowRadius, -arrowRadius);
    guiLayer.rotate(radians(direction));
    guiLayer.translate(-(position.x), -(position.y));
  }
}
