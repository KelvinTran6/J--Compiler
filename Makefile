compile:
	jflex scanner.flex
	java -jar java-cup-11b.jar -expect 2 parser.cup

	javac -classpath java-cup-11b-runtime.jar sym.java

	javac -classpath :./java-cup-11b-runtime.jar scanner.java 

	javac -classpath :./java-cup-11b-runtime.jar parser.java 

	javac -classpath :./java-cup-11b-runtime.jar Main.java 