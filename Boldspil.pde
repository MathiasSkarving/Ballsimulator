boolean isDragging = false;
PShape ball;
PVector ballpos;
PVector offset;
float prevX;
float prevY;
float prevMouseX, prevMouseY;

final int balldiameter = 50;

void setup() {
  frameRate(60);
  size(1920, 1080);
  ballpos = new PVector(width/2, height/2);
  ball = createShape(ELLIPSE, 0, 0, balldiameter, balldiameter);
  shape(ball);
}

void draw() {
  background(0);
  shape(ball, ballpos.x, ballpos.y);
  if (isDragging == true)
  {
    stroke(255);
    line(mouseX, mouseY,prevMouseX,prevMouseY);
    ballpos.x = offset.x+mouseX;
    ballpos.y = offset.y+mouseY;
  }

  mouseSpeed();

  text("FPS: " + frameRate, 20, 40);
}

void mousePressed() {
  float d = dist(mouseX, mouseY, ballpos.x, ballpos.y);
  if (d <= balldiameter / 2) {
    isDragging = true;
    offset = new PVector(ballpos.x-mouseX, ballpos.y-mouseY);
    prevMouseX = mouseX; 
    prevMouseY = mouseY;
  }
}

void mouseReleased() {
  isDragging = false;
}

void mouseSpeed()
{
  float speed = dist(prevX, prevY, mouseX, mouseY);
  fill(255);
  textSize(16);
  text("Mouse Speed: " + (speed*60) + "pixels/s", 20, 20);
  prevX = mouseX;
  prevY = mouseY;
}
