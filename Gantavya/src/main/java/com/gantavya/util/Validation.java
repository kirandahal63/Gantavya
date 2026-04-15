package com.gantavya.util;
import java.time.LocalDate;

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
	
	//contact number validation
	public static boolean isValidPhone(String phone) {
	    if (phone == null) return false;

	    phone = phone.trim();
	    if (phone.length() != 10) return false;
	    if (!phone.startsWith("98") && !phone.startsWith("97")) return false;
	    for (int i = 0; i < phone.length(); i++) {
	        if (!Character.isDigit(phone.charAt(i))) {
	            return false;
	        }
	    }

	    return true;
	}
	
	public static boolean isValidDOB(String dobString) {
	    if (dobString == null || dobString.isEmpty()) return false;

	    try {
	        // dobString comes as "2000-12-31"
	        String[] parts = dobString.split("-");
	        int birthYear = Integer.parseInt(parts[0]);
	        int birthMonth = Integer.parseInt(parts[1]);
	        int birthDay = Integer.parseInt(parts[2]);

	        LocalDate today = LocalDate.now();
	        int currentYear = today.getYear();
	        int currentMonth = today.getMonthValue();
	        int currentDay = today.getDayOfMonth();

	        int age = currentYear - birthYear;
	        if (currentMonth < birthMonth || (currentMonth == birthMonth && currentDay < birthDay)) {
	            age--;
	        }

	        return age >= 18;

	    } catch (Exception e) {
	        return false;
	    }
	}
	
	
	
}
