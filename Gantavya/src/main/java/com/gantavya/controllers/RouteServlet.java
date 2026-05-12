package com.gantavya.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.gantavya.dao.RouteDao;
import com.gantavya.model.RouteModel;

@WebServlet("/route")
public class RouteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private RouteDao routeDao;

    public void init() {
        routeDao = new RouteDao();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String search = request.getParameter("search");
        if (search == null) search = "";

        try {
            if ("edit".equals(action)) {
                String id = request.getParameter("id");
                List<RouteModel> results = routeDao.getAllRoutes(id);
                if (!results.isEmpty()) {
                    request.setAttribute("editableRoute", results.get(0));
                }
            } else if ("delete".equals(action)) {
                routeDao.deleteRoute(request.getParameter("id"));
                response.sendRedirect("route");
                return;
            }

            request.setAttribute("routeList", routeDao.getAllRoutes(search));
            request.setAttribute("pageName", "routes");
            request.getRequestDispatcher("/WEB-INF/Pages/Route.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String routeId = request.getParameter("routeId");
        String routeName = request.getParameter("routeName");
        String origin = request.getParameter("origin");
        String destination = request.getParameter("destination");
        long distance = Long.parseLong(request.getParameter("distance"));

        try {
            if ("add".equals(action)) {
                String newId = routeDao.generateNextRouteId();
                RouteModel newRoute = new RouteModel(newId, routeName, distance, origin, destination);
                routeDao.saveOrUpdateRoute(newRoute, "add");
            } else if ("update".equals(action)) {
                RouteModel updatedRoute = new RouteModel(routeId, routeName, distance, origin, destination);
                routeDao.saveOrUpdateRoute(updatedRoute, "update");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("route");
    }
}