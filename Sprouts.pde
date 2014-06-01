ArrayList<Node> pts = new ArrayList<Node>();
ArrayList<Lim> cons = new ArrayList<Lim>();
ArrayList<Line> lines = new ArrayList<Line>();
boolean isDrawing= false;

void setup() {
  size(400,400);
  background(255);
 lines.add(new Line(new Point(200,100)));
  lines.get(0).addify(new Point(200,300));
 lines.add(new Line(new Point(100,200)));
  lines.get(1).addify(new Point(300,200));
  findIntersections(lines.get(0));
//  findIntersections(lines.get(1));
}

void draw() {
  background(255);
  for (Node h : pts) {
    stroke(0);
    fill(255);
    ellipse(h.x, h.y, 6, 6);
    point(h.x, h.y);
  }
  for (Line l : lines){
     noFill();
     smooth();
     stroke(0);
     l.display();
  }
  //if universal boolean val is true, generate a single curve from the working spline to the point the mouse is at, regenerated each frame
}

void mousePressed() {
   pts.add(new Node(mouseX,mouseY));
}

void drawLine(){
  ArrayList<Point> intersections = new ArrayList<Point>();
  //with each new node drawn, check the section of the spline created by that against all other lines in the ArrayList of lines. If nothing in
  // ArrayList intersections at the end, point is valid, move onto next one, if not, do nothing.

}

boolean findIntersections(Line a){
  
  int x1 = a.points.get(0).x;
  int y1 = a.points.get(0).y;

  return findIntersections2(x1,y1,x1,y1);
  //just makes a call to the next function with the starting and previous points as the coordinates for the start of the Line
}

boolean findIntersections2(int x1, int y1, int prevX, int prevY){
   //y is the counter for number of surrounding pixels
  int y = 0;
  int tempX = 0,tempY = 0;
  //tempX and tempY are the coordinates for the next point examined/moved to
  for (int i = 0 ;i < 8 ;i++ ){
    if (i == 0){tempX = x1+1; tempY = y1+1;}
    else if (i == 1){tempX = x1; tempY = y1+1;}
    else if (i == 2){tempX = x1; tempY = y1-1;}
    else if (i == 3){tempX = x1+1; tempY = y1;}
    else if (i == 4){tempX = x1-1; tempY = y1;}
    else if (i == 5){tempX = x1+1; tempY = y1-1;}
    else if (i == 6){tempX = x1-1; tempY = y1-1;}
    else {tempX = x1-1; tempY = y1+1;}
    //checks each pixel around the starting point
    if (get(tempX,tempY) == 0 && !(tempX == prevX && tempY == prevY)){
      y++;
      //if the checked pixel is black and not the previous point, add to y
    }
  } 
  pts.add(new Node(x1,y1));// displays the x1,y1 locations every time, good for checking results
  if (y == 0 && !(x1 == prevX && y1 == prevY)){
    return false;
    //if no pixels around starting point, and starting point isn't the origin of the line, return false to indicate no intersections
  }
  else if (y > 1){
    //if there are more than 1 pixels around the starting point, return false to indicate there is an intersection
    return true;
  }
  else {
    //run function again, moving the starting point to the tempX and tempY values, and the previous point to the current starting point values
    return findIntersections2(tempX,tempY,x1,y1);
  }
}

  









