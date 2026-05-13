package com.gantavya.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.gantavya.service.BookingService;
import com.gantavya.service.TripService;
import com.gantavya.model.TripModel;

/**
 * Servlet implementation class BookingServlet
 */
@WebServlet("/booking")
public class BookingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private TripService tripService = new TripService();
    private BookingService bookingService = new BookingService();

    public BookingServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String tripId = request.getParameter("tripId");
		if (tripId == null || tripId.isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/home");
			return;
		}

		TripModel trip = tripService.getTripById(tripId);
		
		if (trip == null) {
			response.sendRedirect(request.getContextPath() + "/home");
			return;
		}

		request.setAttribute("trip", trip);
		
		java.util.List<String> bookedSeats = bookingService.getBookedSeatsByTripId(tripId);
		request.setAttribute("bookedSeats", bookedSeats);
		
		request.getRequestDispatcher("/WEB-INF/Pages/Booking.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String tripId = request.getParameter("tripId");
		String selectedSeats = request.getParameter("selectedSeats");
		String luggageQty = request.getParameter("extraLuggage");
		String paymentMethod = request.getParameter("paymentMethod");
		
		if (tripId == null || selectedSeats == null || selectedSeats.isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/booking?tripId=" + tripId);
			return;
		}
		
		String[] seatsArray = selectedSeats.split(",");
		if (seatsArray.length > 5) {
			response.sendRedirect(request.getContextPath() + "/booking?tripId=" + tripId + "&error=limit_exceeded");
			return;
		}
		
		// Server-side seat validation
		java.util.List<String> alreadyBooked = bookingService.getBookedSeatsByTripId(tripId);
		for (String seat : seatsArray) {
			if (alreadyBooked.contains(seat.trim())) {
				response.sendRedirect(request.getContextPath() + "/booking?tripId=" + tripId + "&error=seat_taken");
				return;
			}
		}
		StringBuilder otherPassengers = new StringBuilder();
		for (int i = 1; i < seatsArray.length; i++) {
			String name = request.getParameter("passengerName_" + i);
			if (name != null && !name.isEmpty()) {
				if (otherPassengers.length() > 0) otherPassengers.append("; ");
				otherPassengers.append(name).append(" (Seat ").append(seatsArray[i]).append(")");
			}
		}

		int luggageCount = 0;
		try {
			if (luggageQty != null && !luggageQty.isEmpty()) {
				luggageCount = Integer.parseInt(luggageQty);
			}
		} catch (NumberFormatException e) {
			luggageCount = 0;
		}

		// Store data in session to be used in PaymentServlet
		request.getSession().setAttribute("pending_tripId", tripId);
		request.getSession().setAttribute("pending_seats", selectedSeats);
		request.getSession().setAttribute("pending_otherPassengers", otherPassengers.toString());
		request.getSession().setAttribute("pending_luggage", String.valueOf(luggageCount));
		request.getSession().setAttribute("pending_paymentMethod", paymentMethod);
		
		// Also calculate total price and store it
		TripModel trip = tripService.getTripById(tripId);
		long total = (seatsArray.length * trip.getFare()) + (luggageCount * 500) + 50;
		request.getSession().setAttribute("pending_total", total);

		response.sendRedirect(request.getContextPath() + "/payment");
	}

}

