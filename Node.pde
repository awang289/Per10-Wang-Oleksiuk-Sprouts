class Node extends Point{
  int x, y;
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
  void display() {
    stroke(0);
    fill(255);
    ellipse(x, y, 6, 6);
    point(x, y);
  }
}
