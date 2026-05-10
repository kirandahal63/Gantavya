package com.gantavya.dao;

import java.sql.*;
import com.gantavya.config.DBConnection;
import com.gantavya.model.PaymentModel;

public class PaymentDao {

    protected Connection getConnection() throws SQLException {
        return DBConnection.getConnection();
    }

    public boolean savePayment(PaymentModel payment) throws SQLException {
        String query = "INSERT INTO payment (PaymentID, PaymentAmount, PaymentDate, PaymentMethod) VALUES (?, ?, ?, ?)";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, payment.getPaymentId());
            ps.setLong(2, payment.getPaymentAmount());
            ps.setTimestamp(3, payment.getPaymentDate());
            ps.setString(4, payment.getPaymentMethod());
            
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }
}
