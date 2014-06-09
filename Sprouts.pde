import java.awt.event.*;
ArrayList<Node> pts = new ArrayList<Node>();
ArrayList<Line> lines = new ArrayList<Line>();
Line current = null;
int start = 0;
boolean needsNew = false;
boolean searching = false;
boolean playing = true;
int turn = 0;
void start() {
  new NewGameFrame();
}
void setup() {
  size(800, 600);
  background(255);
  for (int x = 0; x < start; x++) {
    pts.add(new Node(100* (x / 3) + 200, (x % 3) * 100 + 200));
  }
  // pts.add(new Node(100, 100));
  //pts.add(new Node(200, 100));
  boolean isDrawing= false;
  boolean playTurn = false;
}

void keyPressed() {
  if (key == 'b') {
    if (needsNew == false && current != null) {
      for (Node d : pts) {
        if (current.points.size() == 1 && 
          d.x== current.points.get(current.points.size()-1).x && 
          d.y == current.points.get(current.points.size()-1).y) {
          d.cons--;
        }
      }
      current.removeify(current.points.get(current.points.size()-1));
      if (current.points.size()==0) {
        current = null;
        lines.remove(lines.size()-1);
        turn--;
      }
    }
  }
  else if (key == 'n' && !playing) {
    reset();
  }
}

void draw() {
  background(255);
  for (Node h : pts) {
    h.display();
  }
  for (Line l : lines) {
    l.display();
  }
  if (current != null) {
    current.display( color(0, 0, 255));
  } else if (needsNew) {
    lines.get(lines.size() - 1).display( color (255, 0, 255));
  }
  //if universal boolean val is true, generate a single curve from the working spline to the point the mouse is at, regenerated each frame
  if (!playing) {
    stroke(0);
    fill(0);
    if (turn % 2 == 1) {
      background(255);
      text("Player 1 wins!", 350, 300);
      // Player 1 wins!
    } else {
      background(255);
      text("Player 2 wins!", 350, 300);
      //Player 2 wins!
    }
  }
}

void reset() {
  pts = new ArrayList<Node>();
  lines = new ArrayList<Line>();
  start = 0;
  playing = true;
  turn = 0;
  start();
}
boolean areNodes(int x, int y) {
  for (Node p : pts) {
    if (dist(x, y, p.x, p.y) <= 10) {
      return false;
    }
  }
  return true;
}


void mousePressed() {
  if (needsNew) {
    loadPixels();
    color pix;
    for (int x = 0; x < 11; x++) {
      for (int y = 0; y < 11; y ++) {
        pix = pixels[(mouseY - 5 + y)*width + mouseX - 5 + x];
        if (blue(pix)-green(pix)> 25 && areNodes(mouseX - 5 + x, mouseY - 5 + y)) {
          pts.add(new Node (mouseX - 5 + x, mouseY - 5 + y));
          pts.get(pts.size() - 1).cons += 2;
          needsNew = false;
          if (possibleMoves().size() < 1) {
            playing = false;
          }
          return;
        }
      }
    }


    // breadth first search 10 pixel radius
    //red and blue values must be under 230, over 150 
    //take the lowest value and place node at that pixel
    // if pixel found, put node at closest purple pixel
    //needsNew = false;
  } else if (current == null) {
    turn++;
    startLine(mouseX, mouseY);
  } else {
    contLine(mouseX, mouseY);
  }
}

void startLine(int x, int y) {
  for (Node p : pts) {
    if (dist(x, y, p.x, p.y) <= 10 && p.cons < 3) {
      p.cons++;
      Line g = new Line(p);
      lines.add(g);
      current = g;
    }
  }
}
//p != current.points.get(current.points.size()-1)
void contLine(int x, int y) {
  boolean h = false;
  boolean b = false;
  for (Node p : pts) {
    if (dist(x, y, p.x, p.y) <= 10 && p.cons < 3) {
      if (p != current.points.get(current.points.size()-1)) {
        p.cons++;
        current.points.add(p);
        if (anyIntersections(current)) {
          current.points.remove(current.points.size()-1);
          p.cons--;
        } else {
          h = true;
          current = null;
          needsNew = true;
        }
      } else {
        b = true;
      }
    }
  }
  if (!h && !b) {
    current.points.add(new Point(x, y));
    if (anyIntersections(current)) {
      current.points.remove(current.points.size()-1);
    }
  }
}

void setStartNumber(int x) { 
  start = x;
}

boolean anyIntersections(Line a) {
  Point p = a.points.get(a.points.size()-1);
  Node startNode = new Node(a.points.get(0).x, a.points.get(0).y);
  Node endNode = new Node(width + 50, height+50);
  for (Node h : pts) {
    if (h.x == p.x && h.y == p.y) {
      endNode.set(h.x, h.y);
    }
  }
  ArrayList<Integer> x = new ArrayList<Integer>();
  ArrayList<Integer> y = new ArrayList<Integer>();

  background(255);
  a.display();
  loadPixels();
  for (int i = 0; i < height; i++) {
    for (int j = 0; j<width; j++) {
      color c = pixels[(i*width)+j];
      if (c!=-1) {
        x.add(j);
        y.add(i);
      }
    }
  }
  background(255);
  for (int v = 0; v < lines.size ()-1; v++) {
    lines.get(v).display();
  }
  for (Node d : pts) {
    d.display();
  }
  loadPixels();
  color q;
  for ( int e = 0; e < x.size ()-1; e++) {
    int x1 = x.get(e);
    int y1 = y.get(e);
    q = pixels[(y1*width)+x1];
    if ((q!=-1) && 
      !((dist(x1, y1, startNode.x+0.0, startNode.y+0.0) <= 10) || startNode == endNode) &&
      !(dist(x1, y1, endNode.x+0.0, endNode.y+0.0) <= 10)
      ) {
      return true;
    }
  }
  if (a.points.size()>2) {
    background(255);
    curve(a.points.get(a.points.size()-3).x, 
    a.points.get(a.points.size()-3).y, 
    a.points.get(a.points.size()-2).x, 
    a.points.get(a.points.size()-2).y, 
    a.points.get(a.points.size()-1).x, 
    a.points.get(a.points.size()-1).y, 
    a.points.get(a.points.size()-1).x, 
    a.points.get(a.points.size()-1).y);
    loadPixels();
    ArrayList<Integer> x2= new ArrayList<Integer>();
    ArrayList<Integer> y2= new ArrayList<Integer>();
    for (int i = 0; i < height; i++) {
      for (int j = 0; j<width; j++) {
        color c = pixels[(i*width)+j];
        if (c!=-1) {
          x2.add(j);
          y2.add(i);
        }
      }
    }
    background(255);
    a.displayIntersection();
    loadPixels();
    for (int u = 0; u<x2.size ()-1; u++) {
      int x3 = x2.get(u);
      int y3 = y2.get(u);
      color w = pixels[(y3*width)+x3];
      if ((w!=-1) && 
        !(dist(x3, y3, startNode.x+0.0, startNode.y+0.0) <= 10) &&
        !(dist(x3, y3, endNode.x+0.0, endNode.y+0.0) <= 10)) {
        return true;
      }
    }
  }

  return false;
}
ArrayList possibleMoves() {
  ArrayList<Node> n = new ArrayList<Node>();
  ArrayList moves = new ArrayList();
  for (Node g : pts) {
    if (g.cons < 3) {
      n.add(g);
    }
    if (g.cons < 2) {
      Line gg = new Line(g);
      gg.points.add(g);
      moves.add(gg);
      return moves;
    }
  }
  for (int a = 0; a < n.size (); a++) {
    for (int b = a; b < n.size (); b++) {
      if (searchMove(n.get(a), n.get(b)) != null)
        moves.add(searchMove(n.get(a), n.get(b)));
      if (moves.size() > 0)
        return moves;
    }
  }
  return moves;
}
int slope (Point a, Point b) {
  int cd;
  if (b.x - a.x == 0) {
    return 100;
  } else {
    cd = (b.y - a.y) / (b.x - a.x);
    return cd;
  }
}

Line searchMove(Point start, Point end) {
  if (start == end && ((Node) start).cons > 1) {
    return null;
  }
  Line a = new Line(start);
  float s = slope(start, end);
  s = atan(s);
  searching = true;
  searchMove(a, end, s);
  if (a.points.size() > 1) {
    return a;
  } else {
    return null;
  }
}
void searchMove(Line a, Point end, float angle) {
  if (searching) {
    boolean added = false;
    a.points.add(end);
    if (! anyIntersections(a)) {
      searching = false;
    } else {
      a.points.remove(end);
      Point last = a.points.get(a.points.size() - 1);
      for (int x = 102; x > 0; x-= 20) {
        if ( (x * cos(angle)) < 0 || (x * cos(angle)) > 800 || (x * sin(angle)) < 0 || (x * sin(angle)) > 600) {
          continue;
        }
        a.points.add(new Point((int) (x * cos(angle)), (int) (x * sin(angle))));
        if (! anyIntersections(a)) {
          added = true;
          break;
        } else {
          a.points.remove(a.points.size() - 1);
        }
      }
      if (added) {
        float a2 = atan( slope( a.points.get(a.points.size() - 1), end));
        searchMove(a, end, a2);
        searchMove(a, end, a2 + PI/4);
        searchMove(a, end, a2 - PI / 4);        
        searchMove(a, end, a2 + PI/2);
        searchMove(a, end, a2 - PI / 2);
        searchMove(a, end, a2 + 3 * PI/4);
        searchMove(a, end, a2 - 3 * PI / 4);
        searchMove(a, end, a2 + PI);
        if (searching) {
          a.points.remove(a.points.size() - 1);
        }
      }
    }
  }
}

