package com.gantavya.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import com.gantavya.dao.BookingDao;
import com.gantavya.model.BookingModel;

@WebServlet("/my-bookings")
public class MyBookingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookingDao bookingDao = new BookingDao();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String passengerId = (String) session.getAttribute("passengerId");

        if (passengerId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<BookingModel> bookings = bookingDao.getBookingsByPassengerId(passengerId);
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/WEB-INF/Pages/MyBookings.jsp").forward(request, response);
    }
}
