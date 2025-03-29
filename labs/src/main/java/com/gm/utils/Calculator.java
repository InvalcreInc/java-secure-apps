package com.gm.utils;

import java.util.ArrayList;

public class Calculator {
    private final ArrayList<Double> values;
    private final String operator;

    public Calculator(ArrayList<Double> inputs, String operand) {
        this.values = inputs;
        this.operator = operand;
    }

    // todo: refactor the bad later
    public double calculate() {
        return switch (operator) {
            case "+" -> values.stream().reduce((a, b) -> a + b).get();
            case "-" -> values.stream().reduce((a, b) -> a - b).get();
            case "/" -> values.stream().reduce((a, b) -> a / b).get();// bad code
            case "*" -> values.stream().reduce((a, b) -> a * b).get();
            default -> 0;
        };
    }

}