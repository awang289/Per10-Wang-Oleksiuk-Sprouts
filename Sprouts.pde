ArrayList<Node> pts = new ArrayList<Node>();
ArrayList<Lim> cons = new ArrayList<Lim>();
ArrayList<Line> lines = new ArrayList<Line>();
boolean isDrawing= false;
boolean playTurn = false;

void setup() {
  size(400, 400);
  background(255);
  pts.add(new Node(300, 350));
  pts.add(new Node(300, 300));
  lines.add(new Line(new Point(200, 100)));
  lines.get(0).addify(new Point(200, 300));
  lines.add(new Line(new Point(100, 200)));
  lines.get(1).addify(new Point(300, 200));
  findIntersections(lines.get(0));
  //  findIntersections(lines.get(1));
}

void draw() {
  background(255);
  for (Node h : pts) {
    println(h.cons);
    stroke(0);
    if (h.cons >= 3 ) {
      fill(#000000);
    } else {
      fill(#83F52C);
    }
    ellipse(h.x, h.y, 10, 10);
    stroke(#83F52C);
    point(h.x, h.y);
  }
  for (Line l : lines) {
    noFill();
    smooth();
    stroke(0);
    l.display();
  }
  //if universal boolean val is true, generate a single curve from the working spline to the point the mouse is at, regenerated each frame
}

int whichNode() {
  for (int i = 0; i < pts.size (); i++) {
    float disX = pts.get(i).x - mouseX;
    float disY = pts.get(i).y - mouseY;
    if (sqrt(sq(disX) + sq(disY)) < 5 ) {
      return i;
    }
  }
  return -1;
}


void mousePressed() {
  color c = get(mouseX, mouseY);
  //add check to determine turns && intersections
  if (isDrawing == false && c == #83F52C) {
    isDrawing = true;
    int u = whichNode();
    Line l = new Line(new Point(pts.get(u).x, pts.get(u).y));
    lines.add(l);
    pts.get(whichNode()).cons++;
  } else if (isDrawing == true) {
    if (c == #83F52C) {
      pts.get(whichNode()).cons++;
      int o = whichNode();
      lines.get(lines.size()-1).addify(new Point(pts.get(o).x, pts.get(o).y));
      //right now this turns off line drawing if the color of the pixel you've clicked is black, but
      //later on we should make this green, I.E. the color of all valid nodes
      isDrawing = false;
    } else {
      lines.get(lines.size()-1).addify(new Point(mouseX, mouseY));
    }
  }
}

boolean findIntersections(Line a) {

  int x1 = a.points.get(0).x;
  int y1 = a.points.get(0).y;

  return findIntersections2(x1, y1, x1, y1);
  //just makes a call to the next function with the starting and previous points as the coordinates for the start of the Line
}

boolean findIntersections2(int x1, int y1, int prevX, int prevY) {
  //y is the counter for number of surrounding pixels
  int y = 0;
  int nextX = 0;
  int nextY = 0;
  int tempX = 0;
  int tempY = 0;
  //tempX and tempY are the coordinates for the next point examined/moved to
  for (int i = 0; i < 8; i++ ) {
    if (i == 0) {
      tempX = x1+1; 
      tempY = y1+1;
    } else if (i == 1) {
      tempX = x1; 
      tempY = y1+1;
    } else if (i == 2) {
      tempX = x1; 
      tempY = y1-1;
    } else if (i == 3) {
      tempX = x1+1; 
      tempY = y1;
    } else if (i == 4) {
      tempX = x1-1; 
      tempY = y1;
    } else if (i == 5) {
      tempX = x1+1; 
      tempY = y1-1;
    } else if (i == 6) {
      tempX = x1-1; 
      tempY = y1-1;
    } else {
      tempX = x1-1; 
      tempY = y1+1;
    }
    //checks each pixel around the starting point
    color c = get(tempX, tempY);
    if (c == #000000 && !(tempX == prevX && tempY == prevY)) {
      y++;
      nextX = tempX;
      nextY = tempY;
      //if the checked pixel is black and not the previous point, add to y
    }
  } 
  pts.add(new Node(x1, y1));// displays the x1,y1 locations every time, good for checking results
  if (y == 0 && !(x1 == prevX && y1 == prevY)) {
    return false;
    //if no pixels around starting point, and starting point isn't the origin of the line, return false to indicate no intersections
  } else if (y > 1) {
    //if there are more than 1 pixels around the starting point, return false to indicate there is an intersection
    return true;
  } else {
    //run function again, moving the starting point to the tempX and tempY values, and the previous point to the current starting point values
    return findIntersections2(tempX, tempY, x1, y1);
  }
}










