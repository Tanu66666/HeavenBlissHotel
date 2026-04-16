package com.heavenbliss.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import com.heavenbliss.util.CookieUtil;
import com.heavenbliss.util.SessionUtil;

/**
 * LogoutController handles user logout
 * Destroys session and removes Remember Me cookie
 * Based on Week 7 Lecture
 * 
 * @author Tanisha Maharjan
 */
@WebServlet(asyncSupported = true, urlPatterns = {"/logout"})
public class LogoutController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        // Invalidate session (destroy all session data)
        SessionUtil.invalidateSession(req);
        
        // Delete Remember Me cookie
        CookieUtil.deleteCookie(resp, "remember_email");
        
        // Redirect to login page with logout message
        resp.sendRedirect(req.getContextPath() + "/login");
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }
}