// TODO make paper moveable, triangles are currently independent
// TODO get triangles to reflect about a line
// TODO issue with placement, different sizes at different scale
class Paper {
  // initial position 0
  PVector position = new PVector(width / 2, height / 2);
  // standard paper dimensions
  PVector dimensions = new PVector(8.5, 8.5);
  // pixels to inches conversion is 96 pixels per inch - so this is half real page size
  int scale = 96 / 2;
  // square units, ie 2 triangles - how small they are which equals detail
  float resolution = 100;
  
  int level = 0;
  
  ArrayList<Triangle> pieces = new ArrayList<Triangle>();
  
  ArrayList<Triangle> selected = new ArrayList<Triangle>();
  
  
  public Paper() {
    float startX = position.x - (dimensions.x * scale) / 2;
    float startY = position.y - (dimensions.y * scale) / 2;
    float halfRes = resolution / 2;
    
    for (float i = startX; i < startX + dimensions.x * scale; i += resolution) {
      for (float j = startY; j < startY + dimensions.y * scale; j += resolution) {
        float leftX = i;
        float middleX = i + halfRes;
        float rightX = i + resolution;
        float topY = j;
        float middleY = j + halfRes;
        float bottomY = j + resolution;
        
        // TODO add joints to drag by? could figure some math to find proper joints by checking preserved areas
        // risk of folds needed to not line up on each other, can't cut arbitrary shapes off of stacked triangles
        pieces.add(new Triangle(new PVector(leftX, topY), new PVector(middleX, topY), new PVector(middleX, middleY)));
        pieces.add(new Triangle(new PVector(leftX, topY), new PVector(leftX, middleY), new PVector(middleX, middleY)));
        
        
        pieces.add(new Triangle(new PVector(middleX, topY), new PVector(rightX, topY), new PVector(middleX, middleY)));
        pieces.add(new Triangle(new PVector(middleX, middleY), new PVector(rightX, topY), new PVector(rightX, middleY)));
        
        pieces.add(new Triangle(new PVector(leftX, middleY), new PVector(middleX, middleY), new PVector(leftX, bottomY)));
        pieces.add(new Triangle(new PVector(leftX, bottomY), new PVector(middleX, bottomY), new PVector(middleX, middleY)));
        
        pieces.add(new Triangle(new PVector(middleX, bottomY), new PVector(rightX, bottomY), new PVector(middleX, middleY)));
        pieces.add(new Triangle(new PVector(rightX, bottomY), new PVector(rightX, middleY), new PVector(middleX, middleY)));
      }
    }
  }
  
  void display() {
    selected = new ArrayList<Triangle>();
    for (Triangle item : pieces) {
      if (dist(mouseX, mouseY, item.center.x, item.center.y) < resolution / 3 &&
          isInside(new PVector(mouseX, mouseY), item.first, item.second, item.third)) {
        selected.add(item);
        fill(150);
      } else fill(255);
      item.display();
    }
      stroke(color(200, 100, 100));
      strokeWeight(5);
      noFill();
      ellipse(width / 2, height / 2, dimensions.x * scale, dimensions.y * scale);
      fill(255);
      stroke(100);
      strokeWeight(0.5);
  }
}
