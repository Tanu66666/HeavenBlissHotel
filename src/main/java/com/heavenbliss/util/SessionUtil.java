package com.heavenbliss.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/**
 * SessionUtil handles all session operations
 * Based on Week 7 Lecture
 * 
 * @author Tanisha Maharjan
 */
public class SessionUtil {
    
    /**
     * Create new session and set attribute
     * @param request HttpServletRequest
     * @param name Attribute name
     * @param value Attribute value
     */
    public static void setAttribute(HttpServletRequest request, String name, Object value) {
        HttpSession session = request.getSession(true);
        session.setAttribute(name, value);
    }
    
    /**
     * Get attribute from session
     * @param request HttpServletRequest
     * @param name Attribute name
     * @return Attribute value or null
     */
    public static Object getAttribute(HttpServletRequest request, String name) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return session.getAttribute(name);
        }
        return null;
    }
    
    /**
     * Remove attribute from session
     * @param request HttpServletRequest
     * @param name Attribute name
     */
    public static void removeAttribute(HttpServletRequest request, String name) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute(name);
        }
    }
    
    /**
     * Invalidate (destroy) the session
     * @param request HttpServletRequest
     */
    public static void invalidateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }
    
    /**
     * Check if user is logged in
     * @param request HttpServletRequest
     * @return true if logged in, false otherwise
     */
    public static boolean isLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return session.getAttribute("user") != null;
        }
        return false;
    }
    
    /**
     * Get user role from session
     * @param request HttpServletRequest
     * @return User role or null
     */
    public static String getUserRole(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (String) session.getAttribute("userRole");
        }
        return null;
    }
    
    /**
     * Get user email from session
     * @param request HttpServletRequest
     * @return User email or null
     */
    public static String getUserEmail(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (String) session.getAttribute("userEmail");
        }
        return null;
    }
    
    /**
     * Get user name from session
     * @param request HttpServletRequest
     * @return User name or null
     */
    public static String getUserName(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (String) session.getAttribute("userName");
        }
        return null;
    }
}