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
        // Change r.Source to r.RouteOrigin and r.Destination to r.RouteDestination
        String query = "SELECT t.*, r.RouteOrigin, r.RouteDestination, b.Capacity, " +
                "(b.Capacity - (SELECT COUNT(*) FROM booking bk WHERE bk.TripID = t.TripID AND bk.BookingStatus = 'CONFIRMED')) as AvailableSeats " +
                "FROM trip t " +
                "JOIN route r ON t.RouteID = r.RouteID " +
                "JOIN bus b ON t.BusID = b.BusID " +
                "WHERE t.TripStatus IN ('ACTIVE', 'SCHEDULED') LIMIT 6";
                       
        try (Connection conn = getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                TripModel trip = new TripModel();
                trip.setTripId(rs.getString("TripID"));
                trip.setDepartureDate(rs.getString("DepartureDate"));
                trip.setArrivalDate(rs.getString("Arrival Date"));
                trip.setFare(rs.getLong("Fare"));
                
                // IMPORTANT: Match these to the new names in the query above
                String origin = rs.getString("RouteOrigin");
                String destination = rs.getString("RouteDestination");
                
                trip.setSource(origin); 
                trip.setDestination(destination);
                trip.setAvailableSeats(rs.getInt("AvailableSeats"));
                
                trips.add(trip);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return trips;
    }
    
    private String expandLocationOnly(String loc) {
        if (loc == null || loc.trim().isEmpty()) return "";
        String l = loc.toLowerCase().trim();
        if (l.equals("ktm")) return "Kathmandu";
        if (l.equals("pkr")) return "Pokhara";
        if (l.equals("bwt")) return "Butwal";
        if (l.equals("brt")) return "Biratnagar";
        if (l.equals("chitwan")) return "Chitwan";
        return loc;
    }

    public List<TripModel> searchTrips(String from, String to, String date) {
        return searchTrips(from, to, date, 1);
    }

    public List<TripModel> searchTrips(String from, String to, String date, int passengers) {
        List<TripModel> trips = new ArrayList<>();
        String query = "SELECT t.*, r.RouteOrigin, r.RouteDestination, b.BusType, COALESCE(b.Capacity, 0) as Capacity, " +
                "(COALESCE(b.Capacity, 0) - (SELECT COUNT(*) FROM booking bk WHERE bk.TripID = t.TripID AND bk.BookingStatus = 'CONFIRMED')) as AvailableSeats " +
                "FROM trip t " +
                "JOIN route r ON t.RouteID = r.RouteID " +
                "JOIN bus b ON t.BusID = b.BusID " +
                "WHERE (r.RouteOrigin LIKE ? OR r.RouteOrigin LIKE ?) " +
                "AND (r.RouteDestination LIKE ? OR r.RouteDestination LIKE ?) " +
                "HAVING AvailableSeats >= ?";

        try (Connection conn = getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            String fromExpanded = expandLocationOnly(from);
            String toExpanded = expandLocationOnly(to);
            int pCount = (passengers < 1) ? 1 : passengers;
            
            ps.setString(1, "%" + from + "%");
            ps.setString(2, "%" + fromExpanded + "%");
            ps.setString(3, "%" + to + "%");
            ps.setString(4, "%" + toExpanded + "%");
            ps.setInt(5, pCount);
            
            System.out.println("Executing SQL Search for Route: From=" + from + ", To=" + to + ", Seeking Date=" + date);
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                String dbDate = rs.getString("DepartureDate");
                System.out.println("DEBUG: DB has trip on: " + dbDate);
                
                // If date is provided, filter in Java
                if (date != null && !date.isEmpty()) {
                    if (!dbDate.contains(date)) {
                        String altDate = date; // fallback to DD-MM-YYYY check
                        String[] p = date.split("-");
                        if (p.length == 3) altDate = p[2] + "-" + p[1] + "-" + p[0];
                        
                        if (!dbDate.contains(altDate)) {
                            System.out.println("DEBUG: Date mismatch (DB:" + dbDate + " vs Search:" + date + ")");
                            continue; 
                        }
                    }
                }
                
                TripModel trip = new TripModel();
                trip.setTripId(rs.getString("TripID"));
                trip.setDepartureDate(dbDate);
                trip.setArrivalDate(rs.getString("Arrival Date"));
                trip.setFare(rs.getLong("Fare"));
                trip.setSource(rs.getString("RouteOrigin"));
                trip.setDestination(rs.getString("RouteDestination"));
                trip.setBusType(rs.getString("BusType"));
                trip.setAvailableSeats(rs.getInt("AvailableSeats"));
                trips.add(trip);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return trips;
    }
}
