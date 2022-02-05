ArrayList<Snowflake> flakes = new ArrayList<Snowflake>();

void setup() {
  size(1600, 900);
}

void draw() {
  background(0);
  if (frameCount % 30 == 0) for (int i = 0; i < (int)random(10, 50); i++) flakes.add(new Snowflake());
  for (Snowflake flake : flakes) flake.display();
  
}

class Snowflake {
  PShape flake;
  PVector size = new PVector(0, 0);
  PVector position = new PVector(random(0, width), -10);
  float drift = 0;
  float direction;
  float speed = 1.5;
  float inverse_speed;
  float side_distance;
  
  public Snowflake() {
    // can be taller
    size.y = random(5, 8);
    // than wide, for pointy shape
    size.x = random(size.y / 2, size.y);
    
    // pointier shapes are faster falling, ratio is 1 or higher
    speed *= size.y / size.x;
    inverse_speed = size.x / size.y;
    
    // pointier shapes dont move side to side as 
    direction = (random(1) < 0.5 ? -inverse_speed : inverse_speed) * .2f;
    side_distance = inverse_speed * 30;
    
    flake = createShape(ELLIPSE, 0, 0, size.x, size.y);
  }
  
  void display() {
    if (abs(drift) > side_distance) direction *= -1;
    drift += direction;
    position.y += speed;
    if (position.y > height || position.y > 0 && get((int)position.x + 5, (int)position.y) != color(0)) {
          position.y -= speed;
          drift -= direction;
    }
    shape(flake, position.x + drift, position.y);
  }
}
