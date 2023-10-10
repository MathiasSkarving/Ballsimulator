boolean isDragging = false;
boolean ballWasTouched = false;
PShape ball;
PVector ballmove;
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
  ballmove = new PVector(0, 0);
  ball = createShape(ELLIPSE, 0, 0, balldiameter, balldiameter);
  shape(ball);
}

void draw() {
  background(0);
  shape(ball, ballpos.x, ballpos.y);
  if (isDragging == true && ballWasTouched == true)
  {
    ballmove = new PVector(prevMouseX-mouseX, prevMouseY-mouseY);
    stroke(255);
    line(mouseX, mouseY, prevMouseX, prevMouseY);
    ballpos.x = offset.x+mouseX;
    ballpos.y = offset.y+mouseY;
  }
  if (isDragging == false && ballWasTouched == true)
  {
    ballpos.x = ballpos.x+ballmove.x;
    ballpos.y = ballpos.y+ballmove.y;
  }

  mouseSpeed();
  isTouchingVoid();
  reset();

  text("FPS: " + frameRate, 20, 40);
}

void mousePressed() {
  float d = dist(mouseX, mouseY, ballpos.x, ballpos.y);
  if (d <= balldiameter / 2) {
    isDragging = true;
    ballWasTouched = true;
    offset = new PVector(ballpos.x-mouseX, ballpos.y-mouseY);
    prevMouseX = mouseX;
    prevMouseY = mouseY;
  }
}

void mouseReleased() {
  isDragging = false;
}

void isTouchingVoid()
{
  if (ballpos.x > width || ballpos.x < 0)
    ballmove.x = -ballmove.x;
  if (ballpos.y > height || ballpos.y < 0)
    ballmove.y = -ballmove.y;
}

void reset()
{
  if (keyPressed) {
    if (key == 'r' || key == 'R') {
      ballpos.set(width/2, height/2);
      ballmove.set(0,0);
    }
  }
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
