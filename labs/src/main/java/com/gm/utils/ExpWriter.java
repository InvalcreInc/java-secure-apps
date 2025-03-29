package com.gm.utils;

import java.io.FileWriter;
import java.io.IOException;

public class ExpWriter {
    private final String filename;
    private final String[] contents;

    public ExpWriter(String filename, String[] contents) {
        this.filename = filename;
        this.contents = contents;
    }

    public void write() {
        try {
            try (FileWriter writer = new FileWriter(filename)) {
                for (String c : contents) {
                    writer.append("\n" + c);
                }
                writer.close();
            }

        } catch (IOException e) {
            System.err.println("An Error occurred!");

        }
    }
}
