package com.gantavya.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

import com.gantavya.service.PassengerService;
import com.gantavya.model.PassengerModel;
import com.gantavya.util.LockoutManager;

@WebServlet("/auth/google")
public class GoogleAuthServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PassengerService passengerService = new PassengerService();

    public GoogleAuthServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        if (email == null || email.trim().isEmpty()) {
            out.print("{\"status\":\"error\", \"message\":\"Email is required\"}");
            out.flush();
            return;
        }

        String id = email.trim().toLowerCase();

        // Check if the account is locked due to too many failed password attempts.
        if (LockoutManager.isLocked(id)) {
            long remainingMillis = LockoutManager.getRemainingTimeMillis(id);
            long remainingMins = (remainingMillis / 1000 / 60) + 1;
            out.print("{\"status\":\"error\", \"message\":\"Account is currently locked due to too many failed password attempts. "
            		+ "Please try again in " + remainingMins + " minute(s).\"}");
            out.flush();
            return;
        }

        boolean isRegistered = passengerService.isEmailExists(id);

        if (isRegistered) {
            // Log the user in
            HttpSession oldSession = request.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }
            
            HttpSession session = request.getSession(true);
            session.setAttribute("userEmail", id);
            session.setAttribute("role", "PASSENGER");
            session.setAttribute("isLoggedIn", true);
            
            PassengerModel passenger = passengerService.getPassengerByEmail(id);
            if (passenger != null) {
                session.setAttribute("passengerName", passenger.getFullName());
                session.setAttribute("passengerId", passenger.getId());
                session.setAttribute("user", passenger);
            }
            
            // Reset lockout attempts on successful Google login as well
            LockoutManager.resetAttempts(id);

            out.print("{\"status\":\"registered\"}");
        } else {
            out.print("{\"status\":\"not_registered\"}");
        }
        
        out.flush();
    }
}


