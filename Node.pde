class Node extends Point{
  int cons;
  Node() {
    int x = 0;
    int y = 0;
    int cons = 0;
  }
 
  Node(int x, int y) {
    this();
    this.x = x;
    this.y = y;
    this.cons = 0;
  }
  
  void set(int x1, int y1){
    x = x1;
    y = y1;
  }
  void display() {
    stroke(0);
    color c = color(0,255,0);
    if (cons >= 3){
      c = color(255,0,0);
    }
    fill(c);
    ellipse(x, y, 10, 10);
    stroke(c);
    point(x, y);
  }
}
