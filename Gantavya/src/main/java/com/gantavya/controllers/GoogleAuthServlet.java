package com.gantavya.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

import com.gantavya.dao.PassengerDao;

@WebServlet("/auth/google")
public class GoogleAuthServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

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

        PassengerDao passengerDao = new PassengerDao();
        boolean isRegistered = passengerDao.isEmailExists(email.trim());

        if (isRegistered) {
            // Log the user in
            HttpSession oldSession = request.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }
            
            HttpSession session = request.getSession(true);
            session.setAttribute("userEmail", email.trim());
            session.setAttribute("role", "PASSENGER");
            session.setAttribute("isLoggedIn", true);
            
            com.gantavya.model.PassengerModel passenger = passengerDao.getPassengerByEmail(email.trim());
            if (passenger != null) {
                session.setAttribute("passengerName", passenger.getFullName());
                session.setAttribute("passengerId", passenger.getId());
                session.setAttribute("user", passenger);
            }
            
            out.print("{\"status\":\"registered\"}");
        } else {
            out.print("{\"status\":\"not_registered\"}");
        }
        
        out.flush();
    }
}
