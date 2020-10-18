import java.util.Map;
import java.util.stream.Stream;
import java.util.stream.Collectors;

public class HelloWorldNeo4jDriver {
	// defaults
	private static Map<String, String> defaults = Stream.of(new String[][] {
		{ "NEO4J_CONNECTIONSTRING", "bolt://127.0.0.1:7687" },
		{ "NEO4J_USERNAME", "neo4j" },
		{ "NEO4J_PASSWORD", "trinity" },
		{ "NEO4J_MESSAGE", "Hello, World" },
	}).collect(Collectors.toMap(data -> data[0], data -> data[1]));

	public static void main( String[] args ) {
		// update defaults with what's in the environment
		Map<String, String> environment = System.getenv();
		for (String defaultkey : defaults.keySet()) {
			if ( environment.containsKey(defaultkey) ) {
				defaults.put( defaultkey, environment.get(defaultkey) );
			}
		}

		// try-with-resources is used to make sure something is closed after
		// use regardless of what happens (the AutoClosable thingie)		
		try ( HelloWorldNeo4j greeter = new HelloWorldNeo4j(
			defaults.get("NEO4J_CONNECTIONSTRING"),
			defaults.get("NEO4J_USERNAME"),
			defaults.get("NEO4J_PASSWORD")) ) {
			greeter.doGreeting( defaults.get("NEO4J_MESSAGE") );			
		}
	}	
}