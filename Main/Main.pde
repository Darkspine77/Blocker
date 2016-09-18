ArrayList<Unit> Enemies = new ArrayList<Unit>();
ArrayList<Unit> Units = new ArrayList<Unit>();
int spawnDelay;
void setup() {
  size(400, 400);
  noStroke();
  Unit unit = new Unit(width/2, height/2, 10, 0, 0, true);
}

boolean inRange(float x, float y, float x2, float y2, float xz, float yz) {
  //Tests to see if a certain x and y coordinate is within another x and y coordiante range
  if (x <= x2+xz && y <= y2+yz && x >= x2-xz && y >= y2-yz) {
    return true;
  } else {
    return false;
  }
}

void blockSpawner() {
  if (millis() > spawnDelay) {
    int x = 0;
    int y = 0;
    int xvel = 0; 
    int yvel = 0;
    if (int(random(1, 3)) == 1) {
      x = width - (width/20)*int(random(1, 20));
      if (int(random(1, 3)) == 1) {
        y = height - 10;
        yvel = -3;
      } else {
        y = 10;
        yvel = 3;
      }
    } else {
      y = height - (height/20)*int(random(1, 20));
      if (int(random(1, 3)) == 1) {
        x = width -10;
        xvel = -3;
      } else {
        x = 10;
        xvel = 3;
      }
    }
    Unit unit = new Unit(x, y, 10, xvel, yvel, false);
    spawnDelay = millis() + 250;
  }
}

void draw() { 
  background(255);
  blockSpawner();
  for (int i = 0; i<Units.size(); i++) {
    Units.get(i).run();
  }
}