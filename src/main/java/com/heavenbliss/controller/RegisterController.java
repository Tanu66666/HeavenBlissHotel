package com.heavenbliss.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import com.heavenbliss.model.UserModel;
import com.heavenbliss.service.RegisterService;
import com.heavenbliss.util.PasswordUtil;

/**
 * RegisterController handles user registration
 * GET - Shows registration form
 * POST - Processes registration data
 * 
 * @author Tanisha Maharjan
 */
@WebServlet(asyncSupported = true, urlPatterns = {"/register"})
@MultipartConfig(maxFileSize = 16177215) // 16MB max file size
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private RegisterService registerService = new RegisterService();
    
    /**
     * GET /register - Show registration page
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
    }
    
    /**
     * POST /register - Process registration form
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        // Get form data
        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        
        // Validation - Check if any field is empty
        if (fullName == null || fullName.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            
            req.setAttribute("error", "All fields are required!");
            req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
            return;
        }
        
        // Email format validation
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            req.setAttribute("error", "Please enter a valid email address!");
            req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
            return;
        }
        
        // Phone number validation (10 digits)
        if (!phone.matches("\\d{10}")) {
            req.setAttribute("error", "Please enter a valid 10-digit phone number!");
            req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
            return;
        }
        
        // Password length validation
        if (password.length() < 6) {
            req.setAttribute("error", "Password must be at least 6 characters long!");
            req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
            return;
        }
        
        // Check if email already exists
        if (registerService.isEmailExists(email)) {
            req.setAttribute("error", "Email already registered! Please use different email or login.");
            req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
            return;
        }
        
        // Check if phone already exists
        if (registerService.isPhoneExists(phone)) {
            req.setAttribute("error", "Phone number already registered!");
            req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
            return;
        }
        
        // Hash the password for security
        String hashedPassword = PasswordUtil.hashPassword(password);
        
        // Create user model
        UserModel user = new UserModel();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setPassword(hashedPassword);
        user.setRole("guest"); // Default role for new users
        user.setLoginAttempts(0);
        user.setLocked(false);
        
        // Save to database
        boolean isRegistered = registerService.registerUser(user);
        
        if (isRegistered) {
            req.setAttribute("success", "Registration successful! Please login to continue.");
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("error", "Registration failed! Please try again.");
            req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
        }
    }
}