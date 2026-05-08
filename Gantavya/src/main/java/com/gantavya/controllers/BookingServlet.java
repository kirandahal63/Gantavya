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
        int passengerCount = 1;
        try {
            if (passengers != null && !passengers.isEmpty()) {
                passengerCount = Integer.parseInt(passengers);
            }
        } catch (NumberFormatException e) {
            passengerCount = 1;
        }

        // Fetch dynamic data from database
        List<TripModel> trips = tripDao.searchTrips(from, to, date, passengerCount);

        // Fallback Logic: If no trips for specific date, search all dates for same route
        boolean isFallback = false;
        String fallbackMessage = null;
        if (trips.isEmpty() && date != null && !date.isEmpty()) {
            List<TripModel> fallbackTrips = tripDao.searchTrips(from, to, "", passengerCount);
            if (!fallbackTrips.isEmpty()) {
                trips = fallbackTrips;
                isFallback = true;
                fallbackMessage = "No trips found for " + date + ". Showing trips for other available dates.";
            }
        }

        if ("true".equals(request.getParameter("ajax"))) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            StringBuilder json = new StringBuilder("{");
            json.append("\"fallback\":").append(isFallback).append(",");
            json.append("\"message\":").append(fallbackMessage == null ? "null" : "\"" + fallbackMessage + "\"").append(",");
            json.append("\"trips\":[");
            
            for (int i = 0; i < trips.size(); i++) {
                TripModel t = trips.get(i);
                json.append("{")
                    .append("\"tripId\":\"").append(t.getTripId()).append("\",")
                    .append("\"source\":\"").append(t.getSource()).append("\",")
                    .append("\"destination\":\"").append(t.getDestination()).append("\",")
                    .append("\"departureDate\":\"").append(t.getDepartureDate()).append("\",")
                    .append("\"arrivalDate\":\"").append(t.getArrivalDate()).append("\",")
                    .append("\"fare\":").append(t.getFare()).append(",")
                    .append("\"busType\":\"").append(t.getBusType()).append("\",")
                    .append("\"availableSeats\":").append(t.getAvailableSeats())
                    .append("}");
                if (i < trips.size() - 1) json.append(",");
            }
            json.append("]}");
            response.getWriter().write(json.toString());
            return;
        }

        request.setAttribute("searchFrom", from);
        request.setAttribute("searchTo", to);
        request.setAttribute("searchDate", date);
        request.setAttribute("searchPassengers", passengers);
        request.setAttribute("trips", trips);
        request.setAttribute("isFallback", isFallback);
        request.setAttribute("fallbackMessage", fallbackMessage);

        request.getRequestDispatcher("/WEB-INF/Pages/Booking.jsp").forward(request, response);
    }
}
