package com.distributed.databases.tests;

import com.distributed.databases.Neo4jConfig;
import org.neo4j.driver.*;
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
            session.executeWrite(tx -> tx.run(
                    """
                          MATCH (i:Item {itemId: 1})
                          SET
                          i.likesCounter = 0
                       """));
        }
        logger.info("Created likesCounter and set to 0");
    }

    @Override
    public void test(int maxCounterVal) {
        try (Session session = driver.session()) {
            for (int i = 0; i < maxCounterVal; i++) {
                try (Transaction tx = session.beginTransaction()) {
                    try {
                        tx.run(
                       """
                                MATCH (i:Item {itemId: 1})
                                SET
                                i.likesCounter = i.likesCounter + 1
                             """);
                        tx.commit();
                    } catch (Exception e) {
                        tx.rollback();
                        logger.error("Transaction Rolled Back due to Exception: ", e);
                    }
                }
            }
        }
    }

    @Override
    public long getResult() {
        try (Session session = driver.session()) {
            long counter = session.executeRead(tx ->
                    tx.run("""
                            MATCH (i:Item)
                            WHERE i.itemId = 1
                            RETURN i.likesCounter AS counter
                            """).single().get("counter").asLong());
            return counter;
        }
    }
}
