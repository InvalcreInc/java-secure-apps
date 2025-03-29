package com.gm.lab1;

import com.gm.utils.ConsoleReader;

public class Main {
    public static void main(String[] args) {
        int task = args.length > 0 && args[0].equals("1") ? 1 : 2;
        handleLab1(task);
    }

    private static void handleLab1(int task) {
        ConsoleReader reader = new ConsoleReader();
        switch (task) {
            case 1:
                String filena1 = reader.read("Enter file name(e.g test.zip): ");
                new Task(filena1).start();
                break;
            case 2:
                System.out.println("Zip Brute");
                String filename = reader.read("Enter file name(e.g test.zip): ");
                String outputName = reader.read("Enter output file name(e.g password.zip): ");
                new Task2(filename, outputName).brute();
            default:
                break;
        }
        reader.close();
    }
}
