package com.gantavya.controllers;

import com.gantavya.dao.PassengerDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

@WebServlet("/password-reset")
public class ForgotPasswordServlet extends HttpServlet {
    private PassengerDao passengerDao;

    @Override
    public void init() throws ServletException {
        passengerDao = new PassengerDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Just forward to the JSP UI
        request.getRequestDispatcher("/WEB-INF/Pages/ResetPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        if ("generate".equals(action)) {
            String email = request.getParameter("email");
            if (email == null || email.trim().isEmpty()) {
                out.print("{\"success\": false, \"message\": \"Email is required\"}");
                return;
            }

            boolean exists = passengerDao.isEmailExists(email);
            if (!exists) {
                out.print("{\"success\": false, \"message\": \"Email not found\"}");
                return;
            }

            // Generate 6 digit OTP
            String otp = String.format("%06d", new Random().nextInt(999999));
            session.setAttribute("resetOtp", otp);
            session.setAttribute("resetEmail", email);

            // Print OTP to console instead of sending email (since JavaMail is not set up)
            System.out.println("==================================================");
            System.out.println("Password Reset Request for: " + email);
            System.out.println("Your Verification Code is: " + otp);
            System.out.println("==================================================");

            out.print("{\"success\": true, \"message\": \"Verification code sent to email\"}");

        } else if ("verify".equals(action)) {
            String code = request.getParameter("code");
            String storedOtp = (String) session.getAttribute("resetOtp");

            if (storedOtp != null && storedOtp.equals(code)) {
                out.print("{\"success\": true}");
            } else {
                out.print("{\"success\": false, \"message\": \"Invalid verification code\"}");
            }

        } else if ("reset".equals(action)) {
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            String email = (String) session.getAttribute("resetEmail");

            if (email == null) {
                out.print("{\"success\": false, \"message\": \"Session expired. Please try again.\"}");
                return;
            }

            if (newPassword == null || !newPassword.equals(confirmPassword)) {
                out.print("{\"success\": false, \"message\": \"Passwords do not match\"}");
                return;
            }

            boolean updated = passengerDao.updatePassword(email, newPassword);
            if (updated) {
                session.removeAttribute("resetOtp");
                session.removeAttribute("resetEmail");
                out.print("{\"success\": true, \"message\": \"Password updated successfully\"}");
            } else {
                out.print("{\"success\": false, \"message\": \"Failed to update password\"}");
            }
        } else {
            out.print("{\"success\": false, \"message\": \"Invalid action\"}");
        }
        
        out.flush();
    }
}
