package com.heavenbliss.util;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * CookieUtil handles all cookie operations for Remember Me functionality
 * Based on Week 7 Lecture
 * 
 * @author Tanisha Maharjan
 */
public class CookieUtil {
    
    /**
     * Add a cookie to the response
     * @param response HttpServletResponse
     * @param name Cookie name
     * @param value Cookie value
     * @param maxAge Cookie expiry in seconds (7 days = 7*24*60*60)
     */
    public static void addCookie(HttpServletResponse response, String name, String value, int maxAge) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAge);
        cookie.setPath("/");
        cookie.setHttpOnly(true); // Security: prevents JavaScript access
        response.addCookie(cookie);
    }
    
    /**
     * Get cookie value by name
     * @param request HttpServletRequest
     * @param name Cookie name
     * @return Cookie value or null if not found
     */
    public static String getCookie(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(name)) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }
    
    /**
     * Delete a cookie (expire immediately)
     * @param response HttpServletResponse
     * @param name Cookie name
     */
    public static void deleteCookie(HttpServletResponse response, String name) {
        Cookie cookie = new Cookie(name, "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
    }
}