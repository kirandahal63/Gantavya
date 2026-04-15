package com.gantavya.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.gantavya.dao.PassengerDao;
import com.gantavya.model.PassengerModel;
import com.gantavya.util.Validation;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/Register")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response) 
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("/WEB-INF/Pages/Register.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    // 1. Retrieve raw parameters from the JSP form
	    String fullName = request.getParameter("passengerName");
	    String contactStr = request.getParameter("contactNumber");
	    String dob = request.getParameter("dateOfBirth");
	    String gender = request.getParameter("gender");
	    String email = request.getParameter("email");
	    String password = request.getParameter("password");

	    // 2. Core Java Validation (Manual checks from your Validation util)
	    boolean hasError = false;

	    
	    if (!Validation.isValidFullName(fullName)) {
	        request.setAttribute("nameError", "Please enter your full name!");
	        hasError = true;
	    }
	    if (!Validation.isValidPhone(contactStr)) {
	        request.setAttribute("phoneError", "Please enter a valid number!");
	        hasError = true;
	    }
	    if (!Validation.isValidDOB(dob)) {
	        request.setAttribute("dobError", "You must be at least 18 years old to register.");
	        hasError = true;
	    }
	    if (!Validation.isValidEmail(email)) {
	        request.setAttribute("emailError", "Please enter a valid number!");
	        hasError = true;
	    }
	    
	    
	    
	    

	    // 3. Check for Validation Failures
	    if (hasError) {
	        // Send inputs back so the user doesn't have to re-fill the whole form
	        request.setAttribute("passengerNameValue", fullName);
	        request.setAttribute("contactNumberValue", contactStr);
	        request.setAttribute("emailValue", email);
	        request.setAttribute("dateOfBirthValue", dob);
	        request.setAttribute("genderValue", gender);
	        request.setAttribute("passwordValue", password);	        
	        request.getRequestDispatcher("/WEB-INF/Pages/Register.jsp").forward(request, response);
	        return; // Stop execution here
	    }

	    // 4. Database Validation (Uniqueness)
	    // Safe to parse now because Validation.isValidPhone confirmed it's numeric
	    long contact = Long.parseLong(contactStr); 
	    PassengerDao dao = new PassengerDao();

	    // Check if Email already exists
	    if (dao.isEmailExists(email)) {
	        request.setAttribute("emailError", "This email is already registered.");
	        request.setAttribute("passengerNameValue", fullName);
	        request.setAttribute("contactNumberValue", contactStr);
	        request.setAttribute("emailValue", email);
	        request.setAttribute("dateOfBirthValue", dob);
	        request.setAttribute("genderValue", gender);
	        request.setAttribute("passwordValue", password);
	        request.getRequestDispatcher("/WEB-INF/Pages/Register.jsp").forward(request, response);
	        return;
	    }

	    // Check if Contact Number already exists
	    if (dao.isNumberExists(contact)) {
	        request.setAttribute("phoneError", "This contact number is already registered.");
	        request.setAttribute("passengerNameValue", fullName);
	        request.setAttribute("contactNumberValue", contactStr);
	        request.setAttribute("emailValue", email);
	        request.setAttribute("dateOfBirthValue", dob);
	        request.setAttribute("genderValue", gender);
	        request.setAttribute("passwordValue", password);
	        request.getRequestDispatcher("/WEB-INF/Pages/Register.jsp").forward(request, response);
	        return;
	    }

	    PassengerModel passenger = new PassengerModel(fullName, contact, dob, gender, email, password);
	    boolean isSaved = dao.registerPassenger(passenger);

	    if (isSaved) {
	        // Successful registration: Redirect to login with a success flag
	        response.sendRedirect(request.getContextPath() + "/login?success=1");
	    } else {
	        // Database error or unexpected failure
	        request.setAttribute("error", "An internal error occurred. Please try again later.");
	        request.getRequestDispatcher("/WEB-INF/Pages/Register.jsp").forward(request, response);
	    }
	}

}
