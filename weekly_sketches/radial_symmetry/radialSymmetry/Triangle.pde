class Triangle {
  PVector first;
  PVector second;
  PVector third;
  PVector center;
  
  public Triangle(PVector first, PVector second, PVector third) {
    this.first = first;
    this.second = second;
    this.third = third;
    center = new PVector((first.x + second.x + third.x) / 3, (first.y + second.y + third.y) / 3);
  }
  
  void display() {    
    triangle(first.x, first.y, second.x, second.y, third.x, third.y);
  }
}
