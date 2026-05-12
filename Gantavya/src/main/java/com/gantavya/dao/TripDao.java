package com.gantavya.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.gantavya.config.DBConnection;
import com.gantavya.model.TripModel;

public class TripDao {

    protected Connection getConnection() throws SQLException {
        return DBConnection.getConnection();
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
        String query = "SELECT t.*, r.RouteOrigin, r.RouteDestination FROM trip t " +
                       "LEFT JOIN route r ON t.RouteID = r.RouteID " +
                       "WHERE t.TripID LIKE ? OR t.RouteID LIKE ? OR t.BusID LIKE ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + search + "%");
            ps.setString(3, "%" + search + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                TripModel trip = new TripModel(
                    rs.getString("TripID"),
                    rs.getString("DepartureDate"),
                    rs.getString("Arrival Date"),
                    rs.getString("TripStatus"),
                    rs.getLong("Fare"),
                    rs.getString("RouteID"),
                    rs.getString("BusID"),
                    rs.getString("StaffID")
                );
                trip.setSource(rs.getString("RouteOrigin"));
                trip.setDestination(rs.getString("RouteDestination"));
                trips.add(trip);
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
    
    public TripModel getTripById(String tripId) {
        String query = "SELECT t.*, r.RouteOrigin, r.RouteDestination, b.BusType, b.Capacity " +
                "FROM trip t " +
                "LEFT JOIN route r ON TRIM(t.RouteID) = TRIM(r.RouteID) " +
                "LEFT JOIN bus b ON TRIM(t.BusID) = TRIM(b.BusID) " +
                "WHERE t.TripID = ?";
        try (Connection conn = getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, tripId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                TripModel trip = new TripModel();
                trip.setTripId(rs.getString("TripID"));
                trip.setDepartureDate(rs.getString("DepartureDate"));
                trip.setArrivalDate(rs.getString("Arrival Date"));
                trip.setFare(rs.getLong("Fare"));
                trip.setSource(rs.getString("RouteOrigin"));
                trip.setDestination(rs.getString("RouteDestination"));
                trip.setBusType(rs.getString("BusType"));
                int cap = rs.getInt("Capacity");
                trip.setCapacity(cap);
                trip.setAvailableSeats(cap); 
                return trip;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<TripModel> getUpcomingTrips() {
        return getUpcomingTrips(null);
    }

    public List<TripModel> getUpcomingTrips(String selectedDate) {
        List<TripModel> trips = new ArrayList<>();
        String query = "SELECT t.*, r.RouteOrigin, r.RouteDestination, b.Capacity " +
                "FROM trip t " +
                "LEFT JOIN route r ON TRIM(t.RouteID) = TRIM(r.RouteID) " +
                "LEFT JOIN bus b ON TRIM(t.BusID) = TRIM(b.BusID) " +
                (selectedDate != null ? "WHERE t.DepartureDate LIKE ? " : "") +
                "ORDER BY t.DepartureDate ASC LIMIT 6";
                       
        try (Connection conn = getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            if (selectedDate != null) {
                ps.setString(1, "%" + selectedDate + "%");
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                TripModel trip = new TripModel();
                trip.setTripId(rs.getString("TripID"));
                trip.setDepartureDate(rs.getString("DepartureDate"));
                trip.setArrivalDate(rs.getString("Arrival Date"));
                trip.setFare(rs.getLong("Fare"));
                
                String origin = rs.getString("RouteOrigin");
                String destination = rs.getString("RouteDestination");
                trip.setSource(origin != null ? origin : "Unknown (" + rs.getString("RouteID") + ")"); 
                trip.setDestination(destination != null ? destination : "Unknown");
                
                int cap = rs.getInt("Capacity");
                trip.setAvailableSeats(cap > 0 ? cap : 0);
                
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
        String query = "SELECT t.*, r.RouteOrigin, r.RouteDestination, b.BusType, b.Capacity " +
                "FROM trip t " +
                "LEFT JOIN route r ON TRIM(t.RouteID) = TRIM(r.RouteID) " +
                "LEFT JOIN bus b ON TRIM(t.BusID) = TRIM(b.BusID) " +
                "WHERE (r.RouteOrigin LIKE ? OR r.RouteOrigin LIKE ? OR ? = '') " +
                "AND (r.RouteDestination LIKE ? OR r.RouteDestination LIKE ? OR ? = '')";

        try (Connection conn = getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            String fromExpanded = expandLocationOnly(from);
            String toExpanded = expandLocationOnly(to);
            
            ps.setString(1, "%" + (from != null ? from : "") + "%");
            ps.setString(2, "%" + fromExpanded + "%");
            ps.setString(3, from != null ? from : "");
            ps.setString(4, "%" + (to != null ? to : "") + "%");
            ps.setString(5, "%" + toExpanded + "%");
            ps.setString(6, to != null ? to : "");
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                String dbDate = rs.getString("DepartureDate");
                
                if (date != null && !date.isEmpty()) {
                    if (!dbDate.contains(date)) {
                        String altDate = date; 
                        String[] p = date.split("-");
                        if (p.length == 3) altDate = p[2] + "-" + p[1] + "-" + p[0];
                        if (!dbDate.contains(altDate)) continue; 
                    }
                }
                
                int cap = rs.getInt("Capacity");
                if (cap > 0 && cap < passengers) continue; 

                TripModel trip = new TripModel();
                trip.setTripId(rs.getString("TripID"));
                trip.setDepartureDate(dbDate);
                trip.setArrivalDate(rs.getString("Arrival Date"));
                trip.setFare(rs.getLong("Fare"));
                trip.setSource(rs.getString("RouteOrigin") != null ? rs.getString("RouteOrigin") : "Unknown");
                trip.setDestination(rs.getString("RouteDestination") != null ? rs.getString("RouteDestination") : "Unknown");
                trip.setBusType(rs.getString("BusType") != null ? rs.getString("BusType") : "Standard");
                trip.setAvailableSeats(cap > 0 ? cap : 0);
                trips.add(trip);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return trips;
    }
}
