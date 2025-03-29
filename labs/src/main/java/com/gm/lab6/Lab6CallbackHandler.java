package com.gm.lab6;

import java.io.IOException;

import javax.security.auth.callback.Callback;
import javax.security.auth.callback.CallbackHandler;
import javax.security.auth.callback.NameCallback;
import javax.security.auth.callback.PasswordCallback;
import javax.security.auth.callback.UnsupportedCallbackException;

/**
 * Lab6CallbackHandler is an implementation of the CallbackHandler interface.
 * It is used to handle authentication callbacks for username and password.
 * 
 * This class stores the username and password provided during instantiation
 * and sets them in response to the appropriate callbacks.
 */
public class Lab6CallbackHandler implements CallbackHandler {
    private final String username;
    private final char[] password;

    public Lab6CallbackHandler(String username, char[] password) {
        this.username = username;
        this.password = password;
    }

    @Override
    public void handle(Callback[] callbacks) throws IOException, UnsupportedCallbackException {
        for (Callback callback : callbacks) {
            switch (callback) {
                case NameCallback nameCallback -> nameCallback.setName(username);
                case PasswordCallback passwordCallback -> passwordCallback.setPassword(password);
                default -> throw new UnsupportedCallbackException(callback);
            }
        }
    }

}
