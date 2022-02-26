public class FlowCell {
  private PVector guiPosition;
  private PVector position;
  private float diameter;
  private float radius;
  
  // variables for text
  private int shift;
  private float leftRightCenter;
  private float upDownCenter;
  
  public int cost = 1;
  public int bestCost = 999; // use Integer.MAX_VALUE later
  public float direction = -1;
  
  ArrayList<FlowCell> neighbors = new ArrayList<>();
  
  public FlowCell(int x, int y, float _diameter) {
    diameter = _diameter;
    radius = _diameter / 2;
    // topleft corner for displaying
    guiPosition = new PVector(x * diameter, y * diameter);
    // offset by radius to be the center of the rect
    position = new PVector(x * diameter + radius, y * diameter + radius);
    
    // set up text
    shift = String.valueOf(bestCost).length();
    leftRightCenter = radius * shift / 4;
    upDownCenter = radius / 3;
  }
  
  // add only up until 255
  public void IncreaseCost(int amount) {
      if (cost == 255) return;
      if (amount + cost > 255) cost = 255;
      else cost += amount;
  }
  
  public void SetBestCost(int _bestCost) {
    bestCost = _bestCost;
    // update text sizing
    shift = String.valueOf(bestCost).length();
    leftRightCenter = radius * shift / 4;
  }
  
  
  public void Display(PGraphics guiLayer) {
    guiLayer.rect(guiPosition.x, guiPosition.y, diameter, diameter);
    guiLayer.textSize(radius);
    guiLayer.fill(200, 200, 200, 150);
    if (direction != -1) guiLayer.text((int)direction, position.x - leftRightCenter, position.y + upDownCenter);
    else guiLayer.text(bestCost, position.x - leftRightCenter, position.y + upDownCenter);
    guiLayer.noFill();
  }
}
