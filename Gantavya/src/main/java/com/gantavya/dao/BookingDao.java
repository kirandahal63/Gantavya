package com.gantavya.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.gantavya.config.DBConnection;
import com.gantavya.model.BookingModel;
import com.gantavya.model.TripModel;

public class BookingDao {

    protected Connection getConnection() throws SQLException {
        return DBConnection.getConnection();
    }

    public String generateNextBookingId() {
        String query = "SELECT BookingID FROM booking WHERE BookingID LIKE 'BK%' ORDER BY LENGTH(BookingID) DESC, BookingID DESC LIMIT 1";
        int lastNumber = 0;

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                String lastId = rs.getString("BookingID");
                if (lastId != null) {
                    String numericPart = lastId.replaceAll("[^0-9]", "");
                    if (!numericPart.isEmpty()) {
                        lastNumber = Integer.parseInt(numericPart);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return String.format("BK%04d", lastNumber + 1);
    }

    public boolean saveBooking(BookingModel booking) throws SQLException {
        String query = "INSERT INTO booking (BookingID, BookingDate, SeatNumber, OtherPassengers, LuggagePreferences, TicketID, PaymentID, TripID, PassengerID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, booking.getBookingId());
            ps.setTimestamp(2, booking.getBookingDate());
            ps.setString(3, booking.getSeatNumber());
            ps.setString(4, booking.getOtherPassengers());
            ps.setString(5, booking.getLuggagePreferences());
            ps.setString(6, booking.getTicketId());
            ps.setString(7, booking.getPaymentId());
            ps.setString(8, booking.getTripId());
            ps.setString(9, booking.getPassengerId());
            
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }
    public List<BookingModel> getBookingsByPassengerId(String passengerId) {
        List<BookingModel> bookings = new ArrayList<>();
        String query = "SELECT b.*, t.DepartureDate, t.`Arrival Date`, t.Fare, r.RouteOrigin, r.RouteDestination, bs.BusType, bs.BusID " +
                       "FROM booking b " +
                       "JOIN trip t ON b.TripID = t.TripID " +
                       "JOIN route r ON t.RouteID = r.RouteID " +
                       "JOIN bus bs ON t.BusID = bs.BusID " +
                       "WHERE b.PassengerID = ? ORDER BY b.BookingDate DESC";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, passengerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BookingModel booking = new BookingModel();
                booking.setBookingId(rs.getString("BookingID"));
                booking.setBookingDate(rs.getTimestamp("BookingDate"));
                booking.setSeatNumber(rs.getString("SeatNumber"));
                booking.setTicketId(rs.getString("TicketID"));
                booking.setTripId(rs.getString("TripID"));
                
                TripModel trip = new TripModel();
                trip.setTripId(rs.getString("TripID"));
                trip.setDepartureDate(rs.getString("DepartureDate"));
                trip.setArrivalDate(rs.getString("Arrival Date"));
                trip.setFare(rs.getLong("Fare"));
                trip.setSource(rs.getString("RouteOrigin"));
                trip.setDestination(rs.getString("RouteDestination"));
                trip.setBusType(rs.getString("BusType"));
                trip.setBusId(rs.getString("BusID"));
                
                booking.setTrip(trip);
                bookings.add(booking);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bookings;
    }
}

