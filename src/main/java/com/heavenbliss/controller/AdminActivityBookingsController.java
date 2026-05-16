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

@WebServlet("/admin/activity-bookings")
public class AdminActivityBookingsController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        String filter = req.getParameter("filter");
        if (filter == null) filter = "all";
        
        try {
            List<Map<String, Object>> bookings = getAllActivityBookings(filter);
            req.setAttribute("bookings", bookings);
            req.setAttribute("currentFilter", filter);
            
            req.setAttribute("totalBookings", getTotalCount());
            req.setAttribute("pendingCount", getCountByStatus("pending"));
            req.setAttribute("confirmedCount", getCountByStatus("confirmed"));
            req.setAttribute("completedCount", getCountByStatus("completed"));
            req.setAttribute("cancelledCount", getCountByStatus("cancelled"));
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        req.getRequestDispatcher("/WEB-INF/pages/admin/adminactivitybookings.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        String action = req.getParameter("action");
        String bookingId = req.getParameter("bookingId");
        String status = req.getParameter("status");
        
        try {
            if ("updateStatus".equals(action) && bookingId != null && status != null) {
                updateBookingStatus(Integer.parseInt(bookingId), status);
            } else if ("delete".equals(action) && bookingId != null) {
                deleteBooking(Integer.parseInt(bookingId));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        resp.sendRedirect(req.getContextPath() + "/admin/activity-bookings");
    }
    
    private List<Map<String, Object>> getAllActivityBookings(String filter) {
        List<Map<String, Object>> bookings = new ArrayList<>();
        
        String sql = "SELECT ab.*, u.full_name, u.email, u.phone, a.activity_name, a.duration, a.price " +
                     "FROM activity_bookings ab " +
                     "JOIN users u ON ab.user_id = u.user_id " +
                     "JOIN activities a ON ab.activity_id = a.activity_id";
        
        if ("pending".equals(filter)) {
            sql += " WHERE ab.status = 'pending'";
        } else if ("confirmed".equals(filter)) {
            sql += " WHERE ab.status = 'confirmed'";
        } else if ("completed".equals(filter)) {
            sql += " WHERE ab.status = 'completed'";
        } else if ("cancelled".equals(filter)) {
            sql += " WHERE ab.status = 'cancelled'";
        }
        
        sql += " ORDER BY ab.created_at DESC";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Map<String, Object> booking = new HashMap<>();
                booking.put("booking_id", rs.getInt("booking_id"));
                booking.put("user_id", rs.getInt("user_id"));
                booking.put("full_name", rs.getString("full_name"));
                booking.put("email", rs.getString("email"));
                booking.put("phone", rs.getString("phone"));
                booking.put("activity_id", rs.getInt("activity_id"));
                booking.put("activity_name", rs.getString("activity_name"));
                booking.put("duration", rs.getString("duration"));
                booking.put("price", rs.getDouble("price"));
                booking.put("booking_date", rs.getDate("booking_date"));
                booking.put("guest_count", rs.getInt("guest_count"));
                booking.put("total_price", rs.getDouble("total_price"));
                booking.put("status", rs.getString("status"));
                booking.put("special_requests", rs.getString("special_requests"));
                booking.put("created_at", rs.getTimestamp("created_at"));
                bookings.add(booking);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bookings;
    }
    
    private int getTotalCount() {
        String sql = "SELECT COUNT(*) FROM activity_bookings";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    private int getCountByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM activity_bookings WHERE status = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    private void updateBookingStatus(int bookingId, String status) {
        String sql = "UPDATE activity_bookings SET status = ? WHERE booking_id = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    private void deleteBooking(int bookingId) {
        String sql = "DELETE FROM activity_bookings WHERE booking_id = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}