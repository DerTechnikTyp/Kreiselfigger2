int kreiselCount = 10;
float rotationStepSize = 0.01;
int outerCircleSize = 600;

float[] circleRotations;

void setup() {
  frameRate(120);
  size(800, 800, P2D);
  smooth(10);
  background(22, 22, 24);

  setupVariables();

  setupStroke();
}

void setupVariables() {
  println("Setup variables...");
  circleRotations = new float[kreiselCount];

  setZero();
}

void setZero() {
  println("Zeroing arrays...");
  // reset outer circles
  for (int i = 0; i < circleRotations.length; i++) {
    circleRotations[i] = 0.0f;
  }
}

void setupStroke() {
  println("Setup stroke for inner circles...");
  stroke(255, 255, 255); // white
  strokeWeight(2);
  noFill();
  //fill(255);
}

void draw() {
  println("Drawing...");
  background(22, 22, 24);
  drawCircles();
  makeProgress();
  saveFrame("f###.gif");
}

void drawCircles() {
  println("Drawing circles...");
  pushMatrix();
  drawOuterCircle();
  drawInnerCirclesRecursive(1);
  popMatrix();
}

void drawOuterCircle() {
  translate(outerCircleSize / 2 + 100, outerCircleSize / 2 + 100);
  ellipse(0, 0, outerCircleSize, outerCircleSize);
}

void drawInnerCirclesRecursive(int i) {
  println("Drawing inner circles...");
  pushMatrix();
  float diameter = outerCircleSize / pow(2, i);
  float radius = diameter / 2;
  float x = radius * sin(circleRotations[i]);
  float y = radius * cos(circleRotations[i]);
  translate(x, y);
  ellipse(0, 0, diameter, diameter);
  if (i < kreiselCount - 1){
    drawInnerCirclesRecursive(i + 1);
  }
  popMatrix();
}

void makeProgress() {
  print("Making progress...");
  // moving outer circles progress
  for (int i = 0; i < circleRotations.length; i++) {
    circleRotations[i] = (circleRotations[i] + ((float)(i * rotationStepSize))) % 360;
  }
}
