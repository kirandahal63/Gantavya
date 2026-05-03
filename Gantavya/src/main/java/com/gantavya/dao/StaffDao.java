package com.gantavya.dao;

import com.gantavya.config.DBConnection;
import com.gantavya.model.StaffModel;
import org.mindrot.jbcrypt.BCrypt;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StaffDao {

    /**
     * Generates a custom Staff ID (e.g., STF001, STF002) based on the last entry in the DB.
     */
    public String generateNextStaffId() {
        String query = "SELECT StaffID FROM staff WHERE StaffID LIKE 'STF%' ORDER BY StaffID DESC LIMIT 1";
        int lastNumber = 0;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                String lastId = rs.getString("StaffID");
                // Extracts only the digits from the ID string
                String numericPart = lastId.replaceAll("[^0-9]", "");
                if (!numericPart.isEmpty()) {
                    lastNumber = Integer.parseInt(numericPart);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return String.format("STF%03d", lastNumber + 1);
    }

 // 1. ADD: Register new staff
    public boolean registerStaff(StaffModel staff) {
        // 1. Handle ID Generation
        if (staff.getStaffId() == null || staff.getStaffId().trim().isEmpty()) {
            staff.setStaffId(generateNextStaffId());
        }

        // 2. FIX: Prevent the 'StaffEmail' cannot be null error
        if (staff.getStaffEmail() == null) {
            staff.setStaffEmail(""); // Provide an empty string so the DB is happy
        }

        // 3. Generate password: [Name]123 (No spaces)
        String plainPassword = staff.getStaffName().replaceAll("\\s+", "") + "123";
        String hashedPw = BCrypt.hashpw(plainPassword, BCrypt.gensalt());

        String sql = "INSERT INTO staff (StaffID, StaffName, StaffEmail, StaffDOB, MemberType, JoiningDate, Salary, Password, StaffStatus) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, staff.getStaffId());
            ps.setString(2, staff.getStaffName());
            ps.setString(3, staff.getStaffEmail()); // This is now safe
            ps.setDate(4, staff.getStaffDob());
            ps.setString(5, staff.getMemberType());
            ps.setDate(6, staff.getJoiningDate());
            ps.setLong(7, staff.getSalary());
            ps.setString(8, hashedPw); 
            ps.setString(9, "ACTIVE"); 
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("SQL ERROR in registerStaff: " + e.getMessage());
            return false;
        }
    }
    
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

    // 2. EDIT: Update existing staff details
    public boolean updateStaff(StaffModel staff) {
        // Added StaffEmail and StaffStatus to the SQL string
        String sql = "UPDATE staff SET StaffName=?, StaffEmail=?, StaffDOB=?, MemberType=?, JoiningDate=?, Salary=?, StaffStatus=? WHERE StaffID=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, staff.getStaffName());
            ps.setString(2, staff.getStaffEmail()); // NEW
            ps.setDate(3, staff.getStaffDob());
            ps.setString(4, staff.getMemberType());
            ps.setDate(5, staff.getJoiningDate());
            ps.setLong(6, staff.getSalary());
            ps.setString(7, staff.getStaffStatus()); // NEW
            ps.setString(8, staff.getStaffId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<StaffModel> getAllStaff() {
        List<StaffModel> list = new ArrayList<>();
        String sql = "SELECT * FROM staff";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(mapResultSetToModel(rs));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public List<StaffModel> searchStaff(String term) {
        List<StaffModel> list = new ArrayList<>();
        String sql = "SELECT * FROM staff WHERE StaffName LIKE ? OR MemberType LIKE ? OR StaffID LIKE ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String wildcard = "%" + term + "%";
            ps.setString(1, wildcard);
            ps.setString(2, wildcard);
            ps.setString(3, wildcard);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToModel(rs));
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public StaffModel getStaffById(String id) {
        String sql = "SELECT * FROM staff WHERE StaffID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSetToModel(rs);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public boolean deleteStaff(String id) {
        String sql = "DELETE FROM staff WHERE StaffID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { return false; }
    }

    private StaffModel mapResultSetToModel(ResultSet rs) throws SQLException {
        StaffModel s = new StaffModel();
        s.setStaffId(rs.getString("StaffID"));
        s.setStaffName(rs.getString("StaffName"));
        s.setStaffEmail(rs.getString("StaffEmail"));
        s.setStaffDob(rs.getDate("StaffDOB"));
        s.setMemberType(rs.getString("MemberType"));
        s.setJoiningDate(rs.getDate("JoiningDate"));
        s.setSalary(rs.getLong("Salary"));
        s.setStaffStatus(rs.getString("StaffStatus")); 
        return s;
    }
    
    public static void main(String[] args) {
        StaffDao dao = new StaffDao();
        StaffModel admin = new StaffModel();
        admin.setStaffId("STF001");
        admin.setStaffEmail("admin@gantavya.com");
        admin.setPassword("admin123");
        admin.setStaffName("System Administrator");
        admin.setMemberType("ADMIN");
        admin.setSalary(99000);

        if (dao.registerStaff(admin)) {
            System.out.println("Admin created successfully!");
        } else {
            System.out.println("Admin already exists or error occurred.");
        }
    }
}