class Node extends Point{
  Node() {
    int x = 0;
    int y = 0;
  }
  Node(int x, int y) {
    this();
    this.x = x;
    this.y = y;
  }
  void display() {
    stroke(0);
    fill(255);
    ellipse(x, y, 6, 6);
    point(x, y);
  }
}
