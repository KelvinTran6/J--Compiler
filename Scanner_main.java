import java.io.IOException;

public class Scanner_main {
    public static void main(String[] args) throws IOException{

        if(args.length == 0){
            System.out.println("missing file argument");
            System.exit(0);
        }

        // program can read consecutive files but the program will crash if one of the files has a fatal error
        for(int i = 0; i < args.length; i++){
            Token_Generator p = new Token_Generator (args[i]);
            Token current = p.getToken(); 
            while(current != null) {
                System.out.println(current);
                current = p.getToken();
            }
        }

        System.exit(0);
    }
}
