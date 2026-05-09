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
import com.gantavya.dao.StaffDao;
import com.gantavya.util.Validation;
import com.gantavya.model.PassengerModel;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/Pages/Login.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    // 1. Read form parameters
	    String identifier = request.getParameter("email");
	    String password   = request.getParameter("password");
	    String remember   = request.getParameter("rememberMe");
	    
	    // 2. Read Redirect Target (Persistent across attempts)
	    String targetUrl = request.getParameter("targetUrl");

	    String emailError = null;
	    String passError  = null;
	    boolean hasError  = false;

	    // 3. Basic validation
	    if (identifier == null || identifier.trim().isEmpty()) {
	        emailError = "Email or Staff ID is required.";
	        hasError   = true;
	    }

	    if (password == null || password.trim().isEmpty()) {
	        passError = "Password cannot be empty.";
	        hasError  = true;
	    }

	    // 4. Authenticate
	    if (!hasError) {
	        // Read targetUrl from session as backup before invalidating
	        HttpSession oldSession = request.getSession(false);
	        String targetUrlFromSession = (oldSession != null) ? (String) oldSession.getAttribute("targetUrl") : null;
	        
	        if (targetUrl == null || targetUrl.isEmpty()) {
	            targetUrl = targetUrlFromSession;
	        }

	        if (oldSession != null) {
	            oldSession.invalidate();
	        }

	        // 4a. Try STAFF login first
	        StaffDao staffDao = new StaffDao();
	        String memberType = staffDao.authenticateStaff(identifier.trim(), password);

	        if (memberType != null) {
	            HttpSession session = request.getSession(true);
	            session.setAttribute("userEmail", identifier.trim());
	            session.setAttribute("role", memberType.toUpperCase()); 
	            session.setAttribute("isLoggedIn", true);

	            handleRememberMe(response, identifier.trim(), remember);

	            response.sendRedirect(request.getContextPath() + "/admin");
	            return;
	        }

	        // 4b. Try PASSENGER login
	        PassengerDao passengerDao = new PassengerDao();
	        boolean isPassenger = passengerDao.authenticatePassenger(identifier.trim(), password);

	        if (isPassenger) {
	            PassengerModel passenger = passengerDao.getPassengerByEmail(identifier.trim());
	            HttpSession session = request.getSession(true);
	            session.setAttribute("userEmail", identifier.trim());
	            session.setAttribute("role", "PASSENGER");
	            session.setAttribute("isLoggedIn", true);
	            session.setAttribute("user", passenger); // For Navbar
	            session.setAttribute("passengerId", passenger.getId());
	            session.setAttribute("passengerName", passenger.getFullName());
	            
	            handleRememberMe(response, identifier.trim(), remember);

	            System.out.println("DEBUG: Login successful. Redirecting to: " + targetUrl);
	            
	            if (targetUrl != null && !targetUrl.isEmpty()) {
	                response.sendRedirect(targetUrl);
	            } else {
	                response.sendRedirect(request.getContextPath() + "/home");
	            }
	            return;
	        } else {
	            passError = "Invalid Email/Staff ID or Password.";
	            hasError = true;
	        }
	    }

	    // 5. Login failed – forward back to login page
	    request.setAttribute("emailError", emailError);
	    request.setAttribute("passError", passError);
	    request.setAttribute("emailValue", identifier);
	    request.setAttribute("targetUrl", targetUrl); // This is now in scope!
	    request.getRequestDispatcher("/WEB-INF/Pages/Login.jsp").forward(request, response);
	}

	private void handleRememberMe(HttpServletResponse response, String identifier, String remember) {
	    Cookie emailCookie = new Cookie("savedEmail", identifier);
	    if ("on".equals(remember)) {
	        emailCookie.setMaxAge(7 * 24 * 60 * 60); // 7 days
	    } else {
	        emailCookie.setMaxAge(0);
	    }
	    emailCookie.setHttpOnly(true);
	    emailCookie.setPath("/");
	    response.addCookie(emailCookie);
	}
}
