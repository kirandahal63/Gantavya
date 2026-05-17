package com.gantavya.controllers;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.gantavya.service.TripService;
import com.gantavya.service.BusService;
import com.gantavya.service.RouteService;
import com.gantavya.service.StaffService;
import com.gantavya.model.TripModel;
import com.gantavya.model.BusModel;
import com.gantavya.model.RouteModel;
import com.gantavya.model.StaffModel;

@WebServlet("/trip")
public class TripServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TripService tripService = new TripService();
    private BusService busService = new BusService();
    private RouteService routeService = new RouteService();
    private StaffService staffService = new StaffService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String search = request.getParameter("search");
        if (search == null) search = "";

        if ("delete".equals(action)) {
            String id = request.getParameter("id");
            try {
                tripService.deleteTrip(id);
                response.sendRedirect("trip");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("trip?error=DeleteFailed");
            }
            return;
        }

        if ("edit".equals(action)) {
            String id = request.getParameter("id");
            List<TripModel> allTrips = tripService.getAllTrips("");
            TripModel editableTrip = allTrips.stream()
                .filter(t -> t.getTripId().equals(id))
                .findFirst()
                .orElse(null);
            request.setAttribute("editableTrip", editableTrip);
        }

        List<BusModel> allBuses = busService.getAllBuses("");
        List<BusModel> operatingBuses = allBuses.stream()
            .filter(b -> "OPERATING".equalsIgnoreCase(b.getStatus()))
            .collect(Collectors.toList());
        request.setAttribute("busList", operatingBuses);

        List<RouteModel> allRoutes = routeService.getAllRoutes("");
        request.setAttribute("routeList", allRoutes);

        // Filter: Only ACTIVE staff members
        List<StaffModel> allStaff = staffService.getAllStaff();
        List<StaffModel> activeStaff = allStaff.stream()
            .filter(s -> "ACTIVE".equalsIgnoreCase(s.getStaffStatus()))
            .collect(Collectors.toList());
        request.setAttribute("staffList", activeStaff);

        // Fetch Trips for Table
        List<TripModel> tripList = tripService.getAllTrips(search);
        request.setAttribute("tripList", tripList);
        
        request.setAttribute("pageName", "trips");  

        request.getRequestDispatcher("/WEB-INF/Pages/Trip.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        String tripId = request.getParameter("tripId");
        String departureDate = request.getParameter("departureDate");
        String arrivalDate = request.getParameter("arrivalDate");
        String tripStatus = request.getParameter("tripStatus");
        if (tripStatus == null || tripStatus.trim().isEmpty()) {
            tripStatus = "SCHEDULED";
        }
        String fareStr = request.getParameter("fare");
        String routeId = request.getParameter("routeId");
        String busId = request.getParameter("busId");
        String staffId = request.getParameter("staffId");

        long fare = 0;
        boolean hasError = false;

        // Fare Validation
        try {
            fare = (fareStr != null && !fareStr.isEmpty()) ? Long.parseLong(fareStr) : 0L;
            if (!com.gantavya.util.Validation.isPositive(fare)) {
                hasError = true;
                request.setAttribute("fareError", "Please enter a valid fare.");
            }
        } catch (NumberFormatException e) {
            hasError = true;
            request.setAttribute("fareError", "Please enter a valid fare.");
        }

        // Date Validation: Should not be in the past
        try {
            if (departureDate != null && !departureDate.isEmpty()) {
                java.time.LocalDateTime depTime = java.time.LocalDateTime.parse(departureDate);
                if (depTime.isBefore(java.time.LocalDateTime.now())) {
                    hasError = true;
                    request.setAttribute("dateError", "Please choose a valid upcoming date.");
                }
            }
        } catch (Exception e) {
            // Handle parsing error if the browser sends a weird format
            System.err.println("Date parsing error: " + e.getMessage());
        }

        TripModel trip = new TripModel(tripId, departureDate, arrivalDate, tripStatus, fare, routeId, busId, staffId);

        if (hasError) {
            request.setAttribute("errorTrip", trip);
            request.setAttribute("tripList", tripService.getAllTrips(""));
            request.setAttribute("busList", busService.getAllBuses(""));
            request.setAttribute("routeList", routeService.getAllRoutes(""));
            
            // Re-filter active staff for the forward
            List<StaffModel> allStaff = staffService.getAllStaff();
            List<StaffModel> activeStaff = allStaff.stream()
                .filter(s -> "ACTIVE".equalsIgnoreCase(s.getStaffStatus()))
                .collect(Collectors.toList());
            request.setAttribute("staffList", activeStaff);
            
            request.setAttribute("pageName", "trips");
            
            if ("update".equals(action)) {
                request.setAttribute("editableTrip", trip);
            }
            
            request.getRequestDispatcher("/WEB-INF/Pages/Trip.jsp").forward(request, response);
            return;
        }

        try {
            if ("add".equals(action)) {
                tripService.addTrip(trip);
                response.sendRedirect("trip?message=TripScheduled");
                return;
            } else if ("update".equals(action)) {
                tripService.updateTrip(trip);
                response.sendRedirect("trip?message=TripUpdated");
                return;
            }
            response.sendRedirect("trip");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("saveError", "Database error: " + e.getMessage());
            
            request.setAttribute("errorTrip", trip);
            request.setAttribute("tripList", tripService.getAllTrips(""));
            request.setAttribute("busList", busService.getAllBuses(""));
            request.setAttribute("routeList", routeService.getAllRoutes(""));
            
            List<com.gantavya.model.StaffModel> allStaff = staffService.getAllStaff();
            List<com.gantavya.model.StaffModel> activeStaff = allStaff.stream()
                .filter(s -> "ACTIVE".equalsIgnoreCase(s.getStaffStatus()))
                .collect(java.util.stream.Collectors.toList());
            request.setAttribute("staffList", activeStaff);
            
            request.setAttribute("pageName", "trips");
            if ("update".equals(action)) request.setAttribute("editableTrip", trip);
            
            request.getRequestDispatcher("/WEB-INF/Pages/Trip.jsp").forward(request, response);
        }
    }
}
