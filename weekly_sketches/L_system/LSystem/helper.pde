void mousePressed() {
  if (mouseX >= width - 100 - 20 && mouseX <= width - 20 && mouseY > 20 && mouseY < 220) {
    if (mouseY > 40 && mouseY < 50) {
      rotation_inc = map(100 - (width - 20 - mouseX), 0, 100, 0, 360);
    }
    else if (mouseY > 80 && mouseY < 90) {
      iter = (int) map(100 - (width - 20 - mouseX), 0, 100, 0, 15);
    }
    else if (mouseY > 120 && mouseY < 130) {
      startX = map(100 - (width - 20 - mouseX), 0, 100, 0, width);
    }
    else if (mouseY > 160 && mouseY < 170) {
      startY = map(100 - (width - 20 - mouseX), 0, 100, 0, height);
    }
    else if (mouseY > 200 && mouseY < 210) {
      len = (int) map(100 - (width - 20 - mouseX), 0, 100, 0, 200);
    }
  }
  
  reset();
}

void reset() {
  background(0);
  strokeWeight(1);
  position = new PVector(startX, height - startY);
  rotation = -radians(90);
  runGrammar("Z", iter);
  
  // draw menu
  menu.beginDraw();
  menu.clear();
  menu.stroke(255);
  menu.strokeWeight(5);
  
  menu.text("Rotation: 0-360", 0, 20);
  menu.line(0, 25, 100, 25);
  menu.text("" + rotation_inc, 0, 40);
  
  menu.text("Depth: 0-15", 0, 60);
  menu.line(0, 65, 100, 65);
  menu.text("" + iter, 0, 80);
  
  menu.text("StartX: 0-" + width, 0, 100);
  menu.line(0, 105, 100, 105);
  menu.text("" + startX, 0, 120);
  
  menu.text("StartY: 0-" + height, 0, 140);
  menu.line(0, 145, 100, 145);
  menu.text("" + startY, 0, 160);
  
  menu.text("Line Length: 0-200", 0, 180);
  menu.line(0, 185, 100, 185);
  menu.text("" + len, 0, 200);
  
  menu.endDraw();
  image(menu, width - 100 - 20, 20);
}
