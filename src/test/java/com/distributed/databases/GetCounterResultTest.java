package com.distributed.databases;

import com.distributed.databases.tests.CounterTest;
import com.distributed.databases.tests.LikesCounterTest;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

/**
 * @author Oleksandr Havrylenko
 **/
public class GetCounterResultTest {
    @Test
    void getCounter() {
        CounterTest test = new LikesCounterTest();
        long result = test.getResult();
//        assertEquals(0L, result);
    }
}
