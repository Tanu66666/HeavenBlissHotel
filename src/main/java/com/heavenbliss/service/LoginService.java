package com.heavenbliss.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.heavenbliss.config.DbConfig;
import com.heavenbliss.model.UserModel;
import com.heavenbliss.util.PasswordUtil;

/**
 * LoginService handles database authentication for guest users.
 * Features:
 * - Password verification
 * - Failed attempt tracking
 * - Account locking after 5 failed attempts
 * 
 * @author Tanisha Maharjan
 */
public class LoginService {

    private static final int MAX_ATTEMPTS = 5;

    /**
     * Checks user credentials against the database.
     * Returns UserModel if login is valid, null if not.
     */
    public UserModel loginUser(String email, String password) {

        String sql = "SELECT * FROM users WHERE email = ?";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                // Check if account is locked
                boolean isLocked = rs.getBoolean("is_locked");
                if (isLocked) {
                    System.out.println("Account locked for: " + email);
                    return null;
                }

                int attempts = rs.getInt("login_attempts");
                String storedPass = rs.getString("password");

                // Verify password
                if (PasswordUtil.verifyPassword(password, storedPass)) {

                    // Reset failed attempts on success
                    resetAttempts(email);

                    // Build and return user model
                    UserModel user = new UserModel();
                    user.setUserId(rs.getInt("user_id"));
                    user.setFullName(rs.getString("full_name"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setRole(rs.getString("role"));
                    user.setLocked(isLocked);
                    user.setLoginAttempts(0);
                    
                    System.out.println("Login successful for: " + email);
                    return user;

                } else {
                    // Wrong password — increment attempts
                    int newAttempts = attempts + 1;
                    incrementAttempts(email, newAttempts);
                    System.out.println("Failed login for: " + email + " (Attempt " + newAttempts + "/" + MAX_ATTEMPTS + ")");
                    return null;
                }
            } else {
                System.out.println("User not found: " + email);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
    
    /**
     * Check if account is locked
     */
    public boolean isAccountLocked(String email) {
        String sql = "SELECT is_locked FROM users WHERE email = ?";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getBoolean("is_locked");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Increments failed login attempts.
     * Locks account automatically after MAX_ATTEMPTS failures.
     */
    private void incrementAttempts(String email, int newCount) {
        String sql = "UPDATE users SET login_attempts = ?, is_locked = ? WHERE email = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, newCount);
            ps.setBoolean(2, newCount >= MAX_ATTEMPTS);
            ps.setString(3, email);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Resets failed login counter after successful login.
     */
    private void resetAttempts(String email) {
        String sql = "UPDATE users SET login_attempts = 0, is_locked = FALSE WHERE email = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}