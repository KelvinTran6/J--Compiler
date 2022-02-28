import java.io.*;
import java.nio.charset.StandardCharsets;
import java_cup.runtime.*;


public class Main {
    public static void main(String[] argv) throws Exception{

        try{
            String file_name = argv[0];
            FileInputStream file = new FileInputStream(file_name);
            InputStreamReader is = new InputStreamReader(file, StandardCharsets.UTF_8);
            BufferedReader r = new BufferedReader(is) ;

            ComplexSymbolFactory csf = new ComplexSymbolFactory();
            Node start = new Node("program");

            scanner s = new scanner(r, csf);
            parser p = new parser(s, csf, start);
            Symbol symm = p.parse();

            dfs(start, "");
        }  
        catch(FileNotFoundException e) {
            System.out.println(e);
            System.exit(1);
        }
    }

    static void dfs(Node n, String tab) {

        String s = n.toString();
        if(!s.equals("")){
            System.out.println(tab + n.toString());
        }

        for(int i = 0; i < n.children.size(); i++) {
            Node current = n.children.get(i);
            dfs(current,tab + "\t");
        }
    }

}
