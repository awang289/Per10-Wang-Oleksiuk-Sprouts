class Line {

  ArrayList<Point> points= new ArrayList<Point>();

  public Line(Point p) {
    addify(p);
  }
  void addify(Point p) {
    points.add(p);
  }

  void removeify(Point p) {
    points.remove(p);
  }

  void display() {
    noFill();
    smooth();
    stroke(0);
    beginShape();
    curveVertex(points.get(0).x, points.get(0).y);
    for (Point p : points) {
      curveVertex(p.x, p.y);
    }
    curveVertex(points.get(points.size()-1).x, points.get(points.size()-1).y);
    endShape();
  }
  void display(color c) {
    noFill();
    smooth();
    stroke(c);
    beginShape();
    curveVertex(points.get(0).x, points.get(0).y);
    for (Point p : points) {
      curveVertex(p.x, p.y);
    }
    curveVertex(points.get(points.size()-1).x, points.get(points.size()-1).y);
    endShape();
  }
  
}
