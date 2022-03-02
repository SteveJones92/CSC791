// controls visual aspects of the grid
public class GridController {
  private PGraphics guiLayer;
  public FlowField field;
  private color gridColor = color(255, 255, 255, 30);
  public boolean display = true;
  private String arrowType;
  
  public GridController(float _cellSize, String _arrowType) {
    field = new FlowField(_cellSize);
    guiLayer = createGraphics(width, height);
    arrowType = _arrowType;
  }
  
  public void MergeDirections(FlowField other) {
    for (int i = 0; i < other.grid.length; i++) {
      for (int j = 0; j < other.grid[i].length; j++) {
        float direction1 = field.grid[i][j].direction;
        float direction2 = other.grid[i][j].direction;
        float x = cos(-radians(direction1)) + cos(radians(direction2));
        float y = sin(radians(direction1)) + sin(radians(direction2));
        //field.grid[i][j].strength = sqrt(sq(x) + sq(y));
        field.grid[i][j].direction = degrees(atan2(y , x));
        //println(direction1 + " " + direction2 + " -> " + field.grid[i][j].direction);
      }
    }
  }
  
  public void Display() {
    if (display) {
      arrow = loadImage(arrowType);
      arrow.resize(arrowDiameter, arrowDiameter);
      guiLayer.beginDraw();
      guiLayer.clear();
      guiLayer.noFill();
      guiLayer.stroke(gridColor);
      guiLayer.strokeWeight(1f);
      field.Display(guiLayer);
      guiLayer.endDraw();
      image(guiLayer, 0, 0);
    }
  }
}
