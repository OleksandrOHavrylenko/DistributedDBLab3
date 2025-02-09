package com.distributed.databases;

import com.distributed.databases.tests.CounterTest;
import com.distributed.databases.tests.LikesCounterTest;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;

/**
 * @author Oleksandr Havrylenko
 **/
public class _02_SetCounter {

    @Disabled
    @Test
    void setLikesCounterTest() {
        CounterTest test = new LikesCounterTest();
        test.createData();
    }
}
