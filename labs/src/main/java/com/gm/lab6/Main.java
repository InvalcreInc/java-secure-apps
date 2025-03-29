package com.gm.lab6;

import javax.swing.SwingUtilities;

public class Main {

    public static void main(String[] args) {

        SwingUtilities.invokeLater(() -> {
            JAASFrame window = new JAASFrame();
            window.setVisible(true);
        });
    }

}
