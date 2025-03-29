package com.gm.lab1;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;

import com.gm.utils.ExpWriter;

import net.lingala.zip4j.ZipFile;
import net.lingala.zip4j.exception.ZipException;

public class Task2 {
    private final ZipFile file;
    private final String outputFilename;

    public Task2(String fileName, String outputFilename) {
        this.outputFilename = outputFilename;
        file = new ZipFile(fileName);
    }

    /**
     * Starts the brute-force attack on the ZIP file.
     */
    public void brute() {
        System.err.println("Valid file: " + file.isValidZipFile());
        fetchDictionary();
    }

    /**
     * Fetches a dictionary of common passwords from a remote source
     * and attempts to crack the ZIP file using each password.
     */
    @SuppressWarnings("CallToPrintStackTrace")
    private void fetchDictionary() {
        int count = 0;
        try {
            URL src = new URI(
                    "https://raw.githubusercontent.com/danielmiessler/SecLists/refs/heads/master/Passwords/Common-Credentials/10k-most-common.txt")
                    .toURL();
            HttpURLConnection connection = (HttpURLConnection) src.openConnection();
            connection.setRequestMethod("GET");
            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                try (BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()))) {
                    String inputLine;

                    while ((inputLine = in.readLine()) != null) {
                        String password = inputLine.trim();
                        boolean cracked = bruteZip(password);
                        if (cracked) {
                            savePassword(password);
                            break;
                        }
                        count++;
                    }
                }
            } else {
                System.out.println("GET request failed. Response Code: " + responseCode);
            }
        } catch (IOException | URISyntaxException e) {
            e.printStackTrace();
        }

        System.out.println("Counts: " + count);
    }

    /**
     * Saves the cracked password to a specified output file.
     *
     * @param password
     *                 The cracked password to save.
     */
    private void savePassword(String password) {
        new ExpWriter(outputFilename, new String[] { password }).write();
        System.out.println("Cracked!!! " + password);
    }

    /**
     * Attempts to crack the ZIP file using the provided password.
     *
     * @param password
     *                 The password to test against the ZIP file.
     * @return true if the password successfully unlocks the ZIP file, false
     *         otherwise.
     */
    private boolean bruteZip(String password) {
        try {
            if (file.isEncrypted()) {
                file.setPassword(password.toCharArray());
            }
            file.extractAll("extracted");
            return true;
        } catch (ZipException e) {
            return false;
        }
    }
}
