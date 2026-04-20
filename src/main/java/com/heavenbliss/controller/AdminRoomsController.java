package com.heavenbliss.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.heavenbliss.config.DbConfig;

@WebServlet(asyncSupported = true, urlPatterns = {"/admin/rooms"})
@MultipartConfig(maxFileSize = 16177215)
public class AdminRoomsController extends HttpServlet {
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
                int roomId = Integer.parseInt(req.getParameter("id"));
                Map<String, Object> room = getRoomById(roomId);
                req.setAttribute("room", room);
                req.setAttribute("isEdit", true);
                req.getRequestDispatcher("/WEB-INF/pages/admin/roomform.jsp").forward(req, resp);
                
            } else if ("delete".equals(action)) {
                // Delete room
                int roomId = Integer.parseInt(req.getParameter("id"));
                deleteRoom(roomId);
                resp.sendRedirect(req.getContextPath() + "/admin/rooms");
                
            } else {
                // Show all rooms
                List<Map<String, Object>> rooms = getAllRooms();
                req.setAttribute("rooms", rooms);
                req.getRequestDispatcher("/WEB-INF/pages/admin/adminrooms.jsp").forward(req, resp);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/rooms");
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
            if ("add".equals(action)) {
                addRoom(req, resp);
            } else if ("update".equals(action)) {
                updateRoom(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin/rooms");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/rooms");
        }
    }
    
    private List<Map<String, Object>> getAllRooms() {
        List<Map<String, Object>> rooms = new ArrayList<>();
        String sql = "SELECT * FROM rooms ORDER BY room_number ASC";
        
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
                room.put("image_path", rs.getString("image_path"));
                rooms.add(room);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rooms;
    }
    
    private Map<String, Object> getRoomById(int roomId) {
        Map<String, Object> room = new HashMap<>();
        String sql = "SELECT * FROM rooms WHERE room_id = ?";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                room.put("room_id", rs.getInt("room_id"));
                room.put("room_number", rs.getString("room_number"));
                room.put("room_type", rs.getString("room_type"));
                room.put("price_per_night", rs.getDouble("price_per_night"));
                room.put("description", rs.getString("description"));
                room.put("status", rs.getString("status"));
                room.put("image_path", rs.getString("image_path"));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return room;
    }
    
    private void addRoom(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        String roomNumber = req.getParameter("room_number");
        String roomType = req.getParameter("room_type");
        double pricePerNight = Double.parseDouble(req.getParameter("price_per_night"));
        String description = req.getParameter("description");
        String status = req.getParameter("status");
        
        String sql = "INSERT INTO rooms (room_number, room_type, price_per_night, description, status) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, roomNumber);
            ps.setString(2, roomType);
            ps.setDouble(3, pricePerNight);
            ps.setString(4, description);
            ps.setString(5, status);
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        resp.sendRedirect(req.getContextPath() + "/admin/rooms");
    }
    
    private void updateRoom(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        int roomId = Integer.parseInt(req.getParameter("room_id"));
        String roomNumber = req.getParameter("room_number");
        String roomType = req.getParameter("room_type");
        double pricePerNight = Double.parseDouble(req.getParameter("price_per_night"));
        String description = req.getParameter("description");
        String status = req.getParameter("status");
        
        String sql = "UPDATE rooms SET room_number = ?, room_type = ?, price_per_night = ?, description = ?, status = ? WHERE room_id = ?";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, roomNumber);
            ps.setString(2, roomType);
            ps.setDouble(3, pricePerNight);
            ps.setString(4, description);
            ps.setString(5, status);
            ps.setInt(6, roomId);
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        resp.sendRedirect(req.getContextPath() + "/admin/rooms");
    }
    
    private void deleteRoom(int roomId) {
        String sql = "DELETE FROM rooms WHERE room_id = ?";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, roomId);
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}