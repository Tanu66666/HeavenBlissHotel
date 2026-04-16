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

@WebServlet(asyncSupported = true, urlPatterns = {"/user/dashboard"})
public class UserDashboardController extends HttpServlet {
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
        
        // Get user info from session
        Integer userId = (Integer) session.getAttribute("userId");
        String userName = (String) session.getAttribute("userName");
        String userEmail = (String) session.getAttribute("userEmail");
        
        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        try {
            // Get user's bookings
            req.setAttribute("userBookings", getUserBookings(userId));
            
            // Get available rooms (for booking)
            req.setAttribute("availableRooms", getAvailableRooms());
            
            // Get user profile info
            req.setAttribute("userName", userName);
            req.setAttribute("userEmail", userEmail);
            req.setAttribute("userProfile", getUserProfile(userId));
            
            // Get statistics for user
            req.setAttribute("totalBookings", getTotalUserBookings(userId));
            req.setAttribute("upcomingBookings", getUpcomingBookings(userId));
            req.setAttribute("completedBookings", getCompletedBookings(userId));
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // Forward to user dashboard JSP
        req.getRequestDispatcher("/WEB-INF/pages/user/userdashboard.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }
    
    // Get user's booking history
    private List<Map<String, Object>> getUserBookings(int userId) {
        List<Map<String, Object>> bookings = new ArrayList<>();
        String sql = "SELECT b.*, r.room_number, r.room_type, r.price_per_night " +
                     "FROM bookings b " +
                     "JOIN rooms r ON b.room_id = r.room_id " +
                     "WHERE b.user_id = ? " +
                     "ORDER BY b.booking_date DESC";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> booking = new HashMap<>();
                booking.put("booking_id", rs.getInt("booking_id"));
                booking.put("room_number", rs.getString("room_number"));
                booking.put("room_type", rs.getString("room_type"));
                booking.put("check_in_date", rs.getDate("check_in_date"));
                booking.put("check_out_date", rs.getDate("check_out_date"));
                booking.put("total_price", rs.getDouble("total_price"));
                booking.put("status", rs.getString("status"));
                booking.put("guest_count", rs.getInt("guest_count"));
                booking.put("special_requests", rs.getString("special_requests"));
                bookings.add(booking);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return bookings;
    }
    
    // Get available rooms
    private List<Map<String, Object>> getAvailableRooms() {
        List<Map<String, Object>> rooms = new ArrayList<>();
        String sql = "SELECT * FROM rooms WHERE status = 'available' LIMIT 6";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> room = new HashMap<>();
                room.put("room_id", rs.getInt("room_id"));
                room.put("room_number", rs.getString("room_number"));
                room.put("room_type", rs.getString("room_type"));
                room.put("price_per_night", rs.getDouble("price_per_night"));
                room.put("description", rs.getString("description"));
                room.put("status", rs.getString("status"));
                rooms.add(room);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return rooms;
    }
    
    // Get user profile
    private Map<String, Object> getUserProfile(int userId) {
        String sql = "SELECT user_id, full_name, email, phone, created_at FROM users WHERE user_id = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Map<String, Object> profile = new HashMap<>();
                profile.put("full_name", rs.getString("full_name"));
                profile.put("email", rs.getString("email"));
                profile.put("phone", rs.getString("phone"));
                profile.put("created_at", rs.getTimestamp("created_at"));
                return profile;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }
    
    // Get total bookings count for user
    private int getTotalUserBookings(int userId) {
        String sql = "SELECT COUNT(*) FROM bookings WHERE user_id = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    // Get upcoming bookings count
    private int getUpcomingBookings(int userId) {
        String sql = "SELECT COUNT(*) FROM bookings WHERE user_id = ? AND check_in_date > CURDATE() AND status != 'cancelled'";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    // Get completed bookings count
    private int getCompletedBookings(int userId) {
        String sql = "SELECT COUNT(*) FROM bookings WHERE user_id = ? AND (status = 'completed' OR check_out_date < CURDATE())";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
}