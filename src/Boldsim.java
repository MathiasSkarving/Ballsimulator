import java.util.*;
import processing.core.*;

public class Boldsim extends PApplet {

  ArrayList<Ball> balls = new ArrayList<Ball>();
  Ball bold;
  PImage sky;
  float prevX, prevY;
  public boolean gamereset = true;
  PShape ballshape;

  public static void main(String[] args) {
    PApplet.main("Boldsim");
  }

  public void settings() {
    size(1600, 800);
  }

  public void setup() {
    frameRate(60);
    size(1600, 800);
    sky = loadImage("sky.png");
    sky.resize(1600, 800);
    noStroke();
    ballshape = createShape(ELLIPSE, 0, 0, 50, 50);
  }

  public void draw() {
    background(sky);
    startup();
    reset();

    if (keyPressed) {
      if (key == 'k' || key == 'K') {
        balls.add(new Ball());
      }
    }

    for (Ball ball : balls) {
      shape(ballshape, ball.ballpos.x, ball.ballpos.y, ball.balldiameter, ball.balldiameter);
      ball.update();
    }
  }

  public void mousePressed() {
    for (Ball ball : balls) {
      ball.MousePressed();
    }
  }

  public void mouseReleased() {
    for (Ball ball : balls) {
      ball.MouseReleased();
    }
  }

  void startup() {
    if (gamereset == true) {
      textSize(100);
      textAlign(CENTER);
      text("Tryk space for at starte", width / 2, height / 4);
      if (key == 32) {
        gamereset = false;
      }
    }
  }

  void reset() {
    if (keyPressed) {
      if (key == 'r' || key == 'R') {
        for (Ball ball : balls) {
          ball.ballpos.set(width / 2, height / 2);
          ball.ballvel.set(0, 0);
          ball.ballWasTouched = false;
          ball.isDragging = false;
          ball.gamereset = true;
        }
        gamereset = true;
      }
    }
  }
}