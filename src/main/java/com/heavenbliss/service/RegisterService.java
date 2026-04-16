package com.heavenbliss.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.heavenbliss.config.DbConfig;
import com.heavenbliss.model.UserModel;

/**
 * RegisterService handles database operations for user registration
 * 
 * @author Tanisha Maharjan
 */
public class RegisterService {
    
    /**
     * Check if email already exists in database
     * @param email User email
     * @return true if exists, false otherwise
     */
    public boolean isEmailExists(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // Returns true if email exists
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Check if phone number already exists in database
     * @param phone User phone number
     * @return true if exists, false otherwise
     */
    public boolean isPhoneExists(String phone) {
        String sql = "SELECT * FROM users WHERE phone = ?";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // Returns true if phone exists
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Register new user in database
     * @param user UserModel object with user details
     * @return true if registration successful, false otherwise
     */
    public boolean registerUser(UserModel user) {
        String sql = "INSERT INTO users (full_name, email, phone, password, role, login_attempts, is_locked) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getRole());
            ps.setInt(6, user.getLoginAttempts());
            ps.setBoolean(7, user.isLocked());
            
            int result = ps.executeUpdate();
            return result > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}