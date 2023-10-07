boolean isDragging = false;
PShape ball;
PVector ballpos;
PVector offset;
final int ballradius = 50;

void setup() {
  size(1000, 1000);
  ballpos = new PVector(width/2, height/2);
  ball = createShape(ELLIPSE, 0, 0, ballradius, ballradius);
  shape(ball);
}

void draw() {
  background(0);
  shape(ball, ballpos.x, ballpos.y);
}

void mousePressed() {
  float d = dist(mouseX, mouseY, ballpos.x, ballpos.y);
  if (d <= ballradius / 2) {
    isDragging = true;
  }
}

void mouseReleased() {
}
