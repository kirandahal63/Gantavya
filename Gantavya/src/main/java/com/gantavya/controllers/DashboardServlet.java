package com.gantavya.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import com.gantavya.dao.DashboardDao;
import com.gantavya.dao.TripDao;
import com.gantavya.model.TripModel;

/**
 * Servlet implementation class DashboardServlet
 */
@WebServlet("/admin")
public class DashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	@Override
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        DashboardDao dashboardDao = new DashboardDao();
        
        // Fetch real data
        int totalNewBookings = dashboardDao.getNewBookingsToday();
        int totalBuses = dashboardDao.getTotalBuses();
        int totalTrips = dashboardDao.getTotalTrips();
        int totalRoutes = dashboardDao.getTotalRoutes();
        int totalPassengers = dashboardDao.getTotalPassengers();
        int totalBookings = dashboardDao.getTotalBookings();
        long totalRevenue = dashboardDao.getTotalRevenue();
        int totalStaff = dashboardDao.getTotalStaff();

        // Formatting for display
        java.text.NumberFormat formatter = java.text.NumberFormat.getInstance();
        
        request.setAttribute("totalNewBookings", totalNewBookings);
        request.setAttribute("totalBuses",       totalBuses);
        request.setAttribute("totalTrips",       formatter.format(totalTrips));
        request.setAttribute("totalRoutes",      totalRoutes);
        request.setAttribute("activeRoutes",     totalRoutes); 
        request.setAttribute("totalPassengers",  formatter.format(totalPassengers));
        request.setAttribute("totalBookings",    formatter.format(totalBookings));
        request.setAttribute("totalRevenueFormatted", formatter.format(totalRevenue));
        request.setAttribute("totalStaff",       totalStaff);

        TripDao tripDao = new TripDao();
        String selectedDate = request.getParameter("selectedDate");
        List<TripModel> upcomingTrips = tripDao.getUpcomingTrips(selectedDate);
        request.setAttribute("upcomingTrips", upcomingTrips);
        request.setAttribute("selectedDate", selectedDate);
        request.setAttribute("pageName", "dashboard");
        request.getRequestDispatcher("/WEB-INF/Pages/Dashboard.jsp").forward(request, response);
    }
}


