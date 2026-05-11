package com.gantavya.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import com.gantavya.dao.BookingDao;
import com.gantavya.dao.TripDao;
import com.gantavya.model.BookingModel;
import com.gantavya.model.TripModel;
import java.util.List;

@WebServlet("/success")
public class SuccessServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookingDao bookingDao = new BookingDao();
    private TripDao tripDao = new TripDao();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookingId = request.getParameter("bookingId");
        
        BookingModel booking = null;
        if (bookingId != null && !bookingId.isEmpty()) {
            // Find specific booking
            HttpSession session = request.getSession();
            String passengerId = (String) session.getAttribute("passengerId");
            if (passengerId == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            
            List<BookingModel> bookings = bookingDao.getBookingsByPassengerId(passengerId);
            for (BookingModel b : bookings) {
                if (b.getBookingId().equals(bookingId)) {
                    booking = b;
                    break;
                }
            }
        } else {
            // Check if we just came from Payment (booking object should be in request attribute)
            booking = (BookingModel) request.getAttribute("booking");
        }

        if (booking == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // Ensure trip details are populated
        if (booking.getTrip() == null) {
            TripModel trip = tripDao.getTripById(booking.getTripId());
            booking.setTrip(trip);
        }

        request.setAttribute("booking", booking);
        request.getRequestDispatcher("/WEB-INF/Pages/Success.jsp").forward(request, response);
    }
}
