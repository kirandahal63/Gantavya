package com.gantavya.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import com.gantavya.dao.TripDao;
import com.gantavya.model.TripModel;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {
    private TripDao tripDao = new TripDao();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String from = request.getParameter("from");
        String to = request.getParameter("to");
        String date = request.getParameter("date");
        String passengers = request.getParameter("passengers");

        // Fetch dynamic data from database
        List<TripModel> trips = tripDao.searchTrips(from, to, date);

        request.setAttribute("searchFrom", from);
        request.setAttribute("searchTo", to);
        request.setAttribute("searchDate", date);
        request.setAttribute("searchPassengers", passengers);
        request.setAttribute("trips", trips);

        request.getRequestDispatcher("/WEB-INF/Pages/Booking.jsp").forward(request, response);
    }
}
