package com.gantavya.controllers;

import com.gantavya.util.EmailUtil;
import com.gantavya.util.Validation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/Pages/Contact.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // 1. Check for empty fields FIRST
        if (isEmpty(firstName) || isEmpty(lastName) || isEmpty(email) || 
            isEmpty(phone) || isEmpty(subject) || isEmpty(message)) {
            
            request.setAttribute("error", "All fields are mandatory. Please fill in every field.");
            // Forward back so parameters stay in the input boxes
            request.getRequestDispatcher("/WEB-INF/Pages/Contact.jsp").forward(request, response);
            return;
        }

        // 2. Data Validation
        if (!Validation.isValidEmail(email)) {
            request.setAttribute("error", "Please enter a valid email address.");
            request.getRequestDispatcher("/WEB-INF/Pages/Contact.jsp").forward(request, response);
            return;
        }
        if (!Validation.isValidPhone(phone)) {
            request.setAttribute("error", "Please enter a valid phone number.");
            request.getRequestDispatcher("/WEB-INF/Pages/Contact.jsp").forward(request, response);
            return;
        }
        

        // 3. Send Email
        String recipientEmail = "dahal.utsav63@gmail.com";
        String emailSubject = "Inquiry: " + subject;
        String emailBody = "From: " + firstName + " " + lastName + "\nEmail: " + email + "\n\n" + message;

        if (EmailUtil.sendEmail(recipientEmail, emailSubject, emailBody)) {
            request.getSession().setAttribute("success", "Message sent successfully!");
            response.sendRedirect(request.getContextPath() + "/contact");
        } else {
            request.setAttribute("error", "Failed to send email. Please try again later.");
            request.getRequestDispatcher("/WEB-INF/Pages/Contact.jsp").forward(request, response);
        }
    }

    private boolean isEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }
} 