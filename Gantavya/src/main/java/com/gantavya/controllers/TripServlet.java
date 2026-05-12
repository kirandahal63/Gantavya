package com.gantavya.controllers;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.gantavya.dao.TripDao;
import com.gantavya.model.TripModel;
import com.gantavya.dao.BusDao;
import com.gantavya.model.BusModel;
import com.gantavya.dao.RouteDao;
import com.gantavya.model.RouteModel;
import com.gantavya.dao.StaffDao;
import com.gantavya.model.StaffModel;

@WebServlet("/trip")
public class TripServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TripDao tripDao = new TripDao();
    private BusDao busDao = new BusDao();
    private RouteDao routeDao = new RouteDao();
    private StaffDao staffDao = new StaffDao();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String search = request.getParameter("search");
        if (search == null) search = "";

        if ("delete".equals(action)) {
            String id = request.getParameter("id");
            try {
                tripDao.deleteTrip(id);
                response.sendRedirect("trip");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("trip?error=DeleteFailed");
            }
            return;
        }

        if ("edit".equals(action)) {
            String id = request.getParameter("id");
            List<TripModel> allTrips = tripDao.getAllTrips("");
            TripModel editableTrip = allTrips.stream()
                .filter(t -> t.getTripId().equals(id))
                .findFirst()
                .orElse(null);
            request.setAttribute("editableTrip", editableTrip);
        }

        // Fetch Dropdown Data
        List<BusModel> allBuses = busDao.getAllBuses("");
        // Filter only OPERATING buses
        List<BusModel> operatingBuses = allBuses.stream()
            .filter(b -> "OPERATING".equalsIgnoreCase(b.getStatus()))
            .collect(Collectors.toList());
        request.setAttribute("busList", operatingBuses);

        List<RouteModel> allRoutes = routeDao.getAllRoutes("");
        request.setAttribute("routeList", allRoutes);

        List<StaffModel> allStaff = staffDao.getAllStaff();
        request.setAttribute("staffList", allStaff);

        // Fetch Trips for Table
        List<TripModel> tripList = tripDao.getAllTrips(search);
        request.setAttribute("tripList", tripList);
        
        request.setAttribute("pageName", "trips");  

        request.getRequestDispatcher("/WEB-INF/Pages/Trip.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        String tripId = "add".equals(action) ? tripDao.generateNextTripId() : request.getParameter("tripId");
        String departureDate = request.getParameter("departureDate");
        String arrivalDate = request.getParameter("arrivalDate");
        String tripStatus = request.getParameter("tripStatus");
        String fareStr = request.getParameter("fare");
        long fare = (fareStr != null && !fareStr.isEmpty()) ? Long.parseLong(fareStr) : 0;
        String routeId = request.getParameter("routeId");
        String busId = request.getParameter("busId");
        String staffId = request.getParameter("staffId");

        TripModel trip = new TripModel(tripId, departureDate, arrivalDate, tripStatus, fare, routeId, busId, staffId);

        try {
            tripDao.saveOrUpdateTrip(trip, action);
            response.sendRedirect("trip");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("trip?error=SaveFailed");
        }
    }
}
