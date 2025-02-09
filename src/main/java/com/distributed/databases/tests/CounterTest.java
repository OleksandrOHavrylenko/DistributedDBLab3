package com.distributed.databases.tests;

/**
 * @author Oleksandr Havrylenko
 **/
public interface CounterTest {
    void createData();

    void test(final int maxCounterVal);

    long getResult();
}
