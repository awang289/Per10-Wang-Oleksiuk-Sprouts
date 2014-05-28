ArrayList<Node> pts = new ArrayList<Node>();
void setup() {
  size(400,400); 
  background(255);
}
void draw() {
  background(255);
  for (Node h : pts) {
    stroke(0);
    fill(255);
    rect(h.x - 3, h.y - 3, 6, 6);
    point(h.x, h.y);

  }
}
void mousePressed() {
   pts.add(new Node(mouseX,mouseY));
}

