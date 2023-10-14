Ball bold;
PImage sky;


void setup() {
  frameRate(60);
  size(1600, 800);
  sky = loadImage("sky.png");
  sky.resize(1600, 800);
  bold = new Ball();
}

void draw() {
  background(sky);
  bold.update();
}

void mouseReleased() {
  bold.MouseReleased();
}


void mousePressed() {
  bold.MousePressed();
}
