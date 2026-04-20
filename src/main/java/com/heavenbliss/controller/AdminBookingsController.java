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

@WebServlet(asyncSupported = true, urlPatterns = {"/admin/bookings"})
public class AdminBookingsController extends HttpServlet {
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
        
        String filter = req.getParameter("filter");
        if (filter == null) filter = "all";
        
        try {
            List<Map<String, Object>> bookings = getAllBookings(filter);
            req.setAttribute("bookings", bookings);
            req.setAttribute("currentFilter", filter);
            
            // Get statistics
            req.setAttribute("totalBookings", getTotalBookings());
            req.setAttribute("pendingCount", getPendingCount());
            req.setAttribute("confirmedCount", getConfirmedCount());
            req.setAttribute("completedCount", getCompletedCount());
            req.setAttribute("cancelledCount", getCancelledCount());
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        req.getRequestDispatcher("/WEB-INF/pages/admin/adminbookings.jsp").forward(req, resp);
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
        
        resp.sendRedirect(req.getContextPath() + "/admin/bookings");
    }
    
    private List<Map<String, Object>> getAllBookings(String filter) {
        List<Map<String, Object>> bookings = new ArrayList<>();
        
        String sql = "SELECT b.*, u.full_name, u.email, u.phone, r.room_number, r.room_type, r.price_per_night " +
                     "FROM bookings b " +
                     "JOIN users u ON b.user_id = u.user_id " +
                     "JOIN rooms r ON b.room_id = r.room_id";
        
        if ("pending".equals(filter)) {
            sql += " WHERE b.status = 'pending'";
        } else if ("confirmed".equals(filter)) {
            sql += " WHERE b.status = 'confirmed'";
        } else if ("completed".equals(filter)) {
            sql += " WHERE b.status = 'completed'";
        } else if ("cancelled".equals(filter)) {
            sql += " WHERE b.status = 'cancelled'";
        }
        
        sql += " ORDER BY b.booking_date DESC";
        
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
                booking.put("room_id", rs.getInt("room_id"));
                booking.put("room_number", rs.getString("room_number"));
                booking.put("room_type", rs.getString("room_type"));
                booking.put("price_per_night", rs.getDouble("price_per_night"));
                booking.put("check_in_date", rs.getDate("check_in_date"));
                booking.put("check_out_date", rs.getDate("check_out_date"));
                booking.put("total_price", rs.getDouble("total_price"));
                booking.put("status", rs.getString("status"));
                booking.put("guest_count", rs.getInt("guest_count"));
                booking.put("special_requests", rs.getString("special_requests"));
                booking.put("booking_date", rs.getTimestamp("booking_date"));
                
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
    
    private int getTotalBookings() {
        String sql = "SELECT COUNT(*) FROM bookings";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    private int getPendingCount() {
        String sql = "SELECT COUNT(*) FROM bookings WHERE status = 'pending'";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    private int getConfirmedCount() {
        String sql = "SELECT COUNT(*) FROM bookings WHERE status = 'confirmed'";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    private int getCompletedCount() {
        String sql = "SELECT COUNT(*) FROM bookings WHERE status = 'completed'";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    private int getCancelledCount() {
        String sql = "SELECT COUNT(*) FROM bookings WHERE status = 'cancelled'";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    private void updateBookingStatus(int bookingId, String status) {
        String sql = "UPDATE bookings SET status = ? WHERE booking_id = ?";
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
        String sql = "DELETE FROM bookings WHERE booking_id = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}