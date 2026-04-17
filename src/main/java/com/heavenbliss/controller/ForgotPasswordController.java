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

import com.heavenbliss.config.DbConfig;
import com.heavenbliss.util.PasswordUtil;

@WebServlet(asyncSupported = true, urlPatterns = {"/forgotpassword"})
public class ForgotPasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Step 1: Show email input page
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/forgotpassword.jsp").forward(req, resp);
    }
    
    // Step 2: Process requests based on step
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        String step = req.getParameter("step");
        
        if (step == null || step.equals("checkEmail")) {
            // Step 2: Check if email exists and show security question
            checkEmail(req, resp);
        } else if (step.equals("resetPassword")) {
            // Step 3: Reset password
            resetPassword(req, resp);
        }
    }
    
    private void checkEmail(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        String email = req.getParameter("email");
        
        if (email == null || email.trim().isEmpty()) {
            req.setAttribute("error", "Please enter your email address");
            req.getRequestDispatcher("/WEB-INF/pages/forgotpassword.jsp").forward(req, resp);
            return;
        }
        
        String sql = "SELECT email, security_question FROM users WHERE email = ?";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                // Email exists - store in session and show security question
                HttpSession session = req.getSession();
                session.setAttribute("resetEmail", email);
                req.setAttribute("securityQuestion", rs.getString("security_question"));
                req.setAttribute("showQuestion", true);
                req.getRequestDispatcher("/WEB-INF/pages/forgotpassword.jsp").forward(req, resp);
            } else {
                // Email not found
                req.setAttribute("error", "Email address not found in our records");
                req.getRequestDispatcher("/WEB-INF/pages/forgotpassword.jsp").forward(req, resp);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Database error. Please try again.");
            req.getRequestDispatcher("/WEB-INF/pages/forgotpassword.jsp").forward(req, resp);
        }
    }
    
    private void resetPassword(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("resetEmail");
        String securityAnswer = req.getParameter("securityAnswer");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");
        
        // Validation
        if (email == null) {
            req.setAttribute("error", "Session expired. Please start over.");
            req.getRequestDispatcher("/WEB-INF/pages/forgotpassword.jsp").forward(req, resp);
            return;
        }
        
        if (securityAnswer == null || securityAnswer.trim().isEmpty()) {
            req.setAttribute("error", "Please answer the security question");
            req.setAttribute("showQuestion", true);
            req.getRequestDispatcher("/WEB-INF/pages/forgotpassword.jsp").forward(req, resp);
            return;
        }
        
        if (newPassword == null || newPassword.length() < 6) {
            req.setAttribute("error", "Password must be at least 6 characters");
            req.setAttribute("showQuestion", true);
            req.getRequestDispatcher("/WEB-INF/pages/forgotpassword.jsp").forward(req, resp);
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("error", "Passwords do not match");
            req.setAttribute("showQuestion", true);
            req.getRequestDispatcher("/WEB-INF/pages/forgotpassword.jsp").forward(req, resp);
            return;
        }
        
        // Verify security answer and update password
        String sql = "SELECT security_answer FROM users WHERE email = ?";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                String storedAnswer = rs.getString("security_answer");
                
                if (storedAnswer != null && storedAnswer.equalsIgnoreCase(securityAnswer.trim())) {
                    // Answer correct - update password
                    String hashedPassword = PasswordUtil.hashPassword(newPassword);
                    updatePassword(email, hashedPassword);
                    
                    session.removeAttribute("resetEmail");
                    req.setAttribute("success", "Password reset successful! Please login with your new password.");
                    req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
                } else {
                    req.setAttribute("error", "Security answer is incorrect");
                    req.setAttribute("showQuestion", true);
                    req.getRequestDispatcher("/WEB-INF/pages/forgotpassword.jsp").forward(req, resp);
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Database error. Please try again.");
            req.getRequestDispatcher("/WEB-INF/pages/forgotpassword.jsp").forward(req, resp);
        }
    }
    
    private void updatePassword(String email, String hashedPassword) {
        String sql = "UPDATE users SET password = ?, login_attempts = 0, is_locked = FALSE WHERE email = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, hashedPassword);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}