package de.eng;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import static net.logstash.logback.argument.StructuredArguments.value;

public class Main {

    static final Logger log = LoggerFactory.getLogger(Main.class);

    public static void main(String[] args) {

        int i = 0;
        try {
            while(true) {
                log.debug("Debug Test {}", value("iteration", i));
                log.info("Info Test {}", value("iteration", i));
                i++;
                Thread.sleep(60000);
            }
        }
        catch(InterruptedException e) {
        }
    }
}
