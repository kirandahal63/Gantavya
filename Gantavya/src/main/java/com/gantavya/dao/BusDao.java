package com.gantavya.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.gantavya.model.BusModel;

public class BusDao {
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

    
    public String generateNextBusId() {
        String query = "SELECT BusID FROM bus WHERE BusID LIKE 'BSID%' ORDER BY BusID DESC LIMIT 1";
        int lastNumber = 0;

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                String lastId = rs.getString("BusID");
                // Regex removes all non-numeric characters to isolate the number
                String numericPart = lastId.replaceAll("[^0-9]", "");
                if (!numericPart.isEmpty()) {
                    lastNumber = Integer.parseInt(numericPart);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // Returns BSID padded to 3 digits (001, 002, etc.)
        return String.format("BSID%03d", lastNumber + 1);
    }

    public void saveOrUpdateBus(BusModel bus, String action) throws SQLException {
        String query;
        if ("add".equals(action)) {
            query = "INSERT INTO bus (BusID, BusNo, BusType, Capacity, Availability) VALUES (?, ?, ?, ?, ?)";
        } else {
            query = "UPDATE bus SET BusNo=?, BusType=?, Capacity=?, Availability=? WHERE BusID=?";
        }

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            if ("add".equals(action)) {
                ps.setString(1, bus.getBusId());
                ps.setString(2, bus.getBusNumber());
                ps.setString(3, bus.getBusType());
                ps.setInt(4, bus.getCapacity());
                ps.setString(5, bus.getStatus());
            } else {
                ps.setString(1, bus.getBusNumber());
                ps.setString(2, bus.getBusType());
                ps.setInt(3, bus.getCapacity());
                ps.setString(4, bus.getStatus());
                ps.setString(5, bus.getBusId());
            }
            
            int result = ps.executeUpdate();
            System.out.println("Rows affected: " + result); // Look for this in Console
        } catch (SQLException e) {
        	System.err.println("SQL Error State: " + e.getSQLState());
            System.err.println("Error Message: " + e.getMessage());
            throw e; // Re-throw so the Servlet can catch it too
        }
    }

    public List<BusModel> getAllBuses(String search) {
        List<BusModel> buses = new ArrayList<>();
        // Search matches against Number or ID
        String query = "SELECT * FROM bus WHERE BusNo LIKE ? OR BusID = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, "%" + search + "%");
            ps.setString(2, search);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                buses.add(new BusModel(
                    rs.getString("BusID"),
                    rs.getString("BusNo"),
                    rs.getString("BusType"),
                    rs.getInt("Capacity"),
                    rs.getString("Availability") // Result set mapping
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return buses;
    }

    public void deleteBus(String id) throws SQLException {
        String query = "DELETE FROM bus WHERE BusID=?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, id);
            ps.executeUpdate();
        }
    }
}