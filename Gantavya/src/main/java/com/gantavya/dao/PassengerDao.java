package com.gantavya.dao;


import com.gantavya.config.DBConnection;
import com.gantavya.model.PassengerModel;
import org.mindrot.jbcrypt.BCrypt;
import java.sql.*;

public class PassengerDao {
	
	private String generateNextId() {
	    // 1. Updated 'id' to 'PassengerID' to match your database schema
	    String query = "SELECT PassengerID FROM passenger WHERE PassengerID LIKE 'PSSD%' ORDER BY PassengerID DESC LIMIT 1";
	    int lastNumber = 0;

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query);
	         ResultSet rs = pstmt.executeQuery()) {

	        if (rs.next()) {
	            // 2. Updated to get the correct column name
	            String lastId = rs.getString("PassengerID"); 
	            
	            // 3. More robust parsing: Remove the non-numeric prefix "PSSD"
	            // This handles cases like "PSSD10" better than just replacing "PSSD0"
	            String numericPart = lastId.replaceAll("[^0-9]", "");
	            if (!numericPart.isEmpty()) {
	                lastNumber = Integer.parseInt(numericPart);
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    // 4. Return formatted ID. Using String.format ensures it stays "PSSD01" instead of "PSSD1"
	    // %02d means: "format as a decimal with at least 2 digits, padding with 0 if needed"
	    return String.format("PSSD%02d", lastNumber + 1);
	}

	public boolean registerPassenger(PassengerModel passenger) {
	    // 1. Match these column names exactly to your 'DESCRIBE' output
	    String query = "INSERT INTO passenger (PassengerID, Name, ContactNumber, DOB, Gender, Email, Password) VALUES (?, ?, ?, ?, ?, ?, ?)";

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query)) {

	        String customPassengerId = generateNextId(); 

	        pstmt.setString(1, customPassengerId);       
	        pstmt.setString(2, passenger.getFullName()); 
	        pstmt.setLong(3, passenger.getContactNumber()); 
	        pstmt.setString(4, passenger.getDob());     
	        pstmt.setString(5, passenger.getGender());   
	        pstmt.setString(6, passenger.getEmail());    
	        String hashedPassword = BCrypt.hashpw(passenger.getPassword(), BCrypt.gensalt());
	        pstmt.setString(7, hashedPassword);

	        int result = pstmt.executeUpdate();
	        return result > 0;

	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}


	public boolean isEmailExists(String email) {
	    String query = "SELECT PassengerID FROM passenger WHERE Email = ?";
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query)) {
	        pstmt.setString(1, email);
	        
	        try (ResultSet rs = pstmt.executeQuery()) {
	            return rs.next();
	        }
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	public boolean isNumberExists(long contactNumber) {
	    String query = "SELECT PassengerID FROM passenger WHERE ContactNumber = ?";
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query)) {
	        pstmt.setLong(1, contactNumber);
	        
	        try (ResultSet rs = pstmt.executeQuery()) {
	            return rs.next();
	        }
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	public boolean authenticatePassenger(String email, String plainPassword) {
	    String query = "SELECT Password FROM passenger WHERE Email = ?";
	    
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(query)) {
	        
	        ps.setString(1, email);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            String hashedPassword = rs.getString("Password");
	            return BCrypt.checkpw(plainPassword, hashedPassword);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}
}