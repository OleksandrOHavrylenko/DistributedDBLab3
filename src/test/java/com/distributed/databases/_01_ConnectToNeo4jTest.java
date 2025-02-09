package com.distributed.databases;

import org.junit.jupiter.api.Assumptions;
import org.junit.jupiter.api.Test;
import org.neo4j.driver.Driver;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertNotNull;

/**
 * @author Oleksandr Havrylenko
 **/
public class _01_ConnectToNeo4jTest {
    @Test
    void createDriverAndConnectToServer() {
        Driver driver = Neo4jConfig.initDriver();
        Assumptions.assumeTrue(driver != null);
        assertNotNull(driver, "driver instantiated");
        assertDoesNotThrow(driver::verifyConnectivity,"unable to verify connectivity");
    }
}
