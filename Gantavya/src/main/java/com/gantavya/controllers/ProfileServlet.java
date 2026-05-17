package com.gantavya.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import com.gantavya.model.PassengerModel;
import com.gantavya.service.PassengerService;
import com.gantavya.util.Validation;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PassengerService passengerService = new PassengerService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String email = (String) session.getAttribute("userEmail");
        PassengerModel passenger = passengerService.getPassengerByEmail(email);
        
        if (passenger != null) {
            request.setAttribute("passenger", passenger);
            request.getRequestDispatcher("/WEB-INF/Pages/Profile.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        String email = (String) session.getAttribute("userEmail");

        if ("updateDetails".equals(action)) {
            handleUpdateDetails(request, response, email);
        } else if ("changePassword".equals(action)) {
            handleChangePassword(request, response, email);
        }
    }

    private void handleUpdateDetails(HttpServletRequest request, HttpServletResponse response, String oldEmail) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String passengerId = (String) session.getAttribute("passengerId");
        
        String name = request.getParameter("fullName");
        String email = request.getParameter("email");
        if (email == null) {
            email = oldEmail;
        }
        
        String phoneStr = request.getParameter("phone");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");

        boolean hasError = false;
        if (!Validation.isValidFullName(name)) {
            request.setAttribute("nameError", "Invalid name format.");
            hasError = true;
        }
        if (!Validation.isValidEmail(email)) {
            request.setAttribute("emailError", "Invalid email format.");
            hasError = true;
        }
        
        // If email changed, check if new email exists
        if (!email.equalsIgnoreCase(oldEmail) && passengerService.isEmailExists(email)) {
            request.setAttribute("emailError", "Email already registered.");
            hasError = true;
        }

        if (!Validation.isValidPhone(phoneStr)) {
            request.setAttribute("phoneError", "Invalid phone number.");
            hasError = true;
        }
        if (!Validation.isValidDOB(dob)) {
            request.setAttribute("dobError", "You must be at least 18 years old.");
            hasError = true;
        }

        if (hasError) {
            doGet(request, response);
            return;
        }

        PassengerModel passenger = new PassengerModel(name, Long.parseLong(phoneStr), dob, gender, email, null);
        passenger.setId(passengerId); // Identification by ID is more robust

        if (passengerService.updatePassengerDetails(passenger)) {
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/login?msg=Profile updated successfully. Please login again.");
        } else {
            request.setAttribute("errorMessage", "Failed to update profile.");
            doGet(request, response);
        }
    }

    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response, String email) throws ServletException, IOException {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "New passwords do not match.");
            doGet(request, response);
            return;
        }

        // Verify current password
        if (!passengerService.authenticatePassenger(email, currentPassword)) {
            request.setAttribute("errorMessage", "Current password is incorrect.");
            doGet(request, response);
            return;
        }

        if (passengerService.updatePassword(email, newPassword)) {
            HttpSession s = request.getSession();
            if (s != null) s.invalidate();
            response.sendRedirect(request.getContextPath() + "/login?msg=Password changed successfully. Please login again.");
        } else {
            request.setAttribute("errorMessage", "Failed to update password.");
            doGet(request, response);
        }
    }
}

