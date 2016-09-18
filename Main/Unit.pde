class Unit { 
  int xcoord, ycoord, x, y, xvel, yvel, size;
  boolean player;
  int [] rgb = new int[3]; 
  Unit(int x1, int y1, int size1, int xvel1, int yvel1, boolean player1) {
    xcoord = 10;
    ycoord = 10;
    x = x1;
    y = y1;
    xvel = xvel1;
    yvel = yvel1;
    size = size1;
    player = player1;
    rgb[0] = 0;
    rgb[1] = 255;
    rgb[2] = 0;
    if (!player) {
      rgb[0] = 255;
      rgb[1] = 0;
      rgb[2] = 0;
      Enemies.add(this);
    }
    Units.add(this);
  } 

  void run() {
    render(); 
    move();
    collide();
    locate();
  }

  void locate() {
    for (int i = 0; i<width; i++) {
      if (x > i*20 && x < (i+1)*20) {
        xcoord = i + 1;
      }
    }
    for (int i = 0; i<height; i++) {
      if (y > i*20 && y < (i+1)*20) {
        ycoord = i + 1;
      }
    }
  }
  void render() { 
    rectMode(CENTER);
    fill(rgb[0], rgb[1], rgb[2]); 
    rect(x, y, size*2, size*2);
  }

  void collide() {
    boolean flag1 = x + size >= width || x - size <= 0;
    boolean flag2 = y + size >= height || y - size <= 0;
    if (flag1 || flag2) { 
      if (!player) {
        Enemies.remove(this);
        Units.remove(this);
      } else {
        if (x + size >= width) {
          xvel = 0;
          x = width - 10;
        }
        if (x - size <= 0) {
          xvel = 0;
          x = 10;
        }
        if (y + size >= height) {
          yvel = 0;
          y = height - 10;
        }
        if (y - size <= 0) {
          yvel = 0;
          y = 10;
        }
      }
    }
    if (player) {  
      for (int i = 0; i<Enemies.size (); i++) {
        if (inRange(Enemies.get(i).x, Enemies.get(i).y, x, y, size, size)) {
          println("Game over");
        }
      }
    }
    //} else { 
    //  for (int i = 0; i<Enemies.size (); i++) {
    //    if (Enemies.get(i) != this) {
    //      if (inRange(Enemies.get(i).x, Enemies.get(i).y, x, y, size, size)) {
    //        Unit collided = Enemies.get(i);
    //        boolean flagL = x + size > collided.x - collided.size;
    //        boolean flagR = x - size > collided.x + collided.size;
    //        boolean flagD = y + size > collided.x - collided.size;
    //        boolean flagU = y - size > collided.x + collided.size;
    //        if (flagR) {
    //          xvel = 3;
    //          collided.xvel = -3;
    //        }
    //        if (flagL) {
    //          xvel = -3;
    //          collided.xvel = 3;
    //        }
    //        if (flagD) {
    //          yvel = -3;
    //          collided.yvel = 3;
    //        }
    //        if (flagU) {
    //          yvel = 3;
    //          collided.yvel = -3;
    //        }
    //      }
    //    }
    //  }
    //}
  }

  void move() {
    if (!player) {
      x += xvel;
      y += yvel;
    } else {
      if (keyPressed) { 
        if (key == 'a') { 
          xvel = -3;
          yvel = 0;
        }
        if (key =='d') {
          xvel = 3;
          yvel = 0;
        }
        if (key == 'w') {
          xvel = 0;
          yvel = -3;
        }
        if (key == 's') {
          xvel = 0;
          yvel = 3;
        }
      }
      x += xvel;
      y += yvel;
    }
  }
}