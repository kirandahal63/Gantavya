package com.gantavya.util;

public class Validation {
	
	//name validation
	public static boolean isValidFullName(String name) {
        if (name == null) return false;

        name = name.trim();

        if (name.length() < 2) return false;

        for (int i = 0; i < name.length(); i++) {
            char ch = name.charAt(i);

            if (!Character.isLetter(ch) && ch != ' ') {
                return false;
            }
        }
        return true;
    }
	
	//email validation
	public static boolean isValidEmail(String email) {
        if (email == null) return false;

        email = email.trim();

        if (!email.contains("@") || !email.contains(".")) return false;
        if (email.startsWith("@") || email.endsWith("@")) return false;

        return true;
    }
	
	
	
	
	/*
	 * 
	 // ── Password Validation ──────────────────────────────────────
    public static boolean isStrongPassword(String password) {
        if (password == null) return false;

        if (password.length() < 8) return false;

        boolean hasLetter = false;
        boolean hasDigit = false;

        for (int i = 0; i < password.length(); i++) {
            char ch = password.charAt(i);

            if (Character.isLetter(ch)) hasLetter = true;
            if (Character.isDigit(ch)) hasDigit = true;
        }

        return hasLetter && hasDigit;
    }

    // ── Password Match ───────────────────────────────────────────
    public static boolean passwordsMatch(String password, String confirmPassword) {
        if (password == null) return false;
        return password.equals(confirmPassword);
    }

    // ── Empty Check ──────────────────────────────────────────────
    public static boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    // ── Simple Sanitize (basic) ──────────────────────────────────
    public static String sanitize(String input) {
        if (input == null) return "";

        String output = input;

        output = output.replace("<", "");
        output = output.replace(">", "");

        return output;
    }
	 * 
	 */
	
	

}
