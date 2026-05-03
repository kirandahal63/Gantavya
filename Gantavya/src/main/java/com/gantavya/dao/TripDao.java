package com.gantavya.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.gantavya.model.TripModel;

public class TripDao {
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

    public String generateNextTripId() {
        String query = "SELECT TripID FROM trip ORDER BY TripID DESC LIMIT 1";
        int lastNumber = 0;

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                String lastId = rs.getString("TripID");
                String numericPart = lastId.replaceAll("[^0-9]", "");
                if (!numericPart.isEmpty()) {
                    lastNumber = Integer.parseInt(numericPart);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return String.format("TRIP%03d", lastNumber + 1);
    }

    public void saveOrUpdateTrip(TripModel trip, String action) throws SQLException {
        String query;
        if ("add".equals(action)) {
            query = "INSERT INTO trip (TripID, DepartureDate, `Arrival Date`, TripStatus, Fare, RouteID, BusID, StaffID) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        } else {
            query = "UPDATE trip SET DepartureDate=?, `Arrival Date`=?, TripStatus=?, Fare=?, RouteID=?, BusID=?, StaffID=? WHERE TripID=?";
        }

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            if ("add".equals(action)) {
                ps.setString(1, trip.getTripId());
                ps.setString(2, trip.getDepartureDate());
                ps.setString(3, trip.getArrivalDate());
                ps.setString(4, trip.getTripStatus());
                ps.setLong(5, trip.getFare());
                ps.setString(6, trip.getRouteId());
                ps.setString(7, trip.getBusId());
                ps.setString(8, trip.getStaffId());
            } else {
                ps.setString(1, trip.getDepartureDate());
                ps.setString(2, trip.getArrivalDate());
                ps.setString(3, trip.getTripStatus());
                ps.setLong(4, trip.getFare());
                ps.setString(5, trip.getRouteId());
                ps.setString(6, trip.getBusId());
                ps.setString(7, trip.getStaffId());
                ps.setString(8, trip.getTripId());
            }
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public List<TripModel> getAllTrips(String search) {
        List<TripModel> trips = new ArrayList<>();
        String query = "SELECT * FROM trip WHERE TripID LIKE ? OR RouteID LIKE ? OR BusID LIKE ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + search + "%");
            ps.setString(3, "%" + search + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                trips.add(new TripModel(
                    rs.getString("TripID"),
                    rs.getString("DepartureDate"),
                    rs.getString("Arrival Date"),
                    rs.getString("TripStatus"),
                    rs.getLong("Fare"),
                    rs.getString("RouteID"),
                    rs.getString("BusID"),
                    rs.getString("StaffID")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return trips;
    }

    public void deleteTrip(String id) throws SQLException {
        String query = "DELETE FROM trip WHERE TripID=?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, id);
            ps.executeUpdate();
        }
    }
    
    public List<TripModel> getUpcomingTrips() {
        List<TripModel> trips = new ArrayList<>();
        // JOINing with route table to get Source/Destination names
        String query = "SELECT t.*, r.Source, r.Destination FROM trip t " +
                       "JOIN route r ON t.RouteID = r.RouteID " +
                       "WHERE t.TripStatus = 'ACTIVE' LIMIT 6";
                       
        try (Connection conn = getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                TripModel trip = new TripModel();
                trip.setTripId(rs.getString("TripID"));
                trip.setDepartureDate(rs.getString("DepartureDate"));
                trip.setArrivalDate(rs.getString("Arrival Date"));
                trip.setFare(rs.getLong("Fare"));
                // Assuming you add these temporary fields to TripModel or use RouteID
                trip.setRouteId(rs.getString("Source") + " to " + rs.getString("Destination")); 
                trip.setBusId(rs.getString("BusID"));
                trips.add(trip);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return trips;
    }
}
