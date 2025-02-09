package com.distributed.databases;

import org.neo4j.driver.AuthToken;
import org.neo4j.driver.AuthTokens;
import org.neo4j.driver.Driver;
import org.neo4j.driver.GraphDatabase;

/**
 * @author Oleksandr Havrylenko
 **/
public class Neo4jConfig {

    public static final String NEO4J_URI = "bolt://localhost:7687";
    public static final String USERNAME = "neo4j";
    public static final String PASSWORD = "password";

    static Driver initDriver() {
        AuthToken auth = AuthTokens.basic(USERNAME, PASSWORD);
        Driver driver = GraphDatabase.driver(NEO4J_URI, auth);
        driver.verifyConnectivity();
        return driver;
    }
}
