public class Token {
	String group;
	TokenType type;
	String attr;
	int lineno;
	
	Token(TokenType type, String attr, int lineno) {
		this.type = type;
		this.attr = attr;
		this.lineno = lineno;
		this.group = "";
	}

	Token(String group, TokenType type, String attr,int lineno) {
		this.attr = attr;
		this.type = type;
		this.group = group;
		this.lineno = lineno;
	}

	Token(String group, String attr, int lineno) {
		if(attr != null && group.equals("String")){
			this.attr = attr.substring(1, attr.length() - 1);
		}
		else{
			this.attr = attr;
		}
		this.type = null;
		this.group = group;
		this.lineno = lineno;
	}


	public String toString(){

		if(this.group.equals("Invalid")) {
			System.err.print("Invalid entry found (line " + Integer.toString(this.lineno)+ ")");
			return ""; 
		}
		else if(this.group.equals("Keyword")){
			return this.group + ": " + "(" +this.attr + ")" +" | Token returned: " + "(" +this.type.name() + ") " + "(line " + Integer.toString(this.lineno)+ ")"; 
		}
		else if (this.group.equals("Symbol")) {
			return this.group + ": " +this.attr + " | Token returned: " + "(" +this.type.name() + ") " + "(line " + Integer.toString(this.lineno)+ ")"; 
		}
		if(this.group.equals("String") || this.group.equals("Number")){
			return this.group + ": " + this.attr + " (line " + Integer.toString(this.lineno)+ ")"; 
		}



		return this.type.name() + ": [" + this.attr + "]"
			+ "(line " + Integer.toString(this.lineno)
			+ ")";
	}
}