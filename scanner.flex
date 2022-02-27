
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


    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }

    private Symbol symbol(String name, int type, Object value) {
            System.out.println(name);
        return symbolFactory.newSymbol(name, type);
    }

	int error_count =0;

	private void increment() {
		error_count++;
		if(error_count > 10) {
			System.out.println("too many errors detected... closing program");
				System.exit(1);
		}

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

"if" {return symbol(sym.IF);}
"while" {return symbol(sym.WHILE);}
"boolean" {return symbol("boolean",sym.BOOLEAN,yytext());}
"else" {return symbol(sym.ELSE);}
"break" {return symbol(sym.BREAK);}
"return" {return symbol(sym.RETURN);}
"int" {return symbol(sym.INT);}
"true" {return symbol(sym.TRUE);}
"false" {return symbol(sym.FALSE);}
"void"  {return symbol(sym.VOID);}
">"		{return symbol(sym.GT);}
">="		{return symbol(sym.GE);}
"<"		{return symbol(sym.LT);}
"<="		{return symbol(sym.LE);}
"=="		{return symbol(sym.EQQ);}
"."		{return symbol(sym.DOT);}
"("		{return symbol(sym.ORB);}
")"		{return symbol(sym.CRB);}
"{"		{return symbol(sym.OCB);}
"}"		{return symbol(sym.CCB);}
"["		{return symbol(sym.OSB);}
"]" 	{return symbol(sym.CSB);}
"&&" 	{return symbol(sym.AND);}
"||"	{return symbol(sym.OR);}
";"		{return symbol(sym.SEMI_COLON);}
","		{return symbol(sym.COMMA);}
"!="	{return symbol(sym.NE);}
"!"		{return symbol(sym.EX);} 
"+"		{return symbol("PLUS", sym.PLUS, yytext());}
"-" 	{return symbol(sym.MINUS);}
"=" 	{return symbol(sym.EQ);}
"/" 	{return symbol(sym.DIVIDE);}
"*" 	{return symbol(sym.STAR);}
"%" 	{return symbol(sym.MOD);}

{NUMBER} {return symbol("NUMBER", sym.NUMBER, yytext());}
{VALID_STRING}	{return symbol("STRING", sym.STRING, yytext().substring(1, yytext().length()-1));}
{OPEN_STRING} {return symbol(sym.OPEN_STRING);}
{INVALID_ESCAPE_CHARACTER} {return symbol(sym.INVALID_ESCAPE_CHARACTER);}
{ID}		{return symbol("ID", sym.ID, yytext());}
[^]		{increment(); throw new Error("Illegal character <"+yytext()+">");}
