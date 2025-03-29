package com.gm.lab5;

import java.io.BufferedWriter;
import java.io.FilePermission;
import java.io.FileWriter;
import java.io.IOException;

public class Main {
    @SuppressWarnings("CallToPrintStackTrace")
    public static void main(String[] args) throws IOException {

        try {
            FilePermission fp = new FilePermission("/tmp/lab5.txt", "write");
            String s = fp.getActions();
            System.out.print("Action: " + s);
            FileWriter fstream = new FileWriter("/tmp/lab5.txt", false);
            try (BufferedWriter out = new BufferedWriter(fstream)) {
                out.write("simple string");
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }
}
