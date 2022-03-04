
public class ShipCell {
  PVector shipPos;
  // formation position, need to use GetFormationPos as shipPos will move but fPos is only an offset
  PVector fPos;
  // real position
  PVector rPos;
  // cell size (diameter)
  float size;

  public ShipCell(PVector _shipPos, PVector _position, float _size) {
    shipPos = _shipPos;
    fPos = new PVector(_position.x - shipPos.x, _position.y - shipPos.y);
    rPos = _position;
    size = _size;
  }

  // try to keep formation position
  public float UpdateDirection(float _direction, float power) {
    PVector f = GetFormationPos();

    if (f.dist(rPos) < 3) return -1;
    //if (_direction == -1) return -1;

    float direction = degrees(atan2(rPos.y - f.y, f.x - rPos.x));
    if (direction < 0) direction += 360;
    //println("vector: " + _direction);
    //println("format: " + direction);
    float val = _direction - direction;
    if (val > 180) {
      val = val - 360;
    } else if (val < -180) {
      val = (val + 360);
    }
    val *= power;
    direction += val;
    //println("Power : " + power);
    //println("Format: " + direction);
    //println();
    
    // merge direction and direction based on power, 0 = 100% towards formation position, .5 = 50% towards formation and 50% from vector field
    // 1 = 100% vector field (avoiding a wall)
    //_direction = degrees(atan2( (sin(radians(_direction)) + sin(radians(direction))) / 2,
    //                            (cos(radians(_direction)) + cos(radians(direction))) / 2 ));
    
    return direction;
  }

  private PVector GetFormationPos() {
    return new PVector(shipPos.x + fPos.x, shipPos.y + fPos.y);
  }


  public void Display(PGraphics _layer) {
    _layer.fill(255, 255, 255);
    _layer.ellipse(rPos.x, rPos.y, size, size);
  }
}
