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

@WebServlet(asyncSupported = true, urlPatterns = {"/login"})
public class LoginController extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    
    private static final String ADMIN_EMAIL = "admin@heavenbliss.com";
    private static final String ADMIN_PASSWORD = "Admin@123";
    
    private LoginService loginService = new LoginService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (SessionUtil.isLoggedIn(req)) {
            String role = SessionUtil.getUserRole(req);
            if ("admin".equals(role)) {
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else {
                resp.sendRedirect(req.getContextPath() + "/user/dashboard");
            }
            return;
        }
        
        String redirect = req.getParameter("redirect");
        if (redirect != null && !redirect.isEmpty()) {
            HttpSession session = req.getSession(true);
            session.setAttribute("redirectAfterLogin", redirect);
        }
        
        String rememberedEmail = CookieUtil.getCookie(req, "remember_email");
        if (rememberedEmail != null) {
            req.setAttribute("rememberedEmail", rememberedEmail);
            req.setAttribute("rememberChecked", true);
        }

        req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String remember = req.getParameter("remember");

        if (email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Email and password are required.");
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
            return;
        }

        email = email.trim();
        password = password.trim();

        // Check Admin
        if (email.equals(ADMIN_EMAIL) && password.equals(ADMIN_PASSWORD)) {
            
            SessionUtil.setAttribute(req, "userEmail", email);
            SessionUtil.setAttribute(req, "userName", "System Administrator");
            SessionUtil.setAttribute(req, "userRole", "admin");
            SessionUtil.setAttribute(req, "user", "admin");
            
            if (remember != null && remember.equals("on")) {
                CookieUtil.addCookie(resp, "remember_email", email, 7 * 24 * 60 * 60);
            } else {
                CookieUtil.deleteCookie(resp, "remember_email");
            }
            
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }

        // Check Regular User
        UserModel user = loginService.loginUser(email, password);

        if (user != null) {
            SessionUtil.setAttribute(req, "userId", user.getUserId());
            SessionUtil.setAttribute(req, "userName", user.getFullName());
            SessionUtil.setAttribute(req, "userEmail", user.getEmail());
            SessionUtil.setAttribute(req, "userRole", user.getRole());
            SessionUtil.setAttribute(req, "user", user);
            
            if (remember != null && remember.equals("on")) {
                CookieUtil.addCookie(resp, "remember_email", email, 7 * 24 * 60 * 60);
            } else {
                CookieUtil.deleteCookie(resp, "remember_email");
            }
            
            // Check redirect
            HttpSession session = req.getSession();
            String redirect = (String) session.getAttribute("redirectAfterLogin");
            
            if (redirect != null) {
                session.removeAttribute("redirectAfterLogin");
                
                if (redirect.equals("browse")) {
                    resp.sendRedirect(req.getContextPath() + "/user/rooms");
                } else if (redirect.equals("activities")) {
                    resp.sendRedirect(req.getContextPath() + "/activities");
                } else if (redirect.equals("packages")) {
                    resp.sendRedirect(req.getContextPath() + "/packages");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/user/dashboard");
                }
            } else {
                resp.sendRedirect(req.getContextPath() + "/user/dashboard");
            }
            return;
            
        } else {
            if (loginService.isAccountLocked(email)) {
                req.setAttribute("error", "Your account has been locked. Please contact admin.");
            } else {
                req.setAttribute("error", "Invalid email or password.");
            }
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
        }
    }
}