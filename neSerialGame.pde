import processing.serial.*;

Serial sc;
int[] data = new int[4];
float x, y;
int cols, rows;
int[][] course;
int resolution;

void setup() {
  size(500, 500);
  resolution = 10;
  buildCourse();
  background(0);
  x = width/2;
  y = height/2;
  printArray(Serial.list());
  sc = new Serial(this, Serial.list()[1], 9600);
}

void draw() {
  background(0);
  getData();
  moveBall();
  //calculateCollision();
  displayCourse();
  displayBall();
}

void getData() {
  if (sc.available() > 5) {
    startCheck();
    data[0] = (sc.read());
    data[1] = (sc.read());
    data[2] = (sc.read());
    data[3] = (sc.read());

    printArray(data);
    println("Data read");
  }
  return;
}

void startCheck() {
  while (!(sc.read() == 255 && sc.read() == 255)) {
  }
  return;
}

void buildCourse() {
  if (width % resolution != 0 || height % resolution != 0) {
    throw new RuntimeException("Canvas size not supported by the course resolution");
  }
  cols = width/resolution;
  rows = height/resolution;
  course = new int[rows][cols];
  for (int r=0; r < rows; r++) {
    for (int c=0; c < cols; c++) {
      if (random(1) > 0.75) {
        course[r][c] = 1;
      } else {
        course[r][c] = 0;
      }
    }
  }//End of for-for-if loop
}

void displayCourse() {
  pushStyle();
  noStroke();
  for (int r=0; r < rows; r++) {
    for (int c=0; c < cols; c++) {
      if (course[r][c] > 0) {
        fill(0, 0, 255);
      } else {
        fill(0);
      }
      rect(c*resolution, r*resolution, (c+1)*resolution, (r+1)*resolution);
    }
  }//End of for-for-if loop
  popStyle();
}

void displayBall() {
  pushStyle();
  noStroke();
  fill(255);
  ellipse(x, y, 20, 20);
  popStyle();
}  

void moveBall() {
  boolean left = parseButtons(data[0], 2);
  boolean right = parseButtons(data[0], 1);
  boolean up = parseButtons(data[2], 8);
  boolean down = parseButtons(data[2], 4);
  float xspeed = map(data[1], -1, 128, 0, 5);
  float yspeed = map(data[3], -1, 128, 0, 5);

  if (left) {
    x -= (xspeed - 1);
  }
  if (right) {
    x += xspeed;
  }
  if (up) {
    y -= (yspeed);
  }
  if (down) {
    y += yspeed;
  }
  return;
}

boolean parseButtons(int btns, int mask) {
  boolean result = false;
  if ((btns & mask) > 0) {
    result = true;
  }
  return result;
}