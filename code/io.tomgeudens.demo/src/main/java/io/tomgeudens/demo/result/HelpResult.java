package io.tomgeudens.demo.result;

import java.util.Map;

/**
 * Help Result
 * Class to capture the results from io.tomgeudens.demo.help()
 *
 * @author Tom Geudens
 * @version 1.0.0
 * @since 2020-08-17
 */

public class HelpResult {
    public String type;
    public String name;
    public String text;
    public String signature;

    public HelpResult(String type, String name, String text, String signature) {
        this.type = type;
        this.name = name;
        this.text = text;
        this.signature = signature;
    }

    public HelpResult(Map<String, Object> row) {
        this(
                (String)row.get("type"),
                (String)row.get("name"),
                (String)row.get("description"),
                (String)row.get("signature")
        );
    }
}
