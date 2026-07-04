class Triangle {
  // Vertices of the triangle
  PVector first; // The first vertex, typically the center of the triangle
  PVector second; // The second vertex of the triangle
  PVector third; // The third vertex of the triangle
  
  // Color of the triangle, initialized to the main triangle color
  color col = mainTriangleCol;
  
  // Length of the triangle's sides, angle between the sides, and current rotation
  float len; // Length of each side of the triangle
  float angle = 0; // Angle between the sides of the triangle
  float rotation; // Current rotation of the triangle in degrees
  
  // List of additional shapes associated with the triangle and their colors
  ArrayList<PShape> shapes = new ArrayList<PShape>(); // List of PShape objects representing additional shapes
  ArrayList<Integer> shape_colors = new ArrayList<Integer>(); // List of colors corresponding to the shapes
  
  ArrayList<PShape> shapes_stack = new ArrayList<PShape>();
  ArrayList<Integer> shape_colors_stack = new ArrayList<Integer>();
  
  // Constructor: initializes the triangle's vertices based on the given center, length, angle, and rotation
  public Triangle(PVector center, float len, float angle, float rotation) {
    this.first = center; // Set the center point of the triangle
    this.len = len; // Set the length of each side
    this.angle = angle; // Set the angle between the sides
    this.rotation = rotation; // Set the initial rotation
    
    // Calculate the positions of the second and third vertices based on the rotation and angle
    this.second = new PVector(center.x + len * cos(radians(rotation)), center.y + len * sin(radians(rotation)));
    this.third = new PVector(center.x + len * cos(radians(rotation + angle)), center.y + len * sin(radians(rotation + angle)));
  }
  
  // Display the triangle and any additional shapes
  void display() {
    fill(col); // Set the fill color for the triangle
    triangle(first.x, first.y, second.x, second.y, third.x, third.y); // Draw the triangle using its vertices
    
    // Draw each additional shape associated with the triangle
    for (PShape shape : shapes) {
      shape(shape); // Display the shape
    }
  }
  
  // Rotate the triangle and its shapes by the given degrees
  void rotate(float degrees) {
    // Update the positions of the second and third vertices based on the new rotation angle
    this.second = new PVector(first.x + len * cos(radians(rotation + degrees)), first.y + len * sin(radians(rotation + degrees)));
    this.third = new PVector(first.x + len * cos(radians(rotation + angle + degrees)), first.y + len * sin(radians(rotation + angle + degrees)));
    rotation += degrees; // Update the rotation value
    
    // Rotate each additional shape associated with the triangle
    for (PShape shape : shapes) {
      for (int i = 0; i < shape.getVertexCount(); i++) {
        PVector vertex = shape.getVertex(i); // Get the current vertex of the shape
        PVector new_vertex = new PVector(); // Create a new vertex to store the rotated position
        
        // Calculate the new position of the vertex after rotation
        new_vertex.x = (vertex.x - width / 2) * cos(radians(degrees)) - (vertex.y - height / 2) * sin(radians(degrees)) + width / 2;
        new_vertex.y = (vertex.x - width / 2) * sin(radians(degrees)) + (vertex.y - height / 2) * cos(radians(degrees)) + height / 2;
        
        shape.setVertex(i, new_vertex); // Update the vertex position
      }
    }
  }
  
  // Mirror the shapes associated with the triangle
  void mirror() {
    // Mirror each shape associated with the triangle
    for (PShape shape : shapes) {
      for (int i = 0; i < shape.getVertexCount(); i++) {
        PVector vertex = shape.getVertex(i); // Get the current vertex of the shape
        PVector new_vertex = new PVector(); // Create a new vertex to store the mirrored position
        
        // Calculate the new position of the vertex after mirroring
        new_vertex.x = (vertex.x - width / 2) * cos(-radians(rotation + angle / 2)) - (vertex.y - height / 2) * sin(-radians(rotation + angle / 2)) + width / 2;
        new_vertex.y = (vertex.x - width / 2) * sin(-radians(rotation + angle / 2)) + (vertex.y - height / 2) * cos(-radians(rotation + angle / 2)) + height / 2;
        new_vertex.y = (new_vertex.y - height / 2) * -1 + height / 2; // Reflect across the horizontal axis
        
        shape.setVertex(i, new_vertex); // Update the vertex position
      }
    }
    
    // Apply additional transformation to each shape associated with the triangle
    for (PShape shape : shapes) {
      for (int i = 0; i < shape.getVertexCount(); i++) {
        PVector vertex = shape.getVertex(i); // Get the current vertex of the shape
        PVector new_vertex = new PVector(); // Create a new vertex to store the transformed position
        
        // Calculate the new position of the vertex after the additional transformation
        new_vertex.x = (vertex.x - width / 2) * cos(radians((rotation + angle / 2))) - (vertex.y - height / 2) * sin(radians((rotation + angle / 2))) + width / 2;
        new_vertex.y = (vertex.x - width / 2) * sin(radians((rotation + angle / 2))) + (vertex.y - height / 2) * cos(radians((rotation + angle / 2))) + height / 2;
        
        shape.setVertex(i, new_vertex); // Update the vertex position
      }
    }
  }
  
  // Create and return a copy of the current triangle
  Triangle copy() {
    Triangle ret = new Triangle(new PVector(first.x, first.y), len, angle, rotation); // Create a new triangle with the same properties
    int i = 0;
    
    // Copy each shape associated with the current triangle
    for (PShape shape : shapes) {
      PShape new_shape = shape_clone(shape); // Clone the current shape
      new_shape.setFill(shape_colors.get(i)); // Set the fill color of the cloned shape
      ret.shapes.add(new_shape); // Add the cloned shape to the new triangle
      i++;
    }

    return ret; // Return the new triangle
  }
  
  void undo() { 
    if (tri.shapes.size() > 0) {
      int last_index = tri.shapes.size() - 1;
      PShape shape = tri.shapes.get(last_index);
      int shape_color = tri.shape_colors.get(last_index);
      tri.shapes.remove(last_index);
      tri.shape_colors.remove(last_index);
      shapes_stack.add(shape);
      shape_colors_stack.add(shape_color);
    }
  }
  
  void redo() {
    if (tri.shapes_stack.size() > 0) {
      int last_index = tri.shapes_stack.size() - 1;
      
      PShape shape_stack = tri.shapes_stack.get(last_index);
      int shape_color_stack = tri.shape_colors_stack.get(last_index);
      tri.shapes_stack.remove(last_index);
      tri.shape_colors_stack.remove(last_index);
      shapes.add(shape_stack);
      shape_colors.add(shape_color_stack);
    }
  }
  
  void clear_redo() {
    tri.shapes_stack.clear();
    tri.shape_colors_stack.clear();
  }
  
  void clear_all() {
    tri.shapes.clear();
    tri.shape_colors.clear();
    tri.shapes_stack.clear();
    tri.shape_colors_stack.clear();
  }
}
