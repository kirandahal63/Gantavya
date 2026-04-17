package com.gantavya.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		
        request.setAttribute("totalNewBookings", 150);
        request.setAttribute("totalBuses",       45);
        request.setAttribute("totalTrips",       "1,230");
        request.setAttribute("totalRoutes",      18);
        request.setAttribute("activeRoutes",     18);
        request.setAttribute("totalPassengers",  "78,450");
        request.setAttribute("totalBookings",    "5,600");
        request.setAttribute("totalRevenue",     "$345,000");
        request.setAttribute("totalStops",       18);
        request.getRequestDispatcher("/WEB-INF/Pages/Dashboard.jsp").forward(request, response);
     List<Map<String, Object>> routeConditions = new ArrayList<>();

     // Add Route 1
     Map<String, Object> route1 = new HashMap<>();
     route1.put("routeName", "Route 2");
     route1.put("location", "KTM-PKR");
     route1.put("status", "Open");
     route1.put("tasks", 4);
     route1.put("progress", 65);
     routeConditions.add(route1);

     // Add Route 2
     Map<String, Object> route2 = new HashMap<>();
     route2.put("routeName", "James Wilson");
     route2.put("location", "2h 15m · Tasks completed");
     route2.put("status", "Closed");
     route2.put("tasks", 3);
     route2.put("progress", 0);
     routeConditions.add(route2);

     request.setAttribute("routeConditions", routeConditions);
    }

}
