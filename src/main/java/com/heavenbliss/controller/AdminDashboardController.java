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

@WebServlet(asyncSupported = true, urlPatterns = {"/admin/dashboard"})
public class AdminDashboardController extends HttpServlet {
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
        
        // Check role is admin
        String role = (String) session.getAttribute("userRole");
        if (!"admin".equals(role)) {
            resp.sendRedirect(req.getContextPath() + "/user/dashboard");
            return;
        }
        
        try {
            // Get all statistics from database
            req.setAttribute("totalRooms", getTotalRooms());
            req.setAttribute("availableRooms", getAvailableRooms());
            req.setAttribute("bookedRooms", getBookedRooms());
            req.setAttribute("maintenanceRooms", getMaintenanceRooms());
            req.setAttribute("totalUsers", getTotalUsers());
            req.setAttribute("totalBookings", getTotalBookings());
            req.setAttribute("pendingBookings", getPendingBookings());
            req.setAttribute("totalRevenue", getTotalRevenue());
            req.setAttribute("recentBookings", getRecentBookings());
            req.setAttribute("recentUsers", getRecentUsers());
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // Forward to admin dashboard JSP
        req.getRequestDispatcher("/WEB-INF/pages/admin/admindashboard.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }
    
    private int getTotalRooms() {
        String sql = "SELECT COUNT(*) FROM rooms";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    private int getAvailableRooms() {
        String sql = "SELECT COUNT(*) FROM rooms WHERE status = 'available'";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    private int getBookedRooms() {
        String sql = "SELECT COUNT(*) FROM rooms WHERE status = 'booked'";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    private int getMaintenanceRooms() {
        String sql = "SELECT COUNT(*) FROM rooms WHERE status = 'maintenance'";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    private int getTotalUsers() {
        String sql = "SELECT COUNT(*) FROM users WHERE role = 'guest'";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    private int getTotalBookings() {
        String sql = "SELECT COUNT(*) FROM bookings";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    private int getPendingBookings() {
        String sql = "SELECT COUNT(*) FROM bookings WHERE status = 'pending'";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    private double getTotalRevenue() {
        String sql = "SELECT COALESCE(SUM(total_price), 0) FROM bookings WHERE status = 'completed' OR status = 'confirmed'";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    private List<Map<String, Object>> getRecentBookings() {
        List<Map<String, Object>> bookings = new ArrayList<>();
        String sql = "SELECT b.*, u.full_name, r.room_number, r.room_type " +
                     "FROM bookings b " +
                     "JOIN users u ON b.user_id = u.user_id " +
                     "JOIN rooms r ON b.room_id = r.room_id " +
                     "ORDER BY b.booking_date DESC LIMIT 5";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> booking = new HashMap<>();
                booking.put("booking_id", rs.getInt("booking_id"));
                booking.put("full_name", rs.getString("full_name"));
                booking.put("room_number", rs.getString("room_number"));
                booking.put("room_type", rs.getString("room_type"));
                booking.put("check_in_date", rs.getDate("check_in_date"));
                booking.put("check_out_date", rs.getDate("check_out_date"));
                booking.put("total_price", rs.getDouble("total_price"));
                booking.put("status", rs.getString("status"));
                bookings.add(booking);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return bookings;
    }
    
    private List<Map<String, Object>> getRecentUsers() {
        List<Map<String, Object>> users = new ArrayList<>();
        String sql = "SELECT user_id, full_name, email, phone, created_at FROM users WHERE role = 'guest' ORDER BY created_at DESC LIMIT 5";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> user = new HashMap<>();
                user.put("user_id", rs.getInt("user_id"));
                user.put("full_name", rs.getString("full_name"));
                user.put("email", rs.getString("email"));
                user.put("phone", rs.getString("phone"));
                user.put("created_at", rs.getTimestamp("created_at"));
                users.add(user);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return users;
    }
}