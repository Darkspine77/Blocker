ArrayList<Unit> Enemies = new ArrayList<Unit>();
ArrayList<Unit> Units = new ArrayList<Unit>();
ArrayList<Tile> Tiles = new ArrayList<Tile>();
int spawnDelay;
int gameStatus = 0;
float tilesCovered = 0;
int completion = 0;
void setup() {
  size(400, 400);
  noStroke();
  generateTiles();
}

void generateTiles(){
  for (int i = 1; i<21; i++) {
    for (int ix = 1; ix<21; ix++) {
      Tile z = new Tile(i, ix, 0);
    }
  }
}

void updateGame(int status) {
  gameStatus = status;
  if (gameStatus == 2) {
    Units.clear();
    Enemies.clear();
    Tiles.clear();
    Unit unit = new Unit(width/2, height/2, 10, 0, 0, true);
    generateTiles();
    tilesCovered = 0;
    completion = 0;
  }
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
        y = height - 20;
        yvel = -3;
      } else {
        y = 20;
        yvel = 3;
      }
    } else {
      y = height - (height/20)*int(random(1, 20));
      if (int(random(1, 3)) == 1) {
        x = width - 20;
        xvel = -3;
      } else {
        x = 20;
        xvel = 3;
      }
    }
    Unit unit = new Unit(x+10, y+10, 10, xvel, yvel, false);
    spawnDelay = millis() + 800;
  }
}

void draw() { 
  background(255);
  if (gameStatus == 0) { 
    fill(0,255,0);
    textAlign(CENTER);
    text("Press Any Key To Begin",width/2,height/2); 
    if (keyPressed == true) {
      updateGame(2); 
    }
  }
  if (gameStatus == 3) { 
    fill(0,255,0);
    textAlign(CENTER);
    text("Press Any Key To Begin",width/2,height/2);
    fill(255,0,0);
    text("You Lost",width/2,height/4); 
    if (keyPressed == true) {
      updateGame(2); 
    }
  }
  if (gameStatus == 2) {
    blockSpawner();
    for (int i = 0; i<Tiles.size(); i++) {
      Tiles.get(i).render();
    }
    for (int i = 0; i<Units.size(); i++) {
      Units.get(i).run();
    }
    fill(255);
    completion = round((tilesCovered/Tiles.size())*100);
    text(completion + "% Complete",width/2,height/4); 
  }
}