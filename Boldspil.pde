boolean isDragging = false;
PShape ball;
PVector ballpos;
PVector offset;
final int balldiameter = 50;

void setup() {
  size(1000, 1000);
  ballpos = new PVector(width/2, height/2);
  ball = createShape(ELLIPSE, 0, 0, balldiameter, balldiameter);
  shape(ball);
}

void draw() {
  background(0);
  shape(ball, ballpos.x, ballpos.y);
  if(isDragging == true)
  {
   ballpos.x = offset.x+mouseX;
   ballpos.y = offset.y+mouseY;
  }
}

void mousePressed() {
  float d = dist(mouseX, mouseY, ballpos.x, ballpos.y);
  if (d <= balldiameter / 2) {
    isDragging = true;
    offset = new PVector(ballpos.x-mouseX,ballpos.y-mouseY);
  }
}

void mouseReleased() {
  isDragging = false;
}
