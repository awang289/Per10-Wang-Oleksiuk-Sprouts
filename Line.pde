class Line{
  
  ArrayList<Point> points= new ArrayList<Point>();
  
  public Line(Point p){
    addify(p);
  }
  
  void addify(Point p){
    points.add(p);
  }
  
  void removeify(Point p){
    points.remove(p);
  }
  
  void display(){
      for (int i = 1; i < points.size()-2; i++){
        curve(points.get(i-1).x,points.get(i-1).y,
              points.get(i).x,points.get(i).y,
              points.get(i+1).x,points.get(i+1).y,
              points.get(i+2).x,points.get(i+2).y);
      }
      if (points.size() == 2){
        curve(points.get(0).x,points.get(0).y,
              points.get(0).x,points.get(0).y,
              points.get(1).x,points.get(1).y,
              points.get(1).x,points.get(1).y);
      }
      else if (points.size() == 3){
        curve(points.get(0).x,points.get(0).y,
              points.get(0).x,points.get(0).y,
              points.get(1).x,points.get(1).y,
              points.get(2).x,points.get(2).y);
        curve(points.get(0).x,points.get(0).y,
              points.get(1).x,points.get(1).y,
              points.get(2).x,points.get(2).y,
              points.get(2).x,points.get(2).y);
           
      }
      else if (points.size() > 3){
        curve(points.get(0).x,points.get(0).y,
              points.get(0).x,points.get(0).y,
              points.get(1).x,points.get(1).y,
              points.get(2).x,points.get(2).y);
        curve(points.get(points.size()-3).x,points.get(points.size()-3).y,
              points.get(points.size()-2).x,points.get(points.size()-2).y,
              points.get(points.size()-1).x,points.get(points.size()-1).y,
              points.get(points.size()-1).x,points.get(points.size()-1).y);
      }
       
  }

}
