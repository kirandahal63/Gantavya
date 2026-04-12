package com.gantavya.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.gantavya.util.Validation;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("/WEB-INF/Pages/Login.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String email    = request.getParameter("email");
	    String password = request.getParameter("password");

	    String emailError = null;
	    String passError  = null;
	    boolean hasError  = false;

	    // 1. Validate Email
	    if (email == null || email.trim().isEmpty()) {
	        emailError = "Email is required.";
	        hasError = true;
	    } else if (!Validation.isValidEmail(email)) {
	        emailError = "Please enter a valid email.";
	        hasError = true;
	    }

	    // 2. Validate Password
	    if (password == null || password.trim().isEmpty()) {
	        passError = "Password cannot be empty.";
	        hasError = true;
	    }

	    // 3. Authenticate (only if basic validation passed)
	    if (!hasError) {
	        if ("admin@test.com".equals(email) && "password123".equals(password)) {
	            response.sendRedirect(request.getContextPath() + "/home");
	            return;
	        } else {
	            // General login failure - usually shown above or under password
	            passError = "Invalid email or password.";
	            hasError = true;
	        }
	    }

	    // 4. Forward back with specific errors
	    request.setAttribute("emailError", emailError);
	    request.setAttribute("passError", passError);
	    request.setAttribute("emailValue", email); // Keep text in box
	    request.getRequestDispatcher("/WEB-INF/Pages/Login.jsp").forward(request, response);
	}

}
