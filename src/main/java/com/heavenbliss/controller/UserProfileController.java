package com.heavenbliss.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import com.heavenbliss.config.DbConfig;
import com.heavenbliss.util.PasswordUtil;

@WebServlet(asyncSupported = true, urlPatterns = {"/user/profile"})
public class UserProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        try {
            // Get user profile from database
            Map<String, Object> userProfile = getUserProfile(userId);
            req.setAttribute("userProfile", userProfile);
            
            // Also get security question for password change
            String securityQuestion = getSecurityQuestion(userId);
            req.setAttribute("securityQuestion", securityQuestion);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        req.getRequestDispatcher("/WEB-INF/pages/user/myprofile.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        Integer userId = (Integer) session.getAttribute("userId");
        String action = req.getParameter("action");
        
        if ("updateProfile".equals(action)) {
            updateProfile(req, resp, userId);
        } else if ("changePassword".equals(action)) {
            changePassword(req, resp, userId);
        } else {
            resp.sendRedirect(req.getContextPath() + "/user/profile");
        }
    }
    
    private void updateProfile(HttpServletRequest req, HttpServletResponse resp, int userId)
            throws ServletException, IOException {
        
        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        
        // Validation
        if (fullName == null || fullName.trim().isEmpty()) {
            req.setAttribute("error", "Full name is required");
            doGet(req, resp);
            return;
        }
        
        if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            req.setAttribute("error", "Valid email is required");
            doGet(req, resp);
            return;
        }
        
        if (phone == null || !phone.matches("\\d{10}")) {
            req.setAttribute("error", "Valid 10-digit phone number is required");
            doGet(req, resp);
            return;
        }
        
        String sql = "UPDATE users SET full_name = ?, email = ?, phone = ? WHERE user_id = ?";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setInt(4, userId);
            
            int result = ps.executeUpdate();
            
            if (result > 0) {
                // Update session values
                HttpSession session = req.getSession();
                session.setAttribute("userName", fullName);
                session.setAttribute("userEmail", email);
                
                req.setAttribute("success", "Profile updated successfully!");
            } else {
                req.setAttribute("error", "Failed to update profile");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Database error occurred");
        }
        
        doGet(req, resp);
    }
    
    private void changePassword(HttpServletRequest req, HttpServletResponse resp, int userId)
            throws ServletException, IOException {
        
        String currentPassword = req.getParameter("currentPassword");
        String securityAnswer = req.getParameter("securityAnswer");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");
        
        // Validation
        if (newPassword == null || newPassword.length() < 6) {
            req.setAttribute("error", "New password must be at least 6 characters");
            doGet(req, resp);
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("error", "New passwords do not match");
            doGet(req, resp);
            return;
        }
        
        // Verify current password or security answer
        String sql = "SELECT password, security_answer FROM users WHERE user_id = ?";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                String storedPassword = rs.getString("password");
                String storedAnswer = rs.getString("security_answer");
                
                boolean isVerified = false;
                
                // Check if current password is provided and matches
                if (currentPassword != null && !currentPassword.isEmpty()) {
                    isVerified = PasswordUtil.verifyPassword(currentPassword, storedPassword);
                } 
                // Otherwise check security answer
                else if (securityAnswer != null && !securityAnswer.isEmpty()) {
                    isVerified = storedAnswer != null && storedAnswer.equalsIgnoreCase(securityAnswer.trim());
                }
                
                if (isVerified) {
                    // Update password
                    String hashedPassword = PasswordUtil.hashPassword(newPassword);
                    String updateSql = "UPDATE users SET password = ? WHERE user_id = ?";
                    
                    try (PreparedStatement ps2 = conn.prepareStatement(updateSql)) {
                        ps2.setString(1, hashedPassword);
                        ps2.setInt(2, userId);
                        ps2.executeUpdate();
                        req.setAttribute("success", "Password changed successfully!");
                    }
                } else {
                    req.setAttribute("error", "Current password or security answer is incorrect");
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Database error occurred");
        }
        
        doGet(req, resp);
    }
    
    private Map<String, Object> getUserProfile(int userId) {
        Map<String, Object> profile = new HashMap<>();
        String sql = "SELECT user_id, full_name, email, phone, created_at FROM users WHERE user_id = ?";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                profile.put("user_id", rs.getInt("user_id"));
                profile.put("full_name", rs.getString("full_name"));
                profile.put("email", rs.getString("email"));
                profile.put("phone", rs.getString("phone"));
                profile.put("created_at", rs.getTimestamp("created_at"));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return profile;
    }
    
    private String getSecurityQuestion(int userId) {
        String sql = "SELECT security_question FROM users WHERE user_id = ?";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getString("security_question");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "What is your favorite color?";
    }
}