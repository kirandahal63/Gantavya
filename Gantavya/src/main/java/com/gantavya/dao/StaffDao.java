package com.gantavya.dao;

import com.gantavya.config.DBConnection;
import org.mindrot.jbcrypt.BCrypt;
import java.sql.*;

public class StaffDao {

    /**
     * EXISTING LOGIN LOGIC
     */
    public String authenticateStaff(String staffId, String plainPassword) {
    	
    	
        String query = "SELECT Password, MemberType FROM staff WHERE StaffID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, staffId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String storedPassword = rs.getString("Password");
                    String memberType = rs.getString("MemberType");
                    boolean passwordMatch;
                    
                    if (storedPassword != null && storedPassword.startsWith("$2")) {
                        passwordMatch = BCrypt.checkpw(plainPassword, storedPassword);
                    } else {
                        passwordMatch = storedPassword != null && storedPassword.equals(plainPassword);
                    }

                    if (passwordMatch) {
                        return memberType != null ? memberType.toUpperCase() : "ADMIN";
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * DIRECT INSERT LOGIC
     * You can keep this here permanently to add more staff later.
     */
    public boolean registerStaff(String staffId, String plainPassword, String name, String role) {
        String hashedPw = BCrypt.hashpw(plainPassword, BCrypt.gensalt());
        String sql = "INSERT INTO staff (StaffID, StaffName, StaffDOB, MemberType, JoiningDate, Salary, Password) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, staffId);
            ps.setString(2, name);
            ps.setDate(3, java.sql.Date.valueOf("1990-01-01")); 
            ps.setString(4, role);
            ps.setDate(5, new java.sql.Date(System.currentTimeMillis()));
            ps.setLong(6, 0L); 
            ps.setString(7, hashedPw);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            // Error usually means the admin already exists
            System.out.println("Notice: Account might already exist.");
            return false;
        }
    }

    /**
     * THE "RUN" BUTTON
     * Keep this inside the DAO. Right-click this file and select 'Run StaffDao.main()'
     */
    public static void main(String[] args) {
        StaffDao dao = new StaffDao();
        boolean success = dao.registerStaff("admin@gmail.com", "admin123", "Main Admin", "ADMIN");
        
        if (success) {
            System.out.println("--- DATABASE UPDATED ---");
            System.out.println("Admin Email: admin@gmail.com");
            System.out.println("Admin Pass: admin123");
        } else {
            System.out.println("--- SYSTEM MESSAGE ---");
            System.out.println("Could not create admin. It is likely already in the database.");
        }
    }
}