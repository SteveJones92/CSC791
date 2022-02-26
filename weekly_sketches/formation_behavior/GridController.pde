// controls visual aspects of the grid
public class GridController {
  private PGraphics guiLayer;
  public FlowField field;
  private color gridColor = color(255, 255, 255, 30);
  public boolean display = true;
  
  public GridController(float _cellSize) {
    field = new FlowField(_cellSize);
    guiLayer = createGraphics(width, height);
  }
  
  public void Display() {
    if (display) {
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
