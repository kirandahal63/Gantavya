package com.gantavya.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.UUID;
import com.gantavya.dao.BookingDao;
import com.gantavya.dao.TripDao;
import com.gantavya.dao.PaymentDao;
import com.gantavya.model.BookingModel;
import com.gantavya.model.TripModel;
import com.gantavya.model.PaymentModel;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String tripId = (String) session.getAttribute("pending_tripId");
        
        if (tripId == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        TripDao tripDao = new TripDao();
        TripModel trip = tripDao.getTripById(tripId);
        request.setAttribute("trip", trip);
        
        request.getRequestDispatcher("/WEB-INF/Pages/Payment.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String tripId = (String) session.getAttribute("pending_tripId");
        String passengerId = (String) session.getAttribute("passengerId");
        Long totalAmount = (Long) session.getAttribute("pending_total");
        String paymentMethodStr = (String) session.getAttribute("pending_paymentMethod");
        
        if (tripId == null || passengerId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String seats = (String) session.getAttribute("pending_seats");
        String otherPassengers = (String) session.getAttribute("pending_otherPassengers");
        String luggage = (String) session.getAttribute("pending_luggage");
        
        BookingDao bookingDao = new BookingDao();
        PaymentDao paymentDao = new PaymentDao();
        
        String bookingId = bookingDao.generateNextBookingId();
        String ticketId = "TKT-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        String paymentId = "PAY-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();

        // 1. Create and Save Payment
        String methodName = "Card"; // Default
        if ("khalti".equalsIgnoreCase(paymentMethodStr)) methodName = "Khalti";
        else if ("esewa".equalsIgnoreCase(paymentMethodStr)) methodName = "eSewa";

        PaymentModel payment = new PaymentModel();
        payment.setPaymentId(paymentId);
        payment.setPaymentAmount(totalAmount != null ? totalAmount : 0);
        payment.setPaymentDate(new java.sql.Timestamp(System.currentTimeMillis()));
        payment.setPaymentMethod(methodName);

        // 2. Create Booking
        BookingModel booking = new BookingModel();
        booking.setBookingId(bookingId);
        booking.setBookingDate(new Timestamp(System.currentTimeMillis()));
        booking.setSeatNumber(seats);
        booking.setOtherPassengers(otherPassengers);
        booking.setLuggagePreferences(luggage);
        booking.setTicketId(ticketId);
        booking.setPaymentId(paymentId);
        booking.setTripId(tripId);
        booking.setPassengerId(passengerId);

        try {
            // Save both payment and booking
            paymentDao.savePayment(payment);
            boolean success = bookingDao.saveBooking(booking);
            
            if (success) {
                // Clear session pending data
                session.removeAttribute("pending_tripId");
                session.removeAttribute("pending_seats");
                session.removeAttribute("pending_otherPassengers");
                session.removeAttribute("pending_luggage");
                session.removeAttribute("pending_total");
                session.removeAttribute("pending_paymentMethod");
                
                request.setAttribute("message", "Booking Confirmed Successfully!");
                request.setAttribute("booking", booking);
                request.getRequestDispatcher("/WEB-INF/Pages/Success.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Failed to save booking. Please try again.");
                doGet(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            doGet(request, response);
        }
    }
}
