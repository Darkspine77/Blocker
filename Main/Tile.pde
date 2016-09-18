class Tile {
int x,y,type;
int [] rgb = new int[3]; 
Tile(int x1,int y1,int type1){
  x = x1;
  y = y1;
  type = type1;
  Tiles.add(this);
}
  void render(){
  fill(rgb[0], rgb[1], rgb[2]); 
  rectMode(CENTER);
  rect((x-1)*20 + 10,(y-1)*20 + 10,20,20);
  }
}