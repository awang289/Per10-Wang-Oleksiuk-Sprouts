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
