boolean isDragging = false;
boolean ballWasTouched = false;
PShape ball;
PVector ballvel;
PVector ballpos;
PVector offset;
float prevX, prevY;
float prevXball, prevYball;
float prevMouseX, prevMouseY;
final int balldiameter = 50;
float speedball, speedmouse;
float gravity = 5;
float drag = 0.25;
boolean gamereset = true;

void setup() {
  frameRate(60);
  size(1600, 800);
  ballpos = new PVector(width/2, height/2);
  ballvel = new PVector(0, 0);
  ball = createShape(ELLIPSE, 0, 0, balldiameter, balldiameter);
  shape(ball);
}

void draw() {
  background(0);
  shape(ball, ballpos.x, ballpos.y);

  applyGravity();
  applyDrag();
  ballmove();
  mouseSpeed();
  isTouchingVoid();
  reset();
  startup();

  textSize(16);
  textAlign(LEFT, TOP);
  text("FPS: " + frameRate, 20, 40);
}

void startup()
{
  if (gamereset == true)
  {
    textSize(100);
    textAlign(CENTER);
    text("Tryk space for at starte", width/2, height/4);
    if (key == 32) {
      gamereset = false;
    }
  }
}

void ballmove()
{
  if (isDragging == true && ballWasTouched == true)
  {
    ballvel = new PVector(prevMouseX-mouseX, prevMouseY-mouseY);
    stroke(255);
    line(mouseX, mouseY, prevMouseX, prevMouseY);
    ballpos.x = offset.x+mouseX;
    ballpos.y = offset.y+mouseY;
  }
  if (isDragging == false && ballWasTouched == true)
  {
    ballpos.add(ballvel);
  }
}

void applyGravity() {
  ballvel.y += gravity;
}

void applyDrag() {
  PVector dragForce = ballvel.copy();
  dragForce.mult(-1);
  dragForce.normalize();
  dragForce.mult(drag);
  if (ballvel.x != 0 || ballvel.y != 0)
  {
    ballvel.add(dragForce);
  }
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
  if (ballpos.x >= width)
  {
    ballvel.x = -ballvel.x;
    ballpos.x = width-balldiameter/2;
  }
  if (ballpos.x <= 0)
  {
    ballvel.x = -ballvel.x;
    ballpos.x = balldiameter/2;
  }
  if (ballpos.y >= height - balldiameter / 2) {
    ballvel.y = -ballvel.y;
    ballpos.y = height - balldiameter / 2;
  }
  if (ballpos.y <= 0) {
    ballvel.y = -ballvel.y;
    ballpos.y = balldiameter/2;
  }
}

void reset()
{
  if (keyPressed) {
    if (key == 'r' || key == 'R') {
      ballpos.set(width/2, height/2);
      ballvel.set(0, 0);
      ballWasTouched = false;
      isDragging = false;
      gamereset = true;
    }
  }
}

void mouseSpeed()
{
  speedmouse = dist(prevX, prevY, mouseX, mouseY);
  fill(255);
  textSize(16);
  textAlign(LEFT, TOP);
  text("Mouse Speed: " + (speedmouse*frameRate) + "pixels/s", 20, 20);
  prevX = mouseX;
  prevY = mouseY;
}
