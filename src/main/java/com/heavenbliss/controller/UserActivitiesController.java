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

@WebServlet("/user/activities")
public class UserActivitiesController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        Integer userId = (Integer) session.getAttribute("userId");
        String filter = req.getParameter("filter");
        if (filter == null) filter = "all";
        
        try {
            List<Map<String, Object>> bookings = getUserActivityBookings(userId, filter);
            req.setAttribute("bookings", bookings);
            req.setAttribute("currentFilter", filter);
            
            req.setAttribute("totalBookings", getTotalBookings(userId));
            req.setAttribute("upcomingCount", getUpcomingCount(userId));
            req.setAttribute("completedCount", getCompletedCount(userId));
            req.setAttribute("cancelledCount", getCancelledCount(userId));
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        req.getRequestDispatcher("/WEB-INF/pages/user/myactivities.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        String action = req.getParameter("action");
        String bookingId = req.getParameter("bookingId");
        
        if ("cancel".equals(action) && bookingId != null) {
            cancelBooking(Integer.parseInt(bookingId));
        }
        
        resp.sendRedirect(req.getContextPath() + "/user/activities");
    }
    
    private List<Map<String, Object>> getUserActivityBookings(int userId, String filter) {
        List<Map<String, Object>> bookings = new ArrayList<>();
        
        String sql = "SELECT ab.*, a.activity_name, a.duration " +
                     "FROM activity_bookings ab " +
                     "JOIN activities a ON ab.activity_id = a.activity_id " +
                     "WHERE ab.user_id = ?";
        
        if ("upcoming".equals(filter)) {
            sql += " AND ab.booking_date >= CURDATE() AND ab.status != 'cancelled' AND ab.status != 'completed'";
        } else if ("completed".equals(filter)) {
            sql += " AND ab.status = 'completed'";
        } else if ("cancelled".equals(filter)) {
            sql += " AND ab.status = 'cancelled'";
        }
        
        sql += " ORDER BY ab.created_at DESC";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> booking = new HashMap<>();
                booking.put("booking_id", rs.getInt("booking_id"));
                booking.put("activity_name", rs.getString("activity_name"));
                booking.put("booking_date", rs.getDate("booking_date"));
                booking.put("guest_count", rs.getInt("guest_count"));
                booking.put("total_price", rs.getDouble("total_price"));
                booking.put("status", rs.getString("status"));
                booking.put("special_requests", rs.getString("special_requests"));
                booking.put("duration", rs.getString("duration"));
                bookings.add(booking);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bookings;
    }
    
    private int getTotalBookings(int userId) {
        String sql = "SELECT COUNT(*) FROM activity_bookings WHERE user_id = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    private int getUpcomingCount(int userId) {
        String sql = "SELECT COUNT(*) FROM activity_bookings WHERE user_id = ? AND booking_date >= CURDATE() AND status != 'cancelled' AND status != 'completed'";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    private int getCompletedCount(int userId) {
        String sql = "SELECT COUNT(*) FROM activity_bookings WHERE user_id = ? AND status = 'completed'";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    private int getCancelledCount(int userId) {
        String sql = "SELECT COUNT(*) FROM activity_bookings WHERE user_id = ? AND status = 'cancelled'";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    private void cancelBooking(int bookingId) {
        String sql = "UPDATE activity_bookings SET status = 'cancelled' WHERE booking_id = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}