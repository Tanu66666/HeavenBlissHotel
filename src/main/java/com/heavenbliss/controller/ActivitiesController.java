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

@WebServlet(asyncSupported = true, urlPatterns = {"/activities"})
public class ActivitiesController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        try {
            List<Map<String, Object>> activities = getAllActivities();
            req.setAttribute("activities", activities);
            req.getRequestDispatcher("/WEB-INF/pages/activities.jsp").forward(req, resp);
            
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/home");
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
        
        Integer userId = (Integer) session.getAttribute("userId");
        String action = req.getParameter("action");
        
        if ("bookActivity".equals(action)) {
            bookActivity(req, resp, userId);
        } else {
            resp.sendRedirect(req.getContextPath() + "/activities");
        }
    }
    
    private List<Map<String, Object>> getAllActivities() {
        List<Map<String, Object>> activities = new ArrayList<>();
        String sql = "SELECT * FROM activities WHERE status = 'active' ORDER BY activity_id";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Map<String, Object> activity = new HashMap<>();
                activity.put("activity_id", rs.getInt("activity_id"));
                activity.put("activity_name", rs.getString("activity_name"));
                activity.put("description", rs.getString("description"));
                activity.put("duration", rs.getString("duration"));
                activity.put("price", rs.getDouble("price"));
                activity.put("image_path", rs.getString("image_path"));
                activity.put("category", rs.getString("category"));
                activities.add(activity);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return activities;
    }
    
    private void bookActivity(HttpServletRequest req, HttpServletResponse resp, int userId)
            throws ServletException, IOException {
        
        int activityId = Integer.parseInt(req.getParameter("activityId"));
        String bookingDate = req.getParameter("bookingDate");
        int guestCount = Integer.parseInt(req.getParameter("guestCount"));
        double totalPrice = Double.parseDouble(req.getParameter("totalPrice"));
        String specialRequests = req.getParameter("specialRequests");
        
        String sql = "INSERT INTO activity_bookings (user_id, activity_id, booking_date, guest_count, total_price, special_requests, status) VALUES (?, ?, ?, ?, ?, ?, 'pending')";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ps.setInt(2, activityId);
            ps.setString(3, bookingDate);
            ps.setInt(4, guestCount);
            ps.setDouble(5, totalPrice);
            ps.setString(6, specialRequests);
            ps.executeUpdate();
            
            req.setAttribute("success", "Activity booked successfully! Please proceed to payment.");
            
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Booking failed. Please try again.");
        }
        
        req.getRequestDispatcher("/WEB-INF/pages/activities.jsp").forward(req, resp);
    }
}