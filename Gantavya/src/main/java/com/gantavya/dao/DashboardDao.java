package com.gantavya.dao;

import java.sql.*;
import com.gantavya.config.DBConnection;

public class DashboardDao {
    
    protected Connection getConnection() throws SQLException {
        return DBConnection.getConnection();
    }

    public int getTotalBuses() {
        return getCount("SELECT COUNT(*) FROM bus");
    }

    public int getTotalTrips() {
        return getCount("SELECT COUNT(*) FROM trip");
    }

    public int getTotalRoutes() {
        return getCount("SELECT COUNT(*) FROM route");
    }

    public int getTotalPassengers() {
        return getCount("SELECT COUNT(*) FROM passenger");
    }

    public int getTotalBookings() {
        return getCount("SELECT COUNT(*) FROM booking");
    }

    public int getTotalStaff() {
        return getCount("SELECT COUNT(*) FROM staff");
    }
    
    public int getNewBookingsToday() {
        return getCount("SELECT COUNT(*) FROM booking WHERE DATE(BookingDate) = CURDATE()");
    }

    public long getTotalRevenue() {
        // Calculate revenue by summing PaymentAmount from the payment table
        String query = "SELECT SUM(PaymentAmount) FROM payment";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getLong(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    private int getCount(String query) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
