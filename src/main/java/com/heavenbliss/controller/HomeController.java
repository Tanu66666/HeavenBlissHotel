package com.heavenbliss.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.heavenbliss.config.DbConfig;

@WebServlet(asyncSupported = true, urlPatterns = {"/home", "/"})
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        try {
            // Get featured rooms (first 3 available rooms)
            List<Map<String, Object>> featuredRooms = getFeaturedRooms();
            req.setAttribute("featuredRooms", featuredRooms);
            
            // Get room statistics
            int totalRooms = getTotalRooms();
            int availableRooms = getAvailableRooms();
            req.setAttribute("totalRooms", totalRooms);
            req.setAttribute("availableRooms", availableRooms);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        req.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(req, resp);
    }
    
    private List<Map<String, Object>> getFeaturedRooms() {
        List<Map<String, Object>> rooms = new ArrayList<>();
        String sql = "SELECT room_id, room_number, room_type, price_per_night, description, image_path FROM rooms WHERE status = 'available' LIMIT 3";
        
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
                rooms.add(room);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rooms;
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
}