package com.gm.utils;

import java.util.Scanner;

public class ConsoleReader {
    private final Scanner scanner;

    public static void main(String[] args) {
        ConsoleReader reader = new ConsoleReader();
        reader.read("TEST READ:");
    }

    public ConsoleReader() {
        this.scanner = new Scanner(System.in);
    }

    public String read(String message) {
        String filename = null;
        try {
            System.err.println(message);
            filename = scanner.nextLine();
            System.err.println("Filename: " + filename);
        } catch (Exception e) {
        }
        return filename;
    }

    public void close() {
        scanner.close();
    }
}
