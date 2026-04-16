package com.heavenbliss.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.heavenbliss.model.UserModel;
import com.heavenbliss.service.LoginService;
import com.heavenbliss.util.CookieUtil;
import com.heavenbliss.util.SessionUtil;
import com.heavenbliss.util.PasswordUtil;

/**
 * LoginController handles all login requests.
 * GET  → shows login.jsp
 * POST → checks credentials and redirects by role
 * 
 * ADMIN: admin@heavenbliss.com / Admin@123
 * GUEST: checked from database
 * 
 * Features:
 * - Session management
 * - Remember Me cookie 
 * - Failed login attempt tracking
 * - Account locking after 5 attempts
 * 
 * @author Tanisha Maharjan
 */
@WebServlet(asyncSupported = true, urlPatterns = {"/login"})
public class LoginController extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    
    // Hardcoded admin credentials
    private static final String ADMIN_EMAIL = "admin@heavenbliss.com";
    private static final String ADMIN_PASSWORD = "Admin@123";
    
    private LoginService loginService = new LoginService();

    /**
     * GET /login → Show login page
     * Checks for existing session and Remember Me cookie
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Check if user is already logged in via session
        if (SessionUtil.isLoggedIn(req)) {
            String role = SessionUtil.getUserRole(req);
            if ("admin".equals(role)) {
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else if ("guest".equals(role)) {
                resp.sendRedirect(req.getContextPath() + "/user/dashboard");
            }
            return;
        }
        
        // Check for "Remember Me" cookie to auto-fill email
        String rememberedEmail = CookieUtil.getCookie(req, "remember_email");
        if (rememberedEmail != null) {
            req.setAttribute("rememberedEmail", rememberedEmail);
            req.setAttribute("rememberChecked", true);
        }
        
        // Forward to login page
        req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
    }

    /**
     * POST /login → Authenticate user
     * Handles admin login, guest login, remember me, and session creation
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Get form values
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String remember = req.getParameter("remember"); // "on" if checked

        // Validation - Check if fields are empty
        if (email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Email and password are required.");
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
            return;
        }

        email = email.trim();
        password = password.trim();

        // ===== CHECK HARDCODED ADMIN FIRST =====
        if (email.equals(ADMIN_EMAIL) && password.equals(ADMIN_PASSWORD)) {
            
            // Create admin session using SessionUtil
            SessionUtil.setAttribute(req, "userEmail", email);
            SessionUtil.setAttribute(req, "userName", "System Administrator");
            SessionUtil.setAttribute(req, "userRole", "admin");
            SessionUtil.setAttribute(req, "user", "admin");
            
            // Handle Remember Me cookie
            if (remember != null && remember.equals("on")) {
                CookieUtil.addCookie(resp, "remember_email", email, 7 * 24 * 60 * 60); // 7 days
            } else {
                CookieUtil.deleteCookie(resp, "remember_email");
            }
            
            // Redirect to admin dashboard
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }

        // ===== CHECK REGULAR USER FROM DATABASE =====
        UserModel user = loginService.loginUser(email, password);

        if (user != null) {
            // Create guest session using SessionUtil
            SessionUtil.setAttribute(req, "userId", user.getUserId());
            SessionUtil.setAttribute(req, "userName", user.getFullName());
            SessionUtil.setAttribute(req, "userEmail", user.getEmail());
            SessionUtil.setAttribute(req, "userRole", user.getRole()); // "guest"
            SessionUtil.setAttribute(req, "user", user);
            
            // Handle Remember Me cookie
            if (remember != null && remember.equals("on")) {
                CookieUtil.addCookie(resp, "remember_email", email, 7 * 24 * 60 * 60); // 7 days
            } else {
                CookieUtil.deleteCookie(resp, "remember_email");
            }
            
            // Redirect to user/guest dashboard
            resp.sendRedirect(req.getContextPath() + "/user/dashboard");
            
        } else {
            // Check if account is locked
            if (loginService.isAccountLocked(email)) {
                req.setAttribute("error", "Your account has been locked due to multiple failed attempts. Please contact admin.");
            } else {
                req.setAttribute("error", "Invalid email or password. Please try again.");
            }
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
        }
    }
}