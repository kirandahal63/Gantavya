package com.gantavya.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.gantavya.dao.TripDao;

/**
 * Servlet implementation class BookingServlet
 */
@WebServlet("/booking")
public class BookingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookingServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String tripId = request.getParameter("tripId");
		if (tripId == null || tripId.isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/home");
			return;
		}

		TripDao tripDao = new TripDao();
		com.gantavya.model.TripModel trip = tripDao.getTripById(tripId);
		
		if (trip == null) {
			response.sendRedirect(request.getContextPath() + "/home");
			return;
		}

		request.setAttribute("trip", trip);
		
		request.getRequestDispatcher("/WEB-INF/Pages/Booking.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
