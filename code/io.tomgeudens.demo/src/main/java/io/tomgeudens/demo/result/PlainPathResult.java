package io.tomgeudens.demo.result;

import java.util.List;
import java.util.Map;

/**
 * Plain Path Result
 * Class to capture a representation of a path
 *
 * @author Tom Geudens
 * @version 1.0.0
 * @since 2020-08-18
 */

public class PlainPathResult {
    public Long start;
    public List<Long> list;

    public PlainPathResult(Long start, List<Long> list) {
        this.start = start;
        this.list = list;
    }

    public PlainPathResult(Map<String, Object> row) {
        // these are quite often useful as Neo4j does work with the concept
        this(
                (Long)row.get("start"),
                (List<Long>)row.get("list")
        );
    }
}
