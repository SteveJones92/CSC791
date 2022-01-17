PGraphics menu;
color background = color(0);

PVector position;
float rotation;
ArrayList<PVector> positions = new ArrayList<PVector>();
FloatList rotations = new FloatList();
float t;
float startX;
float startY;

// starting values or things to do with the animation
float rotation_inc = 0;
int iter = 0;
float len = 0;
int step = 1;

float rotation_rate = 0.2f;
boolean next = false;
boolean free = false;
FloatList interestingRotations = new FloatList();


void setup() {
  // set framerate, size of window, and overlay of that size for the path to draw on
  frameRate(10);
  // size of the window -- apparently can't use a variable, if edited then change the createGraphics()
  // and start locations throughout
  size(1600, 900);
  background(background);
  menu = createGraphics( 100 + 20, 220);
  
  interestingRotations.append(18);
  interestingRotations.append(60);
  interestingRotations.append(90);
  //interestingRotations.append(120);
  
  startX = width / 2;
  startY = 0;
  t = millis();
  
}

void draw() {
  
  if (next && !free) {
    rotation_inc = 180;
    iter = 6;
    len = 9;
    free = true;
  }
  
  // every second
  if (!next && 50 < millis() - t) {
    t = millis();
    background(0);
    
    iter = min(6, iter + 1);
    len = min(9, len + 0.5);
    
    rotation_inc = min(120, rotation_inc + rotation_rate);
    
    if (step % 20 == 0) {
      rotation_rate = 2;
    }
    
    reset();
    
    step++;
  }
  
  if (rotation_inc == 120) {
    next = true;
  }
  
  if (next) {
    if (next && interestingRotations.size() > 0 && 1750 < millis() - t) {
      t = millis();
      rotation_inc = interestingRotations.remove(0);
      reset();
    }
  }
}

class Grammar {
  String ch;
  String str;
  
  public Grammar(String ch, String str) {
    this.ch = ch;
    this.str = str;
  }
}

void runGrammar(String a, int num) {
  if (a == null) return;
  
  ArrayList<Grammar> grammars = new ArrayList<Grammar>();
  grammars.add(new Grammar("A", "AA[-A++A][+A--A]"));
  grammars.add(new Grammar("Z", "A[-----Z][+++++Z]"));
  // replace characters how many times they need to be replaced
  for (int i = 0; i < num; i++) {
    for (Grammar item : grammars) {
      a = a.replaceAll(item.ch, item.str);
    }
  }
  for (int j = 0; j < a.length(); j++) {
    switch (a.substring(j, j + 1)) {
      case "A":
        A();
        break;
      case "+":
        rotation += radians(rotation_inc);
        break;
      case "-":
        rotation += radians(-rotation_inc);
        break;
      case "[":
        positions.add(new PVector(position.x, position.y));
        rotations.append(rotation);
        break;
      case "]":
        position = positions.remove(positions.size() - 1);
        rotation = rotations.remove(rotations.size() - 1);
        break;
      default: break;
    }
  }
}

void A() {
  float x = len * cos(rotation);
  float y = len * sin(rotation);
  stroke(color(random(150, 255), random(150, 255), random(150, 255)));
  line(position.x, position.y, position.x + x, position.y + y);
  position.x += x;
  position.y += y;
}
