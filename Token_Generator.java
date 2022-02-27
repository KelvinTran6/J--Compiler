import java.io.*;
import java.nio.charset.StandardCharsets;


public class Token_Generator {
    Yylex yylex_scanner;
    public Token_Generator(String file_name){
        try{
            FileInputStream file = new FileInputStream(file_name);
            InputStreamReader is = new InputStreamReader(file, StandardCharsets.UTF_8);
            BufferedReader r = new BufferedReader(is) ;
            yylex_scanner = new Yylex(r); //creating yylex object with file input to read
        }
        catch (FileNotFoundException e){
            System.err.print(e);
            System.exit(1);
        }
    }

    //grabs tokens from Yylex scanner.
    public Token getToken() throws IOException { 
        Token  t = yylex_scanner.yylex();
        if(t == null) {
            System.out.println("<-----------end of file----------->");
            return null;
        }
        else{
            return t;
        }
    }
}
 