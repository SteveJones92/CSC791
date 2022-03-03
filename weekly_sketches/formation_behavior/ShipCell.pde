
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
  public float UpdateDirection(float _direction, float rate) {
    PVector f = GetFormationPos();

    if (f.dist(rPos) < 3) return -1;

    float direction = degrees(atan2(rPos.y - f.y, f.x - rPos.x));
    if (random(1) < rate) {
      return direction;
    }
    return _direction;
  }

  private PVector GetFormationPos() {
    return new PVector(shipPos.x + fPos.x, shipPos.y + fPos.y);
  }


  public void Display(PGraphics _layer) {
    _layer.fill(255, 255, 255);
    _layer.ellipse(rPos.x, rPos.y, size, size);
  }
}
