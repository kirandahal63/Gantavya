package com.gantavya.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.gantavya.dao.BusDao;
import com.gantavya.model.BusModel;

@WebServlet("/bus")
public class BusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BusDao busDao;

    public void init() {
        busDao = new BusDao();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String search = request.getParameter("search");
        if (search == null) search = "";

        try {
            if ("edit".equals(action)) {
                String id = request.getParameter("id");
                List<BusModel> results = busDao.getAllBuses(id);
                if (!results.isEmpty()) {
                    request.setAttribute("editableBus", results.get(0));
                }
            } else if ("delete".equals(action)) {
                busDao.deleteBus(request.getParameter("id"));
                response.sendRedirect("bus");
                return;
            }

            request.setAttribute("busList", busDao.getAllBuses(search));
            request.getRequestDispatcher("/WEB-INF/Pages/Bus.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String busId = request.getParameter("busId"); // Used for updates
        
        String busNo = request.getParameter("busNumber");
        String busType = request.getParameter("busType");
        String status = request.getParameter("status");
        int capacity = Integer.parseInt(request.getParameter("capacity"));

        try {
            if ("add".equals(action)) {
                // IMPORTANT: Generate the new BSIDxxx here
                String newId = busDao.generateNextBusId();
                BusModel newBus = new BusModel(newId, busNo, busType, capacity, status);
                busDao.saveOrUpdateBus(newBus, "add");
            } else if ("update".equals(action)) {
                BusModel updatedBus = new BusModel(busId, busNo, busType, capacity, status);
                busDao.saveOrUpdateBus(updatedBus, "update");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("bus");
    }
}