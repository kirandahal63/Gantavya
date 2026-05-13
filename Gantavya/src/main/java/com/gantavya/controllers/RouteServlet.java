package com.gantavya.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.gantavya.service.RouteService;
import com.gantavya.model.RouteModel;

@WebServlet("/route")
public class RouteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private RouteService routeService;

    public void init() {
        routeService = new RouteService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String search = request.getParameter("search");
        if (search == null) search = "";

        try {
            if ("edit".equals(action)) {
                String id = request.getParameter("id");
                List<RouteModel> results = routeService.getAllRoutes(id);
                if (!results.isEmpty()) {
                    request.setAttribute("editableRoute", results.get(0));
                }
            } else if ("delete".equals(action)) {
                routeService.deleteRoute(request.getParameter("id"));
                response.sendRedirect("route");
                return;
            }

            request.setAttribute("routeList", routeService.getAllRoutes(search));
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
        String distanceStr = request.getParameter("distance");
        
        long distance = 0;
        boolean hasError = false;

        try {
            distance = (distanceStr != null && !distanceStr.isEmpty()) ? Long.parseLong(distanceStr) : 0L;
        } catch (NumberFormatException e) {
            hasError = true;
            request.setAttribute("distanceError", "Invalid Format");
        }

        RouteModel route = new RouteModel(routeId, routeName, distance, origin, destination);

        if (hasError) {
            request.setAttribute("errorRoute", route);
            request.setAttribute("routeList", routeService.getAllRoutes(""));
            request.setAttribute("pageName", "routes");
            
            if ("update".equals(action)) {
                request.setAttribute("editableRoute", route);
            }
            
            request.getRequestDispatcher("/WEB-INF/Pages/Route.jsp").forward(request, response);
            return;
        }

        try {
            if ("add".equals(action)) {
                routeService.addRoute(route);
                response.sendRedirect("route?message=RouteAdded");
                return;
            } else if ("update".equals(action)) {
                routeService.updateRoute(route);
                response.sendRedirect("route?message=RouteUpdated");
                return;
            }
            response.sendRedirect("route");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("route?error=SaveFailed");
        }
    }
}
