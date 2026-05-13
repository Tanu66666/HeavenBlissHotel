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

@WebServlet(asyncSupported = true, urlPatterns = {"/packages"})
public class PackagesController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        try {
            List<Map<String, Object>> packages = getAllPackages();
            req.setAttribute("packages", packages);
            req.getRequestDispatcher("/WEB-INF/pages/packages.jsp").forward(req, resp);
            
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }
    
    private List<Map<String, Object>> getAllPackages() {
        List<Map<String, Object>> packages = new ArrayList<>();
        String sql = "SELECT * FROM packages WHERE status = 'active' ORDER BY package_id";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Map<String, Object> pkg = new HashMap<>();
                pkg.put("package_id", rs.getInt("package_id"));
                pkg.put("package_name", rs.getString("package_name"));
                pkg.put("description", rs.getString("description"));
                pkg.put("total_price", rs.getDouble("total_price"));
                pkg.put("discount_percent", rs.getInt("discount_percent"));
                pkg.put("image_path", rs.getString("image_path"));
                pkg.put("status", rs.getString("status"));
                
                // Calculate discounted price
                double originalPrice = rs.getDouble("total_price");
                int discount = rs.getInt("discount_percent");
                double discountedPrice = originalPrice - (originalPrice * discount / 100);
                pkg.put("discounted_price", discountedPrice);
                
                // Get package items (rooms and activities included)
                pkg.put("items", getPackageItems(rs.getInt("package_id")));
                
                packages.add(pkg);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return packages;
    }
    
    private List<Map<String, Object>> getPackageItems(int packageId) {
        List<Map<String, Object>> items = new ArrayList<>();
        String sql = "SELECT * FROM package_items WHERE package_id = ?";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, packageId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> item = new HashMap<>();
                item.put("item_id", rs.getInt("item_id"));
                item.put("item_type", rs.getString("item_type"));
                item.put("item_id_ref", rs.getInt("item_id_ref"));
                items.add(item);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return items;
    }
}