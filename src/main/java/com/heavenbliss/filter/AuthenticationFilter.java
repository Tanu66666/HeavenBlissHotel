package com.heavenbliss.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * AuthenticationFilter checks if user is logged in before accessing protected pages
 * Based on Week 7 Lecture
 * 
 * Protected URLs:
 * - /admin/* (admin dashboard and admin pages)
 * - /user/* (user dashboard and user pages)
 * 
 * @author Tanisha Maharjan
 */
@WebFilter(urlPatterns = {"/admin/*", "/user/*"})
public class AuthenticationFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("AuthenticationFilter initialized");
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        
        // Get session (don't create if doesn't exist)
        HttpSession session = req.getSession(false);
        
        // Check if user is logged in
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        
        if (isLoggedIn) {
            // User is logged in, allow access to requested page
            System.out.println("Authenticated access to: " + req.getRequestURI());
            chain.doFilter(request, response);
        } else {
            // User not logged in, redirect to login page
            System.out.println("Unauthorized access attempt to: " + req.getRequestURI());
            res.sendRedirect(req.getContextPath() + "/login");
        }
    }
    
    @Override
    public void destroy() {
        System.out.println("AuthenticationFilter destroyed");
    }
}