package com.gantavya.controllers;

import com.gantavya.dao.PassengerDao;
import com.gantavya.util.EmailUtil;
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
            session.setAttribute("otpTime", System.currentTimeMillis());

            // Send Email
            String subject = "Gantavya - Password Reset Verification Code";
            String body = "Hello,\n\n"
                        + "You requested a password reset. Your verification code is: " + otp + "\n"
                        + "This code will expire in 1 minute.\n\n"
                        + "If you did not request this, please ignore this email.\n\n"
                        + "Regards,\n"
                        + "Gantavya Team";
            
            boolean emailSent = EmailUtil.sendEmail(email, subject, body);

            if (emailSent) {
                out.print("{\"success\": true, \"message\": \"Verification code sent to email\"}");
            } else {
                // Fallback: still print to console if email fails
                System.out.println("FAILED TO SEND EMAIL TO: " + email);
                System.out.println("Verification Code: " + otp);
                out.print("{\"success\": false, \"message\": \"Failed to send email. Please check server logs.\"}");
            }

        } else if ("verify".equals(action)) {
            String code = request.getParameter("code");
            String storedOtp = (String) session.getAttribute("resetOtp");
            Long otpTime = (Long) session.getAttribute("otpTime");

            if (storedOtp == null || otpTime == null) {
                out.print("{\"success\": false, \"message\": \"No OTP requested or session expired.\"}");
                return;
            }

            // Check expiration (1 minute = 60,000 ms)
            if (System.currentTimeMillis() - otpTime > 60000) {
                out.print("{\"success\": false, \"message\": \"Verification code has expired. Please resend.\"}");
                return;
            }

            if (storedOtp.equals(code)) {
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
        } else if ("resend".equals(action)) {
            String email = (String) session.getAttribute("resetEmail");
            if (email == null) {
                out.print("{\"success\": false, \"message\": \"Session expired. Please start over.\"}");
                return;
            }

            String otp = String.format("%06d", new Random().nextInt(999999));
            session.setAttribute("resetOtp", otp);
            session.setAttribute("otpTime", System.currentTimeMillis());

            String subject = "Gantavya - New Verification Code";
            String body = "Hello,\n\n"
                        + "Your new verification code is: " + otp + "\n"
                        + "This code will expire in 1 minute.\n\n"
                        + "Regards,\n"
                        + "Gantavya Team";

            boolean emailSent = EmailUtil.sendEmail(email, subject, body);
            if (emailSent) {
                out.print("{\"success\": true, \"message\": \"New verification code sent\"}");
            } else {
                out.print("{\"success\": false, \"message\": \"Failed to resend code.\"}");
            }

        } else {
            out.print("{\"success\": false, \"message\": \"Invalid action\"}");
        }
        
        out.flush();
    }
}
