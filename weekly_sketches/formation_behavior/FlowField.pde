public class FlowField {
  private FlowCell[][] grid;
  
  private float cellRadius;
  private float cellDiameter;
  private int numX;
  private int numY;
  
  public boolean reverse = false;
  
  // create the initial grid
  public FlowField(float _cellSize) {
    if (!CreateGrid(_cellSize)) {
      println("Grid not created");
    }
  }
  
  private void UpdateGrid(FlowCell target) {
    // reset all best costs and costs
    for (int i = 0; i < numX; i++) {
      for (int j = 0; j < numY; j++) {
        grid[i][j].SetBestCost(999);
        if (grid[i][j].cost != 255) grid[i][j].cost = 1;
      }
    }
    
    target.SetBestCost(0);
    if (target.cost != 255) target.cost = 0;
    target.strength = 1;
    
    // go from target outwards
    ArrayList<FlowCell> openList = new ArrayList<FlowCell>();
    
    target.set = true;
    openList.add(target);
    
    FlowCell current;
    while (openList.size() > 0) {
      current = openList.remove(0);
      if (PositionToIndex(player.position)[0] == PositionToIndex(current.position)[0] && PositionToIndex(player.position)[1] == PositionToIndex(current.position)[1]) {
        break;
      }
      for (FlowCell neighbor : current.neighbors) {
        if (neighbor.cost == 255) continue;
        if (neighbor.cost + current.bestCost < neighbor.bestCost) {
          neighbor.SetBestCost(neighbor.cost + current.bestCost);
          current.set = true;
          openList.add(neighbor);
        }
      }
    }
    
    // update the directions to point towards lower costing neighbor
    int best;
    // go through the entire grid, check all the neighbors and see which has the best cost
    // set direction to point towards that neighbhor
    for (int i = 0; i < numX; i++) {
        for (int j = 0; j < numY; j++) { 
          if (!grid[i][j].set) continue;
          best = grid[i][j].bestCost;
          
          FlowCell current_best = null;
          for (FlowCell neighbor : grid[i][j].neighbors) {
            if (neighbor.bestCost < best) {
              best = neighbor.bestCost;
              current_best = neighbor;
            }
          }
          if (current_best != null) {
            if (reverse) grid[i][j].direction = 180 - degrees(atan2(current_best.position.y - grid[i][j].position.y, current_best.position.x - grid[i][j].position.x));
            else grid[i][j].direction = 180 - degrees(atan2(grid[i][j].position.y - current_best.position.y, grid[i][j].position.x - current_best.position.x));
          }
        }
    }
  }
  
  // update the flowfield to account for an obstacle
  public void ReportObstacle(PVector position, float radius) {
    int[] index = PositionToIndex(position);
    grid[index[0]][index[1]].IncreaseCost(255);
  }
  
  public void ReportTarget(PVector position) {
    int[] index = PositionToIndex(position);
    if (grid[index[0]][index[1]].cost != 0) {
      // update grid
      UpdateGrid(grid[index[0]][index[1]]);
    }
  }
  
  public int[] PositionToIndex(PVector position) {
    return new int[] { (int)(position.x / cellDiameter), (int)(position.y / cellDiameter) };
  }
  
  // return new cell size that perfectly divides
  private boolean CreateGrid(float _cellSize) {
    float originalCellSize = _cellSize;
    float checkX = 0;
    float checkY = 0;
    
    int rangeToCheck = 10;
    // continuously check for an even splitting cellSize for width and height
    // if deviating too much from the given cell size
    while (originalCellSize - _cellSize <= rangeToCheck) {
      checkX = width / _cellSize;
      checkY = height / _cellSize;
      // round to 2 decimal places
      checkX = round(checkX * 100) / 100.0f;
      checkY = round(checkY * 100) / 100.0f;
      // an even split found
      if ( (floor(checkX) == checkX && floor(checkY) == checkY)) break;
      _cellSize -= .01f;
      // round to 2 decimal places
      _cellSize = round(_cellSize * 100) / 100.0f;
    }
    
    // if it ended due to this condition, then return false the grid could not have been created
    if (originalCellSize - _cellSize > rangeToCheck) {
      println("Last Checked: " + checkX + ", " + checkY + "  ,  Cell size: " + _cellSize);
      return false;
    }
    
    // set to new size and radius
    cellDiameter = _cellSize;
    cellRadius = _cellSize / 2;
    println("Input Cell Size: " + originalCellSize);
    println("Cell Size Used: " + _cellSize);
    
    numX = (int) checkX;
    numY = (int) checkY;
    
    // create and populate the grid
    grid = new FlowCell[numX][numY];
    
    for (int i = 0; i < numX; i++) {
      for (int j = 0; j < numY; j++) {
        grid[i][j] = new FlowCell(i, j, cellDiameter);
      }
    }
    
    // add neighbors
    for (int i = 0; i < numX; i++) {
      for (int j = 0; j < numY; j++) {
            // add left neighbor
            if (i != 0) grid[i][j].neighbors.add(grid[i - 1][j]);
            // add right neighbor
            if (i != numX - 1) grid[i][j].neighbors.add(grid[i + 1][j]);
            // add top neighbor
            if (j != 0) grid[i][j].neighbors.add(grid[i][j - 1]);
            // add bottom neighbor
            if (j != numY - 1) grid[i][j].neighbors.add(grid[i][j + 1]);
            // add corners
            if (i != 0 && j != 0) grid[i][j].neighbors.add(grid[i - 1][j - 1]);
            if (i != numX - 1 && j != 0) grid[i][j].neighbors.add(grid[i + 1][j - 1]);
            if (i != 0 && j != numY - 1) grid[i][j].neighbors.add(grid[i - 1][j + 1]);
            if (i != numX - 1 && j != numY - 1) grid[i][j].neighbors.add(grid[i + 1][j + 1]);
      }
    }
    
    return true;
  }
  
  public void Display(PGraphics guiLayer) {
    for (int i = 0; i < numX; i++) {
      for (int j = 0; j < numY; j++) {
        grid[i][j].Display(guiLayer);
      }
    }
  }
}
