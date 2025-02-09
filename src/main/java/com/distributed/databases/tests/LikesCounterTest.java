package com.distributed.databases.tests;

import com.distributed.databases.Neo4jConfig;
import org.neo4j.driver.Driver;
import org.neo4j.driver.Session;
import org.neo4j.driver.TransactionContext;
import org.neo4j.driver.Values;
import org.neo4j.driver.summary.ResultSummary;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author Oleksandr Havrylenko
 **/
public class LikesCounterTest implements CounterTest {
    private final static Logger logger = LoggerFactory.getLogger(LikesCounterTest.class);
    private static Driver driver;

    public LikesCounterTest() {
        driver = Neo4jConfig.initDriver();
    }

    @Override
    public void createData() {
        try (Session session = driver.session()) {
            session.writeTransaction(tx -> tx.run(
                    """
                          MATCH (i:Item {itemId: 1})
                          SET
                          i.likesCounter = 0
                       """).consume());
        }
    }

    @Override
    public void test(int maxCounterVal) {
        try (Session session = driver.session()) {
            for (int i = 0; i < maxCounterVal; i++) {
                session.executeWrite(tx -> updateCounter(tx));
            }
        }
    }

    private ResultSummary updateCounter(TransactionContext tx) {
        Long counter = tx.run(
             """
                   MATCH (i:Item)
                   WHERE i.itemId = 1
                   RETURN i.likesCounter AS counter
                """).single().get("counter").asLong();
        counter++;
        ResultSummary result = tx.run("""
                   MATCH (i:Item {itemId: 1})
                   SET
                   i.likesCounter = $counter
                """, Values.parameters("counter", counter)).consume();
        return result;
    }

    @Override
    public long getResult() {
        try (Session session = driver.session()) {
            long counter = session.readTransaction(tx ->
                    tx.run("""
                            MATCH (i:Item)
                            WHERE i.itemId = 1
                            RETURN i.likesCounter AS counter
                            """).single().get("counter").asLong());
            return counter;
        }
    }
}
