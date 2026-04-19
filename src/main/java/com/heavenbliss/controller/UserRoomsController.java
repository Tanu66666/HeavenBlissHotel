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

@WebServlet(asyncSupported = true, urlPatterns = {"/user/rooms"})
public class UserRoomsController extends HttpServlet {
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
        
        String search = req.getParameter("search");
        String roomType = req.getParameter("roomType");
        String minPrice = req.getParameter("minPrice");
        String maxPrice = req.getParameter("maxPrice");
        
        try {
            List<Map<String, Object>> rooms = getRooms(search, roomType, minPrice, maxPrice);
            req.setAttribute("rooms", rooms);
            req.setAttribute("search", search);
            req.setAttribute("selectedType", roomType);
            req.setAttribute("selectedMinPrice", minPrice);
            req.setAttribute("selectedMaxPrice", maxPrice);
            
            // Get room types for filter dropdown
            List<String> roomTypes = getRoomTypes();
            req.setAttribute("roomTypes", roomTypes);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        req.getRequestDispatcher("/WEB-INF/pages/user/browserooms.jsp").forward(req, resp);
    }
    
    private List<Map<String, Object>> getRooms(String search, String roomType, String minPrice, String maxPrice) {
        List<Map<String, Object>> rooms = new ArrayList<>();
        
        String sql = "SELECT * FROM rooms WHERE status = 'available'";
        
        // Add search condition
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND (room_number LIKE ? OR room_type LIKE ? OR description LIKE ?)";
        }
        
        // Add room type filter
        if (roomType != null && !roomType.trim().isEmpty() && !roomType.equals("all")) {
            sql += " AND room_type = ?";
        }
        
        // Add price range filter
        if (minPrice != null && !minPrice.trim().isEmpty()) {
            sql += " AND price_per_night >= ?";
        }
        if (maxPrice != null && !maxPrice.trim().isEmpty()) {
            sql += " AND price_per_night <= ?";
        }
        
        sql += " ORDER BY price_per_night ASC";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            int index = 1;
            
            // Set search parameters
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search + "%";
                ps.setString(index++, searchPattern);
                ps.setString(index++, searchPattern);
                ps.setString(index++, searchPattern);
            }
            
            // Set room type parameter
            if (roomType != null && !roomType.trim().isEmpty() && !roomType.equals("all")) {
                ps.setString(index++, roomType);
            }
            
            // Set price range parameters
            if (minPrice != null && !minPrice.trim().isEmpty()) {
                ps.setDouble(index++, Double.parseDouble(minPrice));
            }
            if (maxPrice != null && !maxPrice.trim().isEmpty()) {
                ps.setDouble(index++, Double.parseDouble(maxPrice));
            }
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> room = new HashMap<>();
                room.put("room_id", rs.getInt("room_id"));
                room.put("room_number", rs.getString("room_number"));
                room.put("room_type", rs.getString("room_type"));
                room.put("price_per_night", rs.getDouble("price_per_night"));
                room.put("description", rs.getString("description"));
                room.put("status", rs.getString("status"));
                room.put("image_path", rs.getString("image_path"));
                rooms.add(room);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rooms;
    }
    
    private List<String> getRoomTypes() {
        List<String> roomTypes = new ArrayList<>();
        String sql = "SELECT DISTINCT room_type FROM rooms WHERE status = 'available' ORDER BY room_type";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                roomTypes.add(rs.getString("room_type"));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return roomTypes;
    }
}