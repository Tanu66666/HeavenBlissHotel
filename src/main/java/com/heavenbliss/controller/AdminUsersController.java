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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.heavenbliss.config.DbConfig;
import com.heavenbliss.util.PasswordUtil;

@WebServlet(asyncSupported = true, urlPatterns = {"/admin/users"})
public class AdminUsersController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        // Check if admin is logged in
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        String action = req.getParameter("action");
        
        try {
            if ("edit".equals(action)) {
                // Show edit form
                int userId = Integer.parseInt(req.getParameter("id"));
                Map<String, Object> user = getUserById(userId);
                req.setAttribute("user", user);
                req.setAttribute("isEdit", true);
                req.getRequestDispatcher("/WEB-INF/pages/admin/userform.jsp").forward(req, resp);
                
            } else if ("delete".equals(action)) {
                // Delete user
                int userId = Integer.parseInt(req.getParameter("id"));
                deleteUser(userId);
                resp.sendRedirect(req.getContextPath() + "/admin/users");
                
            } else if ("unlock".equals(action)) {
                // Unlock user account
                int userId = Integer.parseInt(req.getParameter("id"));
                unlockUser(userId);
                resp.sendRedirect(req.getContextPath() + "/admin/users");
                
            } else if ("reset".equals(action)) {
                // Reset user password
                int userId = Integer.parseInt(req.getParameter("id"));
                resetPassword(userId);
                resp.sendRedirect(req.getContextPath() + "/admin/users");
                
            } else {
                // Show all users (excluding admin)
                List<Map<String, Object>> users = getAllUsers();
                req.setAttribute("users", users);
                req.getRequestDispatcher("/WEB-INF/pages/admin/adminusers.jsp").forward(req, resp);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/users");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        String action = req.getParameter("action");
        
        try {
            if ("update".equals(action)) {
                updateUser(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin/users");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/users");
        }
    }
    
    private List<Map<String, Object>> getAllUsers() {
        List<Map<String, Object>> users = new ArrayList<>();
        String sql = "SELECT user_id, full_name, email, phone, role, login_attempts, is_locked, created_at FROM users WHERE role = 'guest' ORDER BY created_at DESC";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Map<String, Object> user = new HashMap<>();
                user.put("user_id", rs.getInt("user_id"));
                user.put("full_name", rs.getString("full_name"));
                user.put("email", rs.getString("email"));
                user.put("phone", rs.getString("phone"));
                user.put("role", rs.getString("role"));
                user.put("login_attempts", rs.getInt("login_attempts"));
                user.put("is_locked", rs.getBoolean("is_locked"));
                user.put("created_at", rs.getTimestamp("created_at"));
                users.add(user);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }
    
    private Map<String, Object> getUserById(int userId) {
        Map<String, Object> user = new HashMap<>();
        String sql = "SELECT user_id, full_name, email, phone, role, login_attempts, is_locked, created_at FROM users WHERE user_id = ?";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                user.put("user_id", rs.getInt("user_id"));
                user.put("full_name", rs.getString("full_name"));
                user.put("email", rs.getString("email"));
                user.put("phone", rs.getString("phone"));
                user.put("role", rs.getString("role"));
                user.put("login_attempts", rs.getInt("login_attempts"));
                user.put("is_locked", rs.getBoolean("is_locked"));
                user.put("created_at", rs.getTimestamp("created_at"));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
    
    private void updateUser(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        int userId = Integer.parseInt(req.getParameter("user_id"));
        String fullName = req.getParameter("full_name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String role = req.getParameter("role");
        boolean isLocked = "true".equals(req.getParameter("is_locked"));
        
        String sql = "UPDATE users SET full_name = ?, email = ?, phone = ?, role = ?, is_locked = ? WHERE user_id = ?";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, role);
            ps.setBoolean(5, isLocked);
            ps.setInt(6, userId);
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        resp.sendRedirect(req.getContextPath() + "/admin/users");
    }
    
    private void deleteUser(int userId) {
        String sql = "DELETE FROM users WHERE user_id = ? AND role = 'guest'";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    private void unlockUser(int userId) {
        String sql = "UPDATE users SET is_locked = FALSE, login_attempts = 0 WHERE user_id = ?";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    private void resetPassword(int userId) {
        String defaultPassword = PasswordUtil.hashPassword("password123");
        String sql = "UPDATE users SET password = ? WHERE user_id = ?";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, defaultPassword);
            ps.setInt(2, userId);
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}