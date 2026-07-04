// Global color definitions
color background = color(0); // Background color for the sketch
color mainTriangleCol = color(255); // Color for the main triangle
color otherTrianglesCol = color(230); // Color for the other triangles
color redMenuColor = color(200, 0, 0); // Red color for menu elements
color greenMenuColor = color(0, 200, 0); // Green color for menu elements
color blueMenuColor = color(0, 0, 200); // Blue color for menu elements
color alphaMenuColor = color(100); // Alpha value for menu elements

// Global drawing settings
int num = 12; // Number of triangles to create radial symmetry
int size = 500; // Size of the main triangle
int frameRateSetting = 60; // Frame rate setting
int menuWidth = 120; // Width of the menu graphics context
int menuHeight = 220; // Height of the menu graphics context
int strokeWeightValue = 2; // Stroke weight for drawing
int strokeColorValue = 200; // Stroke color value for drawing
int fillColorValue = 255; // Fill color value for drawing
int strokeGrayValue = 100; // Stroke gray value for drawing

// Global color components for draw color
color drawColor; // Color used for drawing elements in the sketch
int red = 200; // Red component for draw color
int green = 50; // Green component for draw color
int blue = 50; // Blue component for draw color
int alpha = 200; // Alpha component for draw color

// Objects used in the sketch
Triangle tri; // Main triangle object
ArrayList<PVector> points = new ArrayList<PVector>(); // List of points for additional drawing elements
PGraphics menu; // Graphics context for the menu

void setup() {
  frameRate(frameRateSetting); // Set the frame rate
  fullScreen(); // Set the sketch to full screen
  background(background); // Set the background color
  menu = createGraphics(menuWidth, menuHeight); // Create a graphics context for the menu

  stroke(strokeGrayValue); // Set the stroke color
  fill(fillColorValue); // Set the fill color
  strokeWeight(strokeWeightValue); // Set the stroke weight
  stroke(strokeColorValue); // Set the stroke color
  drawColor = color(red, green, blue, alpha); // Initialize the draw color using RGBA values

  float split = 360 / num; // Calculate the angle split for radial symmetry
  PVector center = new PVector(width / 2, height / 2); // Define the center point of the screen
  tri = new Triangle(new PVector(center.x, center.y), size, split, 0); // Create the main triangle at the center
  reset(); // Call the reset function to initialize the sketch
}

void draw() {
  reset(); // Reset the sketch at the beginning of each frame
}
