package com.gm.lab6;

import java.awt.BorderLayout;
import java.awt.GridLayout;
import java.awt.HeadlessException;
import java.awt.event.ActionEvent;
import java.security.AccessControlException;

import javax.security.auth.Subject;
import javax.security.auth.login.LoginContext;
import javax.security.auth.login.LoginException;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;

@SuppressWarnings("removal")
public class JAASFrame extends JFrame {
    private final JTextField username;
    private final JPasswordField password;
    private final JTextField propertyName;
    private final JTextField propertyValue;

    public JAASFrame() {
        setTitle("Lab 6");
        setSize(300, 150);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        //
        username = new JTextField(20);
        password = new JPasswordField(20);
        propertyName = new JTextField("lab6.txt");
        propertyValue = new JTextField(20);
        propertyValue.setEditable(false);
        JPanel panel = new JPanel();
        panel.setLayout(new GridLayout(0, 2));
        panel.add(new JLabel("username:"));
        panel.add(username);
        panel.add(new JLabel("password:"));
        panel.add(password);
        panel.add(propertyName);
        panel.add(propertyValue);
        add(panel, BorderLayout.CENTER);
        JButton getValueButton = new JButton("GET VALUE");
        getValueButton.addActionListener((ActionEvent _) -> {
            handleGetValue();
        });
        JPanel buttonPanel = new JPanel();
        buttonPanel.add(getValueButton);
        add(buttonPanel, BorderLayout.SOUTH);
        pack();
    }

    /**
     * Handles the action of retrieving the value from the specified file
     * after successful login.
     */
    private void handleGetValue() {
        try {
            LoginContext context = new LoginContext("jaasApplication", new Lab6CallbackHandler(
                    username.getText(), password.getPassword()));
            context.login();
            System.out.println("Logged in as " + username.getText());
            onGetValue(context.getSubject());
            context.logout();
        } catch (LoginException ex) {
            JOptionPane.showMessageDialog(this, "Login failed: " + ex.getMessage());
        }
        cleanInputs();
    }

    /**
     * Clears the input fields for username and password.
     */
    private void cleanInputs() {
        username.setText("");
        password.setText("");
    }

    /**
     * Retrieves the value from the file using the provided subject
     * and displays it in a dialog.
     *
     * @param subject the authenticated subject
     */
    private void onGetValue(Subject subject) {
        try {
            LabAction privilegedAction = new LabAction();
            String text = Subject.doAsPrivileged(subject, privilegedAction, null);
            JOptionPane.showMessageDialog(this, "File contains: " + text);
        } catch (HeadlessException | AccessControlException e) {
            JOptionPane.showMessageDialog(this, "Failed to get value: " + e.getMessage());
        }
    }

}
