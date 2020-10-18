import org.neo4j.driver.v1.AuthTokens;
import org.neo4j.driver.v1.Driver;
import org.neo4j.driver.v1.GraphDatabase;
import org.neo4j.driver.v1.Session;
import org.neo4j.driver.v1.Transaction;
import org.neo4j.driver.v1.TransactionWork;
import org.neo4j.driver.v1.StatementResult;
import org.neo4j.driver.v1.Config;
import org.neo4j.driver.v1.AccessMode;

import java.util.HashMap;
import java.util.Map;

/**
 * Hello World implementation for the Neo4j graph database (release &lt; 4.x), 
 * https://neo4j.com/docs/api/java-driver/1.7/
 */
public class HelloWorldNeo4j implements AutoCloseable {
	// AutoClosable is going to provide a means to close the databaseconnection 
	// under all circumstances.

	private final Driver driver;

	/**
	 * Sets up a driver for the database
	 *
	 * @author				Tom Geudens
	 * @param 	uri 		bolt or bolt+routing url
	 * @param 	user 		username for basic authentication
	 * @param 	password	password for basic authentication
	 */
	public HelloWorldNeo4j( String uri, String user, String password ) {
		// Some fiddling may be in order here depending on what you connect to and what
		// version it has. In order not to complicate the example code we don't figure
		// it out in the code itself, in default 3.x setups below will work.

		// Config config = Config.build().withoutEncryption().toConfig();
		// Config config = Config.build().withEncryption().toConfig();
		// driver = GraphDatabase.driver( uri, AuthTokens.basic(user, password), config );
		driver = GraphDatabase.driver( uri, AuthTokens.basic(user, password) );
	}

	@Override
	public void close() {
		driver.close();
	}

	/**
	 * Executes three transactions (write, read, write) on the
	 * database
	 *
	 * @author				Tom Geudens
	 * @param 	message 	string that'll be a property on the database
	 */
	public void doGreeting ( final String message ) {
		// try-with-resources is used to make sure something is closed after
		// use regardless of what happens (the AutoClosable thingie again)
		Long internalnodeid = null;
		String printout = null;

		try( Session session = driver.session(AccessMode.WRITE) ) {
			// only here are we going to notice something is wrong with the
			// connection, creating the driver object itself does not create
			// a connection

			try(Transaction tx = session.beginTransaction()) {
				Map<String, Object> params = new HashMap<>();
				params.put("message", message);				
				StatementResult result = tx.run( "MERGE (a:Greeting {message: $message}) " +
					"RETURN id(a) as internalnodeid", params);
				tx.success();
				internalnodeid = result.single().get( "internalnodeid" ).asLong();
			} catch ( Exception txerror ) {
				// the close happened, but lets find out what went wrong
				System.err.println( txerror.getMessage() );
			}

		} catch ( Exception sessionerror ) {
			// the close happened, but lets find out what went wrong
			System.err.println( sessionerror.getMessage() );
		}
		System.out.println( "session with write transaction, created node: " + internalnodeid );

		try( Session session = driver.session(AccessMode.READ) ) {
			// only here are we going to notice something is wrong with the
			// connection, creating the driver object itself does not create
			// a connection

			try(Transaction tx = session.beginTransaction()) {
				Map<String, Object> params = new HashMap<>();
				params.put("internalnodeid", internalnodeid);
				StatementResult result = tx.run( "MATCH (a:Greeting) " +
					"WHERE id(a) = $internalnodeid " +
					"RETURN a.message", params);
				tx.success();
				printout = result.single().get( 0 ).asString() + " from node " + internalnodeid;
			} catch ( Exception txerror ) {
				// the close happened, but lets find out what went wrong
				System.err.println( txerror.getMessage() );				
			}

		} catch ( Exception sessionerror ) {
			// the close happened, but lets find out what went wrong
			System.err.println( sessionerror.getMessage() );
		}
		System.out.println( "session with read transaction, found: " + printout );

		try( Session session = driver.session(AccessMode.WRITE) ) {
			// only here are we going to notice something is wrong with the
			// connection, creating the driver object itself does not create
			// a connection

			try(Transaction tx = session.beginTransaction()) {
				Map<String, Object> params = new HashMap<>();
				params.put("internalnodeid", internalnodeid);		
				tx.run( "MATCH (a:Greeting) " +
						"DELETE a");
				tx.success();
			} catch ( Exception txerror ) {
				// the close happened, but lets find out what went wrong
				System.err.println( txerror.getMessage() );				
			}

		} catch ( Exception sessionerror ) {
			// the close happened, but lets find out what went wrong
			System.err.println( sessionerror.getMessage() );
		}
		System.out.println( "session with write transaction, deleted node: " + internalnodeid );
	}
}