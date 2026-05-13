package com.heavenbliss.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

import com.heavenbliss.model.BookingModel;
import com.heavenbliss.service.BookingService;
import com.heavenbliss.util.SessionUtil;

@WebServlet("/book-room")
public class BookingController extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    private BookingService bookingService = new BookingService();
    private DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        System.out.println("GET request to /book-room - redirecting to home");
        resp.sendRedirect(req.getContextPath() + "/home");
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        System.out.println("=== BOOKING CONTROLLER doPost STARTED ===");
        
        try {
            // Check if user is logged in
            if (!SessionUtil.isLoggedIn(req)) {
                System.out.println("User not logged in - redirecting to login");
                resp.sendRedirect(req.getContextPath() + "/login?redirect=browse");
                return;
            }
            
            System.out.println("User is logged in - processing booking");
            
            // Get form parameters
            String roomIdStr = req.getParameter("roomId");
            String roomNumber = req.getParameter("roomNumber");
            String roomType = req.getParameter("roomType");
            String pricePerNightStr = req.getParameter("pricePerNight");
            String checkInDateStr = req.getParameter("checkInDate");
            String checkOutDateStr = req.getParameter("checkOutDate");
            String numberOfGuestsStr = req.getParameter("numberOfGuests");
            String specialRequests = req.getParameter("specialRequests");
            
            System.out.println("Room ID: " + roomIdStr);
            System.out.println("Room Type: " + roomType);
            System.out.println("Price: " + pricePerNightStr);
            System.out.println("Check-in: " + checkInDateStr);
            System.out.println("Check-out: " + checkOutDateStr);
            System.out.println("Guests: " + numberOfGuestsStr);
            
            // Parse values
            int roomId = Integer.parseInt(roomIdStr);
            double pricePerNight = Double.parseDouble(pricePerNightStr);
            LocalDate checkInDate = LocalDate.parse(checkInDateStr, formatter);
            LocalDate checkOutDate = LocalDate.parse(checkOutDateStr, formatter);
            int numberOfGuests = Integer.parseInt(numberOfGuestsStr);
            
            // Calculate total price
            long nights = ChronoUnit.DAYS.between(checkInDate, checkOutDate);
            double totalPrice = nights * pricePerNight;
            
            System.out.println("Nights: " + nights);
            System.out.println("Total Price: " + totalPrice);
            
            // Get user ID from session
            HttpSession session = req.getSession();
            Integer userId = (Integer) session.getAttribute("userId");
            
            if (userId == null) {
                System.out.println("ERROR: userId not found in session!");
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }
            
            System.out.println("User ID from session: " + userId);
            
            // Create booking object
            BookingModel booking = new BookingModel(userId, roomId, roomNumber, roomType,
                                                    checkInDate, checkOutDate, numberOfGuests,
                                                    totalPrice, specialRequests);
            
            System.out.println("Booking object created");
            
            // Save to database
            boolean success = bookingService.createBooking(booking);
            
            if (success) {
                System.out.println("Booking SAVED successfully! Booking ID: " + booking.getBookingId());
                req.setAttribute("booking", booking);
                req.setAttribute("nights", nights);
                req.getRequestDispatcher("/WEB-INF/pages/booking-confirmation.jsp").forward(req, resp);
            } else {
                System.out.println("Booking FAILED - createBooking returned false");
                resp.sendRedirect(req.getContextPath() + "/home?error=booking_failed");
            }
            
        } catch (Exception e) {
            System.out.println("EXCEPTION in doPost: " + e.getMessage());
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/home?error=" + e.getMessage());
        }
    }
}