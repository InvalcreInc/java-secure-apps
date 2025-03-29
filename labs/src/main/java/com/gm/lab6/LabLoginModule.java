package com.gm.lab6;

import java.io.IOException;
import java.nio.file.Path;
import java.util.Arrays;
import java.util.Map;
import java.util.Scanner;

import javax.security.auth.Subject;
import javax.security.auth.callback.Callback;
import javax.security.auth.callback.CallbackHandler;
import javax.security.auth.callback.NameCallback;
import javax.security.auth.callback.PasswordCallback;
import javax.security.auth.callback.UnsupportedCallbackException;
import javax.security.auth.login.LoginException;
import javax.security.auth.spi.LoginModule;

import com.sun.security.auth.UserPrincipal;

public class LabLoginModule implements LoginModule {
    private Subject subject;
    private CallbackHandler callbackHandler;
    private String username;
    private UserPrincipal userPrincipal;
    private String passwordFile;

    @Override
    public void initialize(Subject subject, CallbackHandler callbackHandler, Map<String, ?> sharedState,
            Map<String, ?> options) {
        this.subject = subject;
        this.callbackHandler = callbackHandler;
        this.passwordFile = "" + options.get("passwordFile");

    }

    @Override
    public boolean login() throws LoginException {

        try {
            Callback[] callbacks = new Callback[2];
            callbacks[0] = new NameCallback("Username: ");
            callbacks[1] = new PasswordCallback("Password: ", false);

            callbackHandler.handle(callbacks);
            username = ((NameCallback) callbacks[0]).getName();
            char[] password = ((PasswordCallback) callbacks[1]).getPassword();
            return authenticate(username, password);
        } catch (IOException | UnsupportedCallbackException e) {
            throw new LoginException("Error during login: " + e.getMessage());
        }
    }

    @Override
    public boolean commit() throws LoginException {
        return true;
    }

    @Override
    public boolean abort() throws LoginException {
        return true;
    }

    @Override
    public boolean logout() throws LoginException {
        return subject.getPrincipals().remove(userPrincipal);

    }

    private boolean authenticate(String username, char[] password) throws IOException {
        try (Scanner in = new Scanner(Path.of(passwordFile))) {
            while (in.hasNextLine()) {
                String[] inputs = in.nextLine().split("\\|");
                if (inputs[0].equals(username) && Arrays.equals(inputs[1].toCharArray(), password)) {
                    userPrincipal = new UserPrincipal(username);
                    subject.getPrincipals().add(userPrincipal);
                    return true;
                }
            }
        }
        return false;

    }

}
