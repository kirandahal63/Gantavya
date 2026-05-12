package com.gantavya.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.gantavya.service.BusService;
import com.gantavya.model.BusModel;

@WebServlet("/bus")
public class BusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BusService busService;

    public void init() {
        busService = new BusService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String search = request.getParameter("search");
        if (search == null) search = "";

        try {
            if ("edit".equals(action)) {
                String id = request.getParameter("id");
                List<BusModel> results = busService.getAllBuses(id);
                if (!results.isEmpty()) {
                    request.setAttribute("editableBus", results.get(0));
                }
            } else if ("delete".equals(action)) {
                busService.deleteBus(request.getParameter("id"));
                response.sendRedirect("bus");
                return;
            }

            request.setAttribute("busList", busService.getAllBuses(search));
            request.setAttribute("pageName", "buses");
            request.getRequestDispatcher("/WEB-INF/Pages/Bus.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String busId = request.getParameter("busId"); 
        String busNo = request.getParameter("busNumber");
        String busType = request.getParameter("busType");
        String status = request.getParameter("status");
        String capacityStr = request.getParameter("capacity");
        
        int capacity = 0;
        boolean hasError = false;
        if (!com.gantavya.util.Validation.isValidBusNumber(busNo)) {
            hasError = true;
            request.setAttribute("busNumberError", "Enter Bus Number");
        }
        try {
            capacity = (capacityStr != null && !capacityStr.isEmpty()) ? Integer.parseInt(capacityStr) : 0;
        } catch (NumberFormatException e) {
            hasError = true;
            request.setAttribute("capacityError", "Please enter a valid seat number.");
        }

        BusModel bus = new BusModel(busId, busNo, busType, capacity, status);

        if (hasError) {
            request.setAttribute("errorBus", bus);
            request.setAttribute("busList", busService.getAllBuses(""));
            request.setAttribute("pageName", "buses");
            
            if ("update".equals(action)) {
                request.setAttribute("editableBus", bus);
            }
            
            request.getRequestDispatcher("/WEB-INF/Pages/Bus.jsp").forward(request, response);
            return;
        }

        try {
            if ("add".equals(action)) {
                busService.addBus(bus);
            } else if ("update".equals(action)) {
                busService.updateBus(bus);
            }
            response.sendRedirect("bus");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("bus?error=SaveFailed");
        }
    }
}
