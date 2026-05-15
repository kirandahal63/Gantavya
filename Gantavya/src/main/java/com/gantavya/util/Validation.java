package com.gantavya.util;
import java.time.LocalDate;

public class Validation {
	
	//name validation
	public static boolean isValidFullName(String name) {
	    if (name == null) return false;

	    name = name.trim();

	    // Must contain at least one space
	    if (!name.contains(" ")) return false;

	    // Split by one or more spaces
	    String[] parts = name.split("\\s+");

	    // Need at least first name and last name
	    if (parts.length < 2) return false;

	    // Check every character
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

        if (!email.endsWith("@gmail.com") && !email.endsWith("@outlook.com") &&  !email.endsWith("@hotmail.com") && !email.endsWith(" @icloud.com") 
        		&& !email.endsWith("@islingtoncollege.edu.np")) {
        	    return false;
        	}
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
	
	public static boolean isValidBusNumber(String busNo) {
        return busNo != null && !busNo.trim().isEmpty();
    }

    public static boolean isPositive(long value) {
        return value > 0;
    }

    public static boolean isPositive(int value) {
        return value > 0;
    }

   	
	
}
