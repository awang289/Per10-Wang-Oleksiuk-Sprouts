ArrayList<Node> pts = new ArrayList<Node>();
ArrayList<Lim> cons = new ArrayList<Lim>();
ArrayList<Line> lines = new ArrayList<Line>();\
boolean isDrawing= false;

void setup() {
  size(400,400);
  background(255);
 /* lines.add(new Line(new Point(365,100)));
  lines.get(0).addify(new Point(20,20));
  lines.get(0).addify(new Point(200,20));
  lines.get(0).addify(new Point(170,320));
  lines.get(0).addify(new Point(50,200));*/
}

void draw() {
  background(255);
  for (Node h : pts) {
    stroke(0);
    fill(255);
    smooth();
    ellipse(h.x, h.y, 6, 6);
    point(h.x, h.y);
  }
  for (Line l : lines){
     noFill();
     stroke(0);
     smooth();
     l.display();
  }
  //if universal boolean val is true, generate a single curve from the working spline to the point the mouse is at, regenerated each frame
}

void mousePressed() {
   pts.add(new Node(mouseX,mouseY));
}

void drawLine(){
  ArrayList<Point> intersections = new ArrayList<Point>;
  //with each new node drawn, check the section of the spline created by that against all other lines in the ArrayList of lines. If nothing in
  // ArrayList intersections at the end, point is valid, move onto next one, if not, do nothing.

}
