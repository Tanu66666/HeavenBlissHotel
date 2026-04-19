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

@WebServlet(asyncSupported = true, urlPatterns = {"/user/bookings"})
public class UserBookingsController extends HttpServlet {
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
        
        // Get filter parameter
        String filter = req.getParameter("filter");
        if (filter == null) filter = "all";
        
        try {
            // Get user bookings based on filter
            List<Map<String, Object>> bookings = getUserBookings(userId, filter);
            req.setAttribute("bookings", bookings);
            req.setAttribute("currentFilter", filter);
            
            // Get booking statistics
            req.setAttribute("totalBookings", getTotalBookings(userId));
            req.setAttribute("upcomingCount", getUpcomingCount(userId));
            req.setAttribute("completedCount", getCompletedCount(userId));
            req.setAttribute("cancelledCount", getCancelledCount(userId));
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        req.getRequestDispatcher("/WEB-INF/pages/user/mybookings.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        String action = req.getParameter("action");
        String bookingId = req.getParameter("bookingId");
        
        if ("cancel".equals(action) && bookingId != null) {
            cancelBooking(Integer.parseInt(bookingId));
        }
        
        resp.sendRedirect(req.getContextPath() + "/user/bookings");
    }
    
    private List<Map<String, Object>> getUserBookings(int userId, String filter) {
        List<Map<String, Object>> bookings = new ArrayList<>();
        
        String sql = "SELECT b.*, r.room_number, r.room_type, r.price_per_night " +
                     "FROM bookings b " +
                     "JOIN rooms r ON b.room_id = r.room_id " +
                     "WHERE b.user_id = ?";
        
        // Add filter condition
        if ("upcoming".equals(filter)) {
            sql += " AND b.check_in_date >= CURDATE() AND b.status != 'cancelled' AND b.status != 'completed'";
        } else if ("completed".equals(filter)) {
            sql += " AND (b.status = 'completed' OR b.check_out_date < CURDATE())";
        } else if ("cancelled".equals(filter)) {
            sql += " AND b.status = 'cancelled'";
        }
        
        sql += " ORDER BY b.booking_date DESC";
        
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
                booking.put("price_per_night", rs.getDouble("price_per_night"));
                
                // Calculate nights
                long diff = rs.getDate("check_out_date").getTime() - rs.getDate("check_in_date").getTime();
                long nights = diff / (1000 * 60 * 60 * 24);
                booking.put("nights", nights);
                
                bookings.add(booking);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bookings;
    }
    
    private int getTotalBookings(int userId) {
        String sql = "SELECT COUNT(*) FROM bookings WHERE user_id = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    private int getUpcomingCount(int userId) {
        String sql = "SELECT COUNT(*) FROM bookings WHERE user_id = ? AND check_in_date >= CURDATE() AND status != 'cancelled' AND status != 'completed'";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    private int getCompletedCount(int userId) {
        String sql = "SELECT COUNT(*) FROM bookings WHERE user_id = ? AND (status = 'completed' OR check_out_date < CURDATE())";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    private int getCancelledCount(int userId) {
        String sql = "SELECT COUNT(*) FROM bookings WHERE user_id = ? AND status = 'cancelled'";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    private void cancelBooking(int bookingId) {
        String sql = "UPDATE bookings SET status = 'cancelled' WHERE booking_id = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}