public class FlowField {
  // grid of cells
  private FlowCell[][] grid;
  
  // diameter and radius of cell
  private float cellDiameter;

  // dimensions of grid
  private int numX;
  private int numY;
  
  private FlowCell lastTarget;
  
  // create the initial grid
  public FlowField(float _cellSize) {
    CreateGrid(_cellSize);
  }

  public float GetDirection(PVector _position) {
    int[] index = PositionToIndex(_position);
    return grid[index[0]][index[1]].direction;
  }
  
  public float GetWallPower(PVector _position) {
    int[] index = PositionToIndex(_position);
    return grid[index[0]][index[1]].wallPower;
  }
  
  private void UpdateGrid(PVector _position, ArrayList<PVector> _positions, PVector _target) {
    ArrayList<FlowCell> cellsNeeded = new ArrayList<>();
    // get a list of FlowCell's that need to be "covered" by the algorithm
    for (PVector item : _positions) {
      int[] pos = PositionToIndex(item);
      FlowCell cell = grid[pos[0]][pos[1]];
      if (cell.cost == 255) return;
      cellsNeeded.add(cell);
      cell.needsCovering = true;
    }
    
    int[] pIndex = PositionToIndex(_position);
    int[] index = PositionToIndex(_target);
    
    // if the position is a wall, dont update
    if (grid[pIndex[0]][pIndex[1]].cost == 255) {
      return;
    }
    
    FlowCell c = grid[pIndex[0]][pIndex[1]];
    cellsNeeded.add(c);
    c.needsCovering = true;
    
    // reset all best costs and costs
    for (int i = 0; i < numX; i++) {
      for (int j = 0; j < numY; j++) {
        grid[i][j].SetBestCost(Integer.MAX_VALUE);
        grid[i][j].direction = -1;
        grid[i][j].set = false;
        
        // only reset costs that arent walls
        if (grid[i][j].cost != 255) grid[i][j].cost = 1;
      }
    }
    
    FlowCell target = grid[index[0]][index[1]];
    if (target.cost == 255) {
      target = lastTarget;
    } else {
      lastTarget = target;
      target.SetBestCost(0);
      target.cost = 0;
    }
    
    // go from target outwards
    ArrayList<FlowCell> openList = new ArrayList<>();
    
    target.set = true;
    openList.add(target);
    
    FlowCell current;
    while (openList.size() > 0) {
      current = openList.remove(0);
      
      current.needsCovering = false;
      
      boolean covered = true;
      for (int i = 0; i < cellsNeeded.size(); i++) {
        if (cellsNeeded.get(i).needsCovering) {
          covered = false;
          break;
        } else {
          cellsNeeded.remove(i--);
        }
      }
      if (covered) break;
      
      for (FlowCell neighbor : current.neighbors) {
        if (neighbor.cost + current.bestCost < neighbor.bestCost) {
          neighbor.SetBestCost(neighbor.cost + current.bestCost);
          neighbor.set = true;
          // dont insert if it is a wall
          if (neighbor.cost != 255)
            InsertPriority(openList, neighbor);
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
            grid[i][j].direction = 180 - degrees(atan2(grid[i][j].position.y - current_best.position.y, grid[i][j].position.x - current_best.position.x));
          }
        }
    }
  }
  
  private void InsertPriority(ArrayList<FlowCell> list, FlowCell item) {
    if (list.size() == 0) {
      list.add(item);
      return;
    }
    
    // check to add to end
    if (list.get(list.size() - 1).bestCost <= item.bestCost) {
      list.add(item);
      return;
    }
    
    // find the right spot
    for (int i = 0; i < list.size(); i++) {
      //println(list.size());
      if (list.get(i).bestCost > item.bestCost) {
        list.add(i, item);
        return;
      }
    }
  }
  
  // update the flowfield to account for an obstacle
  // need to check if squares are containing it
  public void ReportObstacle(PVector _position, float _radius) {
    int[] startPos = PositionToIndex(new PVector(_position.x - _radius, _position.y - _radius));
    int[] endPos = PositionToIndex(new PVector(_position.x + _radius, _position.y + _radius));
    int xRange = endPos[0] - startPos[0] + 1;
    int yRange = endPos[1] - startPos[1] + 1;
    startPos[0] -= xRange * 2;
    endPos[0] += xRange * 2;
    startPos[1] -= yRange * 2;
    endPos[1] += yRange * 2;
    
    FlowCell cell;
    for (int i = startPos[0]; i <= endPos[0]; i++) {
      for (int j = startPos[1]; j <= endPos[1]; j++) {
        cell = grid[i][j];
        if (isCollidingCircleRectangle(_position.x, _position.y, _radius, cell.guiPosition.x, cell.guiPosition.y, cell.diameter, cell.diameter)) {
          cell.IncreaseCost(255);
          cell.wallPower = 1.f;
        } else if (i >= startPos[0] + xRange && i <= endPos[0] - xRange && j >= startPos[1] + yRange && j <= endPos[1] - yRange) {
          cell.wallPower = max(cell.wallPower, 0.66f);
        } else {
          cell.wallPower = max(cell.wallPower, 0.33f);
        }
      }
    }
  }
  
  public int[] PositionToIndex(PVector _position) {
    return new int[] { floor(_position.x / cellDiameter), floor(_position.y / cellDiameter) };
  }
  
  public void Display(PGraphics _guiLayer) {
    for (int i = 0; i < numX; i++) {
      for (int j = 0; j < numY; j++) {
        grid[i][j].Display(_guiLayer);
      }
    }
  }

  // return new cell size that perfectly divides
  private void CreateGrid(float _cellSize) {
    float originalCellSize = _cellSize;
    float checkX = 0;
    float checkY = 0;
    
    // continuously check for an even splitting cellSize for width and height
    while (true) {
      checkX = width / _cellSize;
      checkY = height / _cellSize;

      // an even split found (both whole numbers)
      //if ( (floor(checkX) == checkX && floor(checkY) == checkY)) break;
      if ( (checkX - floor(checkX) < 0.2f && checkY - floor(checkY) < 0.2f)) break;
      _cellSize -= .01f;
      // round to 2 decimal places
      _cellSize = round(_cellSize * 100) / 100.0f;
    }
    
    // set to new size and radius
    cellDiameter = _cellSize;
    println("Input Cell Size: " + originalCellSize);
    println("Cell Size Used: " + _cellSize);
    
    // was very close to whole integer for both confirmed
    numX = (int) checkX;
    numY = (int) checkY;
    println("Num Wide: " + numX);
    println("Num Tall: " + numY);
    
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
  }
}
