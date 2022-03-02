
import java.io.IOException;
import java_cup.runtime.*;
import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.ComplexSymbolFactory.Location;

%%
%type Symbol
%class scanner                              
%cup
%line
%column


%public


%{
    ComplexSymbolFactory symbolFactory;

    StringBuffer string = new StringBuffer();
        public scanner(java.io.Reader in, ComplexSymbolFactory sf){
        this(in);
        this.symbolFactory = sf;
    }


    private Symbol symbol(String name, int sym, String tokenName) {
            Node current = new Node(name, yyline, yycolumn, tokenName);
        return symbolFactory.newSymbol(yytext(), sym, current);
    }

      private Symbol symbol(String name, int sym, Object val, String tokenName) {
          Location left = new Location(yyline+1,yycolumn+1,(int)yychar);
          Location right= new Location(yyline+1,yycolumn+yylength(), (int)yychar+yylength());
          Node current = new Node(yytext(), yyline, yycolumn, tokenName);

          return symbolFactory.newSymbol(name, sym, left, right, current);
      }

	int error_count =0;

	private void increment() {
		error_count++;
		if(error_count > 10) {
			System.out.println("too many invalid tokens detected... closing program");
				System.exit(1);
		}
	}

    private void error(String error) {
        System.out.println(error);
        System.exit(1);
    }

%}

%init{
	yyline = 1;
%init}

ALPHA = [a-zA-Z_]
ALNUM = [a-zA-Z0-9_]
NUMBER = [0-9]+
ID = {ALPHA}{ALNUM}*
ESCAPE_CHARACTERS = ((\\b)|(\\f))|(\\t)|(\\r)|(\\n)|(\\\')|(\\\")|(\\\\)
OPEN_STRING = (\"([^\\\n\"])|{ESCAPE_CHARACTERS})
INVALID_ESCAPE_CHARACTER = \"[^\\\n]*(\\[^bftrn\'\"\\\\']+)
VALID_STRING = (\"([^\\\n]| {ESCAPE_CHARACTERS} )+\")

%%
// Rules

[ \t\r]+	{}
\n		{}

"//".*	{} //comments

"if" {return symbol("IF", sym.IF, "keyword");}
"while" {return symbol("WHILE", sym.WHILE ,"keyword");}
"boolean" {return symbol("BOOLEAN",sym.BOOLEAN,"keyword");}
"else" {return symbol("ELSE", sym.ELSE,"keyword");}
"break" {return symbol("BREAK",sym.BREAK,"keyword");}
"return" {return symbol("RETURN", sym.RETURN,"keyword");}
"int" {return symbol("INT",sym.INT,"keyword");}
"true" {return symbol("TRUE",sym.TRUE,"Boolean");}
"false" {return symbol("FALSE",sym.FALSE,"Boolean");}
"void"  {return symbol("VOID", sym.VOID,"keyword");}
">"		{return symbol(">", sym.GT,"Symbol");}
">="		{return symbol(">=", sym.GE,"Symbol");}
"<"		{return symbol("<", sym.LT,"Symbol");}
"<="		{return symbol("<=", sym.LE,"Symbol");}
"=="		{return symbol("==", sym.EQQ,"Symbol");}
"."		{return symbol(".", sym.DOT,"Symbol");}
"("		{return symbol("(",sym.ORB,"Symbol");}
")"		{return symbol(")", sym.CRB,"Symbol");}
"{"		{return symbol("{", sym.OCB,"Symbol");}
"}"		{return symbol("}", sym.CCB,"Symbol");}
"["		{return symbol("[",sym.OSB,"Symbol");}
"]" 	{return symbol("]", sym.CSB,"Symbol");}
"&&" 	{return symbol("&&", sym.AND,"Symbol");}
"||"	{return symbol("||", sym.OR,"Symbol");}
";"		{return symbol(";", sym.SEMI_COLON,"Symbol");}
","		{return symbol(",", sym.COMMA,"Symbol");}
"!="	{return symbol("!=",sym.NE,"Symbol");}
"!"		{return symbol("!", sym.EX,"Symbol");}
"+"		{return symbol("+", sym.PLUS, yytext(),"Symbol");}
"-" 	{return symbol("-", sym.MINUS,"Symbol");}
"=" 	{return symbol("=", sym.EQ,"Symbol");}
"/" 	{return symbol("/", sym.DIVIDE,"Symbol");}
"*" 	{return symbol("*", sym.STAR,"Symbol");}
"%" 	{return symbol("%", sym.MOD,"Symbol");}

{NUMBER} {return symbol("NUMBER", sym.NUMBER, yytext(),"NUMBER");}
{VALID_STRING}	{return symbol("STRING", sym.STRING, yytext().substring(1, yytext().length()-1) ,"String");}
{OPEN_STRING} {increment(); error("Open string ["+yytext()+"] found on line: " + yyline);}
{INVALID_ESCAPE_CHARACTER} {increment(); error("Invalid escape character ["+yytext()+"] found on line: " + yyline);}
{ID}		{return symbol("ID", sym.ID, yytext(),"ID");}
<<EOF>>                          { return symbol("EOF", sym.EOF, yytext(),"keyword"); }
[^]		{increment(); error("Illegal character ["+yytext()+"] found on line: " + yyline);}
