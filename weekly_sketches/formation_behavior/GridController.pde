// controls visual aspects of the grid
public class GridController {
  private PGraphics guiLayer;
  private FlowField field;
  private color gridColor = color(255, 255, 255, 30);
  public boolean display = true;
  private String arrowType;
  
  public GridController(float _cellSize, String _arrowType) {
    field = new FlowField(_cellSize);
    guiLayer = createGraphics(width, height);
    arrowType = _arrowType;
  }

  public void UpdateField(PVector _position, ArrayList<PVector> _positions, PVector _target) {
    field.UpdateGrid(_position, _positions, _target);
  }

  public float GetDirection(PVector _position) {
    return field.GetDirection(_position);
  }

  public void ReportObstacle(PVector _position, float _size) {
    field.ReportObstacle(_position, _size);
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
