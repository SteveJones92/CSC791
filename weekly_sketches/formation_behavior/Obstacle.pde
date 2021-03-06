public class Obstacles {
  private PGraphics guiLayer;
  public boolean display = true;
  
  public Obstacles() {
    guiLayer = createGraphics(width, height);
    guiLayer.fill(255);
  }
  
  void AddObstacle(PVector location, float size) {
    guiLayer.beginDraw();
    guiLayer.ellipse(location.x, location.y, size, size);
    guiLayer.endDraw();
    player.targetGrid.ReportObstacle(location, size / 2);
  }
  
  void Display() {
    if (display) {
      image(guiLayer, 0, 0);
    }
  }
}
