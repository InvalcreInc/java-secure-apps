package com.gm.lab1;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import com.gm.utils.Calculator;
import com.gm.utils.ExpReader;
import com.gm.utils.ExpWriter;

public class Task {
    private static final String MATH_REGEX = "[*/+\\-]";
    private final String filename;

    public Task(String filename) {
        this.filename = filename;
    }

    /**
     * Starts the calculation process by reading expressions from a file,
     * calculating results, and writing them to an output file.
     */
    public void start() {
        ArrayList<String> lines = new ExpReader(filename).read();
        System.out.println(lines);
        ArrayList<Double> calculations = lines.stream()
                .map(l -> calculate(l))
                .collect(Collectors.toCollection(ArrayList::new));
        String[] contents = format(calculations, lines);
        new ExpWriter("calculations.txt", contents).write();
    }

    /**
     * Calculates the result of a mathematical expression.
     *
     * @param expression
     *                   The mathematical expression to calculate.
     * @return The result of the calculation.
     */
    public static double calculate(String expression) {
        String cleaned = expression.replaceAll(" ", "").trim();
        String operator = findOperator(cleaned);
        ArrayList<String> arr = new ArrayList<>(Arrays.asList(cleaned.split(MATH_REGEX)));
        Calculator calculator = new Calculator(convertDoubles(arr), operator);
        return calculator.calculate();
    }

    /**
     * Finds the first operator in a mathematical expression.
     *
     * @param exp
     *            The expression to search for an operator.
     * @return The first operator found, or an empty string if none is found.
     */
    private static String findOperator(String exp) {
        Pattern pattern = Pattern.compile(MATH_REGEX);
        Matcher matcher = pattern.matcher(exp);
        if (matcher.find())
            return matcher.group();
        return "";
    }

    /**
     * Converts an ArrayList of strings to an ArrayList of doubles.
     *
     * @param arr
     *            The ArrayList of strings to convert.
     * @return An ArrayList of doubles.
     */
    private static ArrayList<Double> convertDoubles(ArrayList<String> arr) {
        return arr.stream().map(d -> {
            try {
                return Double.valueOf(d);
            } catch (NumberFormatException e) {
                return 0.0; // invalid
            }
        }).collect(Collectors.toCollection(ArrayList::new));
    }

    /**
     * Formats the calculations and their corresponding expressions into a string
     * array.
     *
     * @param calculations
     *                     The results of the calculations.
     * @param exps
     *                     The original expressions.
     * @return A string array containing formatted results.
     */
    private static String[] format(ArrayList<Double> calculations, ArrayList<String> exps) {
        ArrayList<String> arr = new ArrayList<>();
        for (int i = 0; i < exps.size(); i++) {
            String exp = exps.get(i);
            double ans = calculations.get(i);
            arr.add(exp + "=" + ans);
        }
        return arr.toArray(String[]::new);
    }
}
