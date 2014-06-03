ArrayList<Node> pts = new ArrayList<Node>();
ArrayList<Lim> cons = new ArrayList<Lim>();
ArrayList<Line> lines = new ArrayList<Line>();
Line current = null;
int turn = 0;
/*void start() {
 new NewGameFrame();
 }
 */
void setup() {
  size(400, 400);
  background(255);
  pts.add(new Node(100,100));
  pts.add(new Node(200, 100));
}

void draw() {
  background(255);
  for (Node h : pts) {
    h.display();
  }
  for (Line l : lines) {
    l.display();
  }
  //if universal boolean val is true, generate a single curve from the working spline to the point the mouse is at, regenerated each frame
}

void mousePressed() {
  if (current == null) {
    turn++;
    startLine(mouseX, mouseY);
  }
  else {
    contLine(mouseX, mouseY);
  }
}
void startLine(int x, int y) {
  for (Node p : pts) {
    if (dist(x, y, p.x, p.y) <= 3) {
      Line g = new Line(p);
      lines.add(g);
      current = g;
    }
  }
}
void contLine(int x, int y) {
  boolean h = false;
  for (Node p : pts) {
    if (dist(x, y, p.x, p.y) <= 3) {
      current.points.add(p);
      h = true;
      current = null;
    }
  }
  if (!h) {
    current.points.add(new Point(x,y));
  }
  //The check for intersections would go here
}
void endLine(int x, int y) {} // This is eventually supposed to make the new Node but I can't figure that out at the moment

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





