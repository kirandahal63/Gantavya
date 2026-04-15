package com.gantavya.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import com.gantavya.dao.PassengerDao;
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
	    // 1. Get Parameters (Ensure 'rememberMe' matches your JSP name attribute)
	    String email = request.getParameter("email");
	    String password = request.getParameter("password");
	    String remember = request.getParameter("rememberMe");

	    String emailError = null;
	    String passError = null;
	    boolean hasError = false;

	    // 2. Initial Validation
	    if (email == null || email.trim().isEmpty()) {
	        emailError = "Email is required.";
	        hasError = true;
	    } else if (!Validation.isValidEmail(email)) {
	        emailError = "Please enter a valid email.";
	        hasError = true;
	    }

	    if (password == null || password.trim().isEmpty()) {
	        passError = "Password cannot be empty.";
	        hasError = true;
	    }

	    // 3. Attempt Authentication
	    if (!hasError) {
	        PassengerDao dao = new PassengerDao();
	        boolean isAuthenticated = dao.authenticatePassenger(email, password);

	        if (isAuthenticated) {
	            // --- LOGIN SUCCESS ---
	            
	            // A. Handle Session Fixation (Security best practice)
	            HttpSession oldSession = request.getSession(false);
	            if (oldSession != null) {
	                oldSession.invalidate();
	            }
	            HttpSession session = request.getSession(true);
	            session.setAttribute("userEmail", email);
	            session.setAttribute("isLoggedIn", true);

	            // B. "Remember Me" Cookie Logic (Correctly Placed Here)
	            Cookie emailCookie = new Cookie("savedEmail", email);
	            if ("on".equals(remember)) {
	                emailCookie.setMaxAge(7 * 24 * 60 * 60); // 7 days
	            } else {
	                emailCookie.setMaxAge(0); // Delete cookie if unchecked
	            }
	            emailCookie.setHttpOnly(true);
	            emailCookie.setPath("/"); 
	            response.addCookie(emailCookie);

	            // C. Redirect to Dashboard
	            response.sendRedirect(request.getContextPath() + "/dashboard");
	            return; // EXIT - Do not proceed to forwarding logic below

	        } else {
	            passError = "Invalid email or password.";
	            hasError = true;
	        }
	    }

	    // 4. LOGIN FAILED or VALIDATION FAILED
	    // Forward back to the login page with error messages
	    request.setAttribute("emailError", emailError);
	    request.setAttribute("passError", passError);
	    request.setAttribute("emailValue", email); 
	    request.getRequestDispatcher("/WEB-INF/Pages/Login.jsp").forward(request, response);
	}

}
