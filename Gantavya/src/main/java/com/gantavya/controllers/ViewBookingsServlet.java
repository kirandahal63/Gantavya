package com.gantavya.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import com.gantavya.dao.BookingDao;
import com.gantavya.dao.TripDao;
import com.gantavya.model.BookingModel;
import com.gantavya.model.TripModel;

@WebServlet("/viewBookings")
public class ViewBookingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TripDao tripDao = new TripDao();
        BookingDao bookingDao = new BookingDao();

        String tripId = request.getParameter("tripId");
        List<TripModel> allTrips = tripDao.getAllTrips("");
        request.setAttribute("trips", allTrips);
        request.setAttribute("pageName", "viewBookings");

        if (tripId != null && !tripId.isEmpty()) {
            List<BookingModel> bookings = bookingDao.getBookingsByTripId(tripId);
            request.setAttribute("bookings", bookings);
            request.setAttribute("selectedTripId", tripId);
            
            TripModel selectedTrip = tripDao.getTripById(tripId);
            request.setAttribute("selectedTrip", selectedTrip);
            
            // Calculate totals
            long totalRevenue = 0;
            int totalPassengers = 0;
            
            if (bookings != null && selectedTrip != null) {
                for (BookingModel booking : bookings) {
                    if (booking.getSeatNumber() != null) {
                        String[] seats = booking.getSeatNumber().split(",");
                        int passengerCount = seats.length;
                        totalPassengers += passengerCount;
                        totalRevenue += (passengerCount * selectedTrip.getFare());
                    }
                }
            }
            
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("totalPassengers", totalPassengers);
        }

        request.getRequestDispatcher("/WEB-INF/Pages/ViewBookings.jsp").forward(request, response);
    }
}
