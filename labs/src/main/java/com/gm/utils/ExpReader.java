
package com.gm.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

public class ExpReader {
    private final String fileName;

    public ExpReader(String filePath) {
        this.fileName = filePath;
    }

    public ArrayList<String> read() {
        ArrayList<String> contents = new ArrayList<>();
        try {

            File file = new File(fileName);
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    contents.add(line);
                }
            }
        } catch (IOException e) {
            System.out.println("An error occurred.");
        }
        return contents;
    }
}
