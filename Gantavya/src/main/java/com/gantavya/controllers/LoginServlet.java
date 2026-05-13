package com.gantavya.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import com.gantavya.model.PassengerModel;
import com.gantavya.util.LockoutManager;

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
	    String targetUrl  = request.getParameter("targetUrl");

	    String emailError = null;
	    String passError  = null;
	    boolean hasError  = false;

	    // 2. Basic validation
	    if (identifier == null || identifier.trim().isEmpty()) {
	        emailError = "Please enter a registered email address.";
	        hasError   = true;
	    }

	    if (password == null || password.trim().isEmpty()) {
	        passError = "Please enter a valid password.";
	        hasError  = true;
	    }

	    // 3. Lockout Check
	    if (!hasError && identifier != null) {
	        if (LockoutManager.isLocked(identifier)) {
	            long remainingMillis = LockoutManager.getRemainingTimeMillis(identifier);
	            long remainingMins = remainingMillis / 1000 / 60;
	            passError = "Account is locked. Please try again in approximately " + (remainingMins + 1) + " minute(s).";
	            hasError = true;
	        }
	    }

	    // 4. Authenticate
	    if (!hasError) {
	        String id = identifier.trim().toLowerCase();
	        
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
	        com.gantavya.service.StaffService staffService = new com.gantavya.service.StaffService();
	        String memberType = staffService.authenticateStaff(id, password);

	        if (memberType != null) {
	            LockoutManager.resetAttempts(id);

	            HttpSession session = request.getSession(true);
	            session.setAttribute("userEmail", id);
	            session.setAttribute("role", memberType.toUpperCase()); 
	            session.setAttribute("isLoggedIn", true);

	            handleRememberMe(response, id, remember);

	            response.sendRedirect(request.getContextPath() + "/admin");
	            return;
	        }

	        // 4b. Try PASSENGER login
	        com.gantavya.service.PassengerService passengerService = new com.gantavya.service.PassengerService();
	        boolean isPassenger = passengerService.authenticatePassenger(id, password);

	        if (isPassenger) {
	            LockoutManager.resetAttempts(id);

	            PassengerModel passenger = passengerService.getPassengerByEmail(id);
	            HttpSession session = request.getSession(true);
	            session.setAttribute("userEmail", id);
	            session.setAttribute("role", "PASSENGER");
	            session.setAttribute("isLoggedIn", true);
	            session.setAttribute("user", passenger); 
	            session.setAttribute("passengerId", passenger.getId());
	            session.setAttribute("passengerName", passenger.getFullName());
	            
	            handleRememberMe(response, id, remember);

	            if (targetUrl != null && !targetUrl.isEmpty()) {
	                response.sendRedirect(targetUrl);
	            } else {
	                response.sendRedirect(request.getContextPath() + "/home");
	            }
	            return;
	        } else {
	            // Failed attempt
	            LockoutManager.recordFailedAttempt(id);
	            
	            if (LockoutManager.isLocked(id)) {
	                passError = "Too many failed attempts. Account locked for 5 minutes.";
	            } else {
	                passError = "Please enter a registered email or password.";
	            }
	            hasError = true;
	        }
	    }

	    // 5. Login failed – forward back to login page
	    request.setAttribute("emailError", emailError);
	    request.setAttribute("passError", passError);
	    request.setAttribute("emailValue", identifier);
	    request.setAttribute("targetUrl", targetUrl);
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



