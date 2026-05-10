package com.gantavya.dao;

import java.sql.*;
import com.gantavya.config.DBConnection;
import com.gantavya.model.BookingModel;

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
}
