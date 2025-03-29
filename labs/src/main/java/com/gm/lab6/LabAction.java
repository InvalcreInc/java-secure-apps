package com.gm.lab6;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.security.PrivilegedAction;

/**
 * LabAction class implements the PrivilegedAction interface to perform
 * actions that require elevated privileges in a secure manner.
 * 
 * This class reads the content of a specified file ("/tmp/lab6.txt")
 * and returns the first line of the file. If an IOException occurs,
 * it returns the error message instead.
 */
public class LabAction implements PrivilegedAction<String> {

    @Override
    public String run() {
        try {
            String content;
            try (BufferedReader reader = new BufferedReader(new FileReader(new File("/tmp/lab6.txt")))) {
                content = reader.readLine();
            }
            return content;
        } catch (IOException ex) {
            return ex.getMessage();
        }
    }

}
