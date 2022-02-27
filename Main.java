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
            scanner s = new scanner(r, csf);
            parser p = new parser(s, csf);
            p.parse();


        }  
        catch(FileNotFoundException e) {
            System.out.println(e);
            System.exit(1);
        }
    }
}
