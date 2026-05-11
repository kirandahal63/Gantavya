package com.gantavya.controllers;

import com.gantavya.dao.TripDao;

import com.gantavya.model.TripModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class IndexServlet extends HttpServlet {
    private TripDao tripDao = new TripDao();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Fetch real trips from the database
        List<TripModel> tripList = tripDao.getUpcomingTrips();
        
        // Pass the list to index.jsp
        request.setAttribute("trips", tripList);
        
        request.getRequestDispatcher("/WEB-INF/Pages/Index.jsp").forward(request, response);
    }
}