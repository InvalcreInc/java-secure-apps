package com.gm.lab4;

import java.io.File;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.gm.utils.ConsoleReader;

public class Main {
    private static final String FILENAME = "/home/wabira/Documents/security apps/labs/labs/src/main/java/com/gm/lab4/lab4.sh";

    public static void main(String[] args) {
        boolean allowAll;
        ConsoleReader reader = new ConsoleReader();
        if (args.length > 0) {
            allowAll = args[0].equals("allow");
        } else {
            String value = reader.read("Do you want to allow permissions? (Y/n): ");
            allowAll = value.equalsIgnoreCase("y") || value.equalsIgnoreCase("yes");
        }

        File file = new File(FILENAME);
        System.out.println("File name: " + FILENAME);
        if (file.exists()) {
            System.out.println("File exists.");
            System.out.println("The file is available for execution: "
                    + file.canExecute());
            System.out.println("The file is readable: " + file.canRead());
            System.out.println("File is writable: " + file.canWrite());
        }
        System.out.println();
        System.out.println("Setting file permissions.");
        file.setExecutable(allowAll);
        file.setReadable(allowAll);
        file.setWritable(allowAll);
        System.out.println("The file is available for execution: "
                + file.canExecute());
        System.out.println("The file is readable: " + file.canRead());
        System.out.println("File is writable: " + file.canWrite());
        try {
            if (file.createNewFile()) {
                System.out.println("File created.");
            } else {
                System.out.println("Failed to create file.");
            }
        } catch (IOException ex) {
            Logger.getLogger(Main.class.getName())
                    .log(Level.SEVERE, null, ex);
        }
    }
}
