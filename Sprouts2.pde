ArrayList<Node> pts = new ArrayList<Node>();
ArrayList<Lim> connections = new ArrayList<Lim>();

void setup() {
  size(400,400);
  background(255);
}

void draw() {
  background(255);
  for (Node h : pts) {
    stroke(0);
    fill(255);
    smooth();
    ellipse(h.x, h.y, 6, 6);
    point(h.x, h.y);
    spline(h);
  }
}

void spline(Node h){
  
  float nextx,nexty,lastx,lasty,point1x,point1y,point2x,point2y;
  if (h.con1.size() == 0 && connections.get(connections.indexOf(h)).jim.get(0)!=null){
  curve( h.x, h.y, h.x, h.y, connections.get(connections.indexOf(h)).jim.get(0).x, 
  connections.get(connections.indexOf(h)).jim.get(0).y, connections.get(connections.indexOf(h)).jim.get(0).x, 
  connections.get(connections.indexOf(h)).jim.get(0).y);
  }
  for (int i = 0; i < h.con1.size(); i++){
    if (i == 0){
      lastx = h.x; 
      lasty = h.y; 
      point1x = h.x;
      point1y = h.y;
    }
    else if (i == 1){
      lastx = h.x; 
      lasty = h.y; 
      point1x = h.con1.get(i-1).x;
      point1y = h.con1.get(i-1).y;
    }
    else{
      lastx = h.con1.get(i-2).x;
      lasty = h.con1.get(i-2).y;
      point1x = h.con1.get(i-1).x;
      point1y = h.con1.get(i-1).y;
    }
    if (i == h.con1.size()-1){
      nextx = connections.get(connections.indexOf(h)).jim.get(0).x;
      nexty = connections.get(connections.indexOf(h)).jim.get(0).y;
      point2x = h.con1.get(i).x;
      point2y = h.con1.get(i).y;    
    }
    else {
      nextx = h.con1.get(i+1).x;
      nexty = h.con1.get(i+1).y;
      point2x = h.con1.get(i).x;
      point2y = h.con1.get(i).y;
    }
    curve( lastx, lasty, point1x, point1y, point2x, point2y, nextx, nexty);
  }
  
  for (int i = 0; i < h.con2.size() ; i++){

  }
  
  for (int i = 0; i < h.con3.size(); i++){

  }
}

void mousePressed() {
   pts.add(new Node(mouseX,mouseY));
}


class Lim{
  ArrayList<Node> jim = new ArrayList<Node>();
  Node node;
  Lim(Node a){
    node = new Node(a.x,a.y);
  }
  void add(Node a){
    jim.add(new Node(a.x,a.y));
  }
}

class Node{
  
  float x, y;
  
  ArrayList<Point> con1;
  ArrayList<Point> con2;
  ArrayList<Point> con3;

  Node() {
    float x = 0;
    float y = 0;
  }
  Node(float x, float y) {
    this();
    this.x = x;
    this.y = y;
  }
}

class Point{
  float x,y;
  Point(float a, float b){
    x = a;
    y = b;
  }
}
