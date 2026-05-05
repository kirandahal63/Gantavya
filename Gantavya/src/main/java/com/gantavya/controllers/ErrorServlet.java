package com.gantavya.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class ErrorServlet
 */
@WebServlet("/error")
public class ErrorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        
        // Tomcat automatically stores the error code in this attribute
        Integer statusCode = (Integer) req.getAttribute("jakarta.servlet.error.status_code");

        if (statusCode != null && statusCode == 500) {
            req.setAttribute("errorType", "500");
            req.getRequestDispatcher("/WEB-INF/Pages/500error.jsp").forward(req, res);
            
        } else {
            // Default to 404 (Page Not Found)
        	req.getRequestDispatcher("/WEB-INF/Pages/404error.jsp").forward(req, res);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        doGet(req, res);
    }
}