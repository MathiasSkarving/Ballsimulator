boolean isDragging = false;
boolean ballWasTouched = false;
PShape ball;
PVector ballvel;
PVector ballpos;
PVector offset;
float prevX;
float prevY;
float prevMouseX, prevMouseY;
final int balldiameter = 50;
float ballspeed, speed;

float gravity = 9.82;
float drag = 0.01;

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

  text("FPS: " + frameRate, 20, 40);
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
    ballpos.add(ballvel); // Update ball position based on velocity
  }
}

void applyGravity() {
  ballvel.y += gravity; // Apply gravity by incrementing the Y velocity
}

void applyDrag() {
  PVector dragForce = ballvel.copy(); // Create a copy of the velocity
  dragForce.mult(-1);  // Reverse the direction to create drag force
  dragForce.normalize(); // Normalize to get the direction
  dragForce.mult(drag); // Scale by the drag coefficient
  ballvel.add(dragForce); // Apply drag force to the velocity
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
  if (ballpos.x >= width || ballpos.x <= 0)
    ballvel.x = -ballvel.x;
  if (ballpos.y >= height - balldiameter / 2) {
    ballvel.y = -ballvel.y;
    ballpos.y = height - balldiameter / 2;
  }
  if (ballpos.y <= 0) {
    ballvel.y = -ballvel.y;
    ballpos.y = 0;
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
    }
  }
}

void mouseSpeed()
{
  speed = dist(prevX, prevY, mouseX, mouseY);
  fill(255);
  textSize(16);
  text("Mouse Speed: " + (speed*60) + "pixels/s", 20, 20);
  prevX = mouseX;
  prevY = mouseY;
}
