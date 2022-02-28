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
        if (node == null){
            return;
        }
        Node n = (Node)((Node)node).clone();

        System.out.println(n.hashCode());
        System.out.println(this.hashCode());
        if(n.hashCode() == this.hashCode()){

           return;
        }
        children.add(n);
    }

    public String toString(){
        String s = "";

        if(this.value == null){
            s += this.stage;
        }
        else if(this.value.equals("defaul__t")){
            return "";
        }
        else {
            s+= this.value;
            s = s + "   (line " + String.valueOf(this.line) + ")";
        }

        return s;
    }

    public int numOfChildren() {
        return children.size();
    }

    public void merge(ArrayList<Node> list) {
        this.children.addAll(list);
        System.out.println(this.children.get(0).value);

    }

    public Object clone() throws CloneNotSupportedException
    {
        return super.clone();
    }
}
