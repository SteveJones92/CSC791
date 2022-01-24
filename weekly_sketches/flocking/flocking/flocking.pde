ArrayList<Boid> boids = new ArrayList<Boid>();
Boid player;

int num_boids = 100;

void setup () {
  size(1600, 900);
  frameRate(60);
  background(0);

  for (int x = 0; x < num_boids; x++) {
    boids.add(new Boid(new PVector(random(width), random(height), random(100)), // pos - random
                       new PVector(random(1), random(1), random(1)), // velocity
                       color(random(100, 255), random(100, 255), random(100, 255)), // random color
                       20)); // size
  }
  
  player = new Boid(new PVector(width / 2, height / 2), // pos - start center
                    new PVector(1, 0, 0), // velocity
                    color(random(100, 255), random(100, 255), random(100, 255)), // random color
                    20); // size
}

void draw() {
  background(0);
  
  for (Boid boid : boids) boid.update();
  
  //player.update();
}
