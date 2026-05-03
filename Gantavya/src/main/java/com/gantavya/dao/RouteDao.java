package com.gantavya.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.gantavya.model.RouteModel;

public class RouteDao {
    private String url = "jdbc:mysql://localhost:3306/gantavya";
    private String username = "root";
    private String password = ""; 

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return connection;
    }

    public String generateNextRouteId() {
        String query = "SELECT RouteID FROM route ORDER BY RouteID DESC LIMIT 1";
        int lastNumber = 0;
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                String lastId = rs.getString("RouteID");
                String numericPart = lastId.replaceAll("[^0-9]", "");
                if (!numericPart.isEmpty()) {
                    lastNumber = Integer.parseInt(numericPart);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return String.format("REID%03d", lastNumber + 1);
    }

    public void saveOrUpdateRoute(RouteModel route, String action) throws SQLException {
        String query = "add".equals(action) 
            ? "INSERT INTO route (RouteID, RouteName, RouteDistance, RouteOrigin, RouteDestination) VALUES (?, ?, ?, ?, ?)"
            : "UPDATE route SET RouteName=?, RouteDistance=?, RouteOrigin=?, RouteDestination=? WHERE RouteID=?";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            if ("add".equals(action)) {
                ps.setString(1, route.getRouteId());
                ps.setString(2, route.getRouteName());
                ps.setLong(3, route.getDistance());
                ps.setString(4, route.getOrigin());
                ps.setString(5, route.getDestination());
            } else {
                ps.setString(1, route.getRouteName());
                ps.setLong(2, route.getDistance());
                ps.setString(3, route.getOrigin());
                ps.setString(4, route.getDestination());
                ps.setString(5, route.getRouteId());
            }
            ps.executeUpdate();
        }
    }

    public List<RouteModel> getAllRoutes(String search) {
        List<RouteModel> routesList = new ArrayList<>();
        // FIXED: Changed 'routes' to 'route' to match your database
        String query = "SELECT * FROM route WHERE RouteName LIKE ? OR RouteID = ?"; 
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, "%" + search + "%");
            ps.setString(2, search);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                routesList.add(new RouteModel(
                    rs.getString("RouteID"),
                    rs.getString("RouteName"),
                    rs.getLong("RouteDistance"),
                    rs.getString("RouteOrigin"),
                    rs.getString("RouteDestination")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return routesList;
    }

    public void deleteRoute(String id) throws SQLException {
        String query = "DELETE FROM route WHERE RouteID=?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, id);
            ps.executeUpdate();
        }
    }
}