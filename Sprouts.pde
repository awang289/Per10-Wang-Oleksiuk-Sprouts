import java.awt.event.*;
ArrayList<Node> pts = new ArrayList<Node>();
ArrayList<Line> lines = new ArrayList<Line>();
Line current = null;
int start = 0;
boolean needsNew = false;
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

void draw() {
  background(255);
  for (Node h : pts) {
    h.display();
  }
  for (Line l : lines) {
    l.display();

  }
  if (current != null) {
      current.display( color(0,0,255));
  }
  else if (needsNew) {
    lines.get(lines.size() - 1).display( color (255,0,255));
  }
  //if universal boolean val is true, generate a single curve from the working spline to the point the mouse is at, regenerated each frame
}



void mousePressed() {
 if (needsNew) {
    loadPixels();
    color pix;
    for (int x = 0; x < 11; x++) {
      for (int y = 0; y < 11; y ++) {
        pix = pixels[(mouseY - 5 + y)*width + mouseX - 5 + x];
        if (red(pix) > 150 && red(pix) < 230 && blue(pix) < 230 && blue(pix) > 150) {
          pts.add(new Node (mouseX - 5 + x, mouseY - 5 + y));
          pts.get(pts.size() - 1).cons += 2;
          needsNew = false;
          return;
        }
      }
    }
 
   
    // breadth first search 10 pixel radius
    //red and blue values must be under 230, over 150 
    //take the lowest value and place node at that pixel
    // if pixel found, put node at closest purple pixel
    //needsNew = false;
  }
  else if (current == null) {
    turn++;
    startLine(mouseX, mouseY);
  } else {
    contLine(mouseX, mouseY);
  }
}
void startLine(int x, int y) {
  for (Node p : pts) {
    if (dist(x, y, p.x, p.y) <= 10 && p.cons < 3) {
      p.cons ++;
      
      Line g = new Line(p);
      lines.add(g);
      current = g;
    }
  }
}
void contLine(int x, int y) {
  boolean h = false;
  for (Node p : pts) {
    if (dist(x, y, p.x, p.y) <= 10 && p.cons < 3) {
      p.cons++;
      current.points.add(p);
      h = true;
      current = null;
      needsNew = true;
    }
  }
  if (!h) {
    current.points.add(new Point(x, y));
  }
  //The check for intersections would go here
}
void endLine(int x, int y) {
} // This is eventually supposed to make the new Node but I can't figure that out at the moment 
/*
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
*/
void setStartNumber(int x) { start = x; }
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
