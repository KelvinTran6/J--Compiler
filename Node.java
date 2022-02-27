import java.util.ArrayList;

public class Node implements Cloneable{
    String value;
    String stage;
    int line;
    int col;
    Node left;
    Node right;
    ArrayList<Node> children = new ArrayList<Node>();

    public Node() {
        this.value = "defaul__t";
        this.children = new ArrayList<Node>();
    }
    public Node(String s) {
        this.stage = s;
        this.children = new ArrayList<Node>();
    }

    public Node (String value, int line, int col) {
        this.value = value;
        this.line = line;
        this.col = col;
        this.children = new ArrayList<Node>();
    }

    public void addNode(Object node) throws CloneNotSupportedException {
        Node n = (Node)((Node)node).clone();
        children.add(n);
    }

    public void addLeft(Object left) throws CloneNotSupportedException {
        Node n = (Node)((Node)left).clone();
        //System.out.println(n.value);
        this.left = n;
    }

    public void addRight(Object right) throws CloneNotSupportedException {
        Node n = (Node)((Node)right).clone();
       // System.out.println(n.value);
        this.right = n;
    }

    public int getLine(){
        return line;
    }

    public Object clone() throws CloneNotSupportedException
    {
        return super.clone();
    }
}
