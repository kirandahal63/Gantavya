package com.gantavya.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import com.gantavya.service.BookingService;
import com.gantavya.service.TripService;
import com.gantavya.model.BookingModel;
import com.gantavya.model.TripModel;

@WebServlet("/viewBookings")
public class ViewBookingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookingService bookingService = new BookingService();
    private TripService tripService = new TripService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tripId = request.getParameter("tripId");
        String searchTrip = request.getParameter("searchTrip");
        String sortBy = request.getParameter("sort");
        
        if (searchTrip != null && !searchTrip.trim().isEmpty()) {
            tripId = searchTrip.trim();
        }
        
        List<TripModel> allTrips = tripService.getAllTrips("");
        request.setAttribute("trips", allTrips);
        request.setAttribute("pageName", "viewBookings");

        if (tripId != null && !tripId.isEmpty()) {
            List<BookingModel> bookings = bookingService.getBookingsByTripId(tripId);
            TripModel selectedTrip = tripService.getTripById(tripId);
            request.setAttribute("selectedTrip", selectedTrip);
            request.setAttribute("selectedTripId", tripId);

            if (bookings != null && selectedTrip != null) {
                long totalRevenue = 0;
                int totalPassengers = 0;
                
                for (BookingModel booking : bookings) {
                    if (booking.getSeatNumber() != null) {
                        String[] seats = booking.getSeatNumber().split(",");
                        int passengerCount = seats.length;
                        totalPassengers += passengerCount;
                        totalRevenue += (passengerCount * selectedTrip.getFare());
                    }
                }
                
                if (sortBy != null) {
                    if ("fare".equals(sortBy)) {
                        bookingService.sortByFare(bookings, selectedTrip.getFare());
                    } else if ("date".equals(sortBy)) {
                        bookingService.sortByDate(bookings);
                    }
                    request.setAttribute("currentSort", sortBy);
                }

                request.setAttribute("bookings", bookings);
                request.setAttribute("totalRevenue", totalRevenue);
                request.setAttribute("totalPassengers", totalPassengers);
            }
        }

        request.getRequestDispatcher("/WEB-INF/Pages/ViewBookings.jsp").forward(request, response);
    }
}


