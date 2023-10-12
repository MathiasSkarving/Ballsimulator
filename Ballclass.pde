class Ball {
  boolean isDragging = false;
  boolean ballWasTouched = false;
  PShape ball;
  PVector ballvel;
  PVector ballpos;
  PVector offset;
  PVector gravityForce;
  float prevX, prevY;
  float prevXball, prevYball;
  float prevMouseX, prevMouseY;
  final int balldiameter = 50;
  float speedball, speedmouse;
  float gravity = 9.82;
  float drag = 0.75;
  float energyconserved = 0.77;
  boolean gamereset = true;

  Ball(int x, int y)
  {
    gravityForce = new PVector(0, gravity);
    ballpos = new PVector(x, y);
    ballvel = new PVector(0, 0);
  }

  void update()
  {
    background(0);
    shape(ball, ballpos.x, ballpos.y);
    applyGravity();
    applyDrag();
    ballmove();
    mouseSpeed();
    isTouchingVoid();
  }

  void ballmove()
  {
    if (isDragging == true && ballWasTouched == true && gamereset == false)
    {
      ballvel = new PVector(-prevMouseX+mouseX, -prevMouseY+mouseY);
      ballvel.normalize();
      ballvel.mult(speedmouse);
      ballpos.x = offset.x+mouseX;
      ballpos.y = offset.y+mouseY;
      prevMouseX = mouseX;
      prevMouseY = mouseY;
    }
    if (isDragging == false && ballWasTouched == true && gamereset == false)
    {
      ballpos.add(ballvel);
    }
  }

  void applyGravity() {
    ballvel.add(gravityForce);
  }

  void applyDrag() {
    PVector dragForce = ballvel.copy();
    dragForce.normalize();
    dragForce.mult(-drag);
    ballvel.add(dragForce);
  }

  void mousePressed() {
    float d = dist(mouseX, mouseY, ballpos.x, ballpos.y);
    if (d <= balldiameter / 2 && gamereset == false) {
      isDragging = true;
      ballWasTouched = true;
      offset = new PVector(ballpos.x-mouseX, ballpos.y-mouseY);
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
      ballvel.x *= energyconserved;
      ballpos.x = width-balldiameter/2;
    }
    if (ballpos.x <= 0)
    {
      ballvel.x = -ballvel.x;
      ballvel.x *= energyconserved;
      ballpos.x = balldiameter/2;
    }
    if (ballpos.y >= height - balldiameter / 2) {
      ballvel.y = -ballvel.y;
      ballvel.y *= energyconserved;
      ballpos.y = height - balldiameter / 2;
    }
    if (ballpos.y <= 0) {
      ballvel.y = -ballvel.y;
      ballvel.y *= energyconserved;
      ballpos.y = balldiameter/2;
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
}
