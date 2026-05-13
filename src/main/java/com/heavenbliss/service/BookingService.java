package com.heavenbliss.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.heavenbliss.config.DbConfig;
import com.heavenbliss.model.BookingModel;

public class BookingService {
    
    /**
     * Create a new booking
     */
    public boolean createBooking(BookingModel booking) {
        String sql = "INSERT INTO bookings (user_id, room_id, room_number, room_type, " +
                     "check_in_date, check_out_date, guest_count, total_price, " +
                     "status, booking_date, special_requests) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, booking.getUserId());
            ps.setInt(2, booking.getRoomId());
            ps.setString(3, booking.getRoomNumber());
            ps.setString(4, booking.getRoomType());
            ps.setDate(5, java.sql.Date.valueOf(booking.getCheckInDate()));
            ps.setDate(6, java.sql.Date.valueOf(booking.getCheckOutDate()));
            ps.setInt(7, booking.getNumberOfGuests());
            ps.setDouble(8, booking.getTotalPrice());
            ps.setString(9, booking.getStatus());
            ps.setTimestamp(10, Timestamp.valueOf(booking.getBookingDate().atStartOfDay()));
            ps.setString(11, booking.getSpecialRequests());
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    booking.setBookingId(rs.getInt(1));
                }
                return true;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Get all bookings for a specific user
     */
    public List<BookingModel> getBookingsByUserId(int userId) {
        List<BookingModel> bookings = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE user_id = ? ORDER BY booking_date DESC";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                BookingModel booking = new BookingModel();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setRoomId(rs.getInt("room_id"));
                booking.setRoomNumber(rs.getString("room_number"));
                booking.setRoomType(rs.getString("room_type"));
                booking.setCheckInDate(rs.getDate("check_in_date").toLocalDate());
                booking.setCheckOutDate(rs.getDate("check_out_date").toLocalDate());
                booking.setNumberOfGuests(rs.getInt("guest_count"));
                booking.setTotalPrice(rs.getDouble("total_price"));
                booking.setStatus(rs.getString("status"));
                booking.setBookingDate(rs.getTimestamp("booking_date").toLocalDateTime().toLocalDate());
                booking.setSpecialRequests(rs.getString("special_requests"));
                bookings.add(booking);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bookings;
    }
    
    /**
     * Get a single booking by ID
     */
    public BookingModel getBookingById(int bookingId) {
        String sql = "SELECT * FROM bookings WHERE booking_id = ?";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                BookingModel booking = new BookingModel();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setRoomId(rs.getInt("room_id"));
                booking.setRoomNumber(rs.getString("room_number"));
                booking.setRoomType(rs.getString("room_type"));
                booking.setCheckInDate(rs.getDate("check_in_date").toLocalDate());
                booking.setCheckOutDate(rs.getDate("check_out_date").toLocalDate());
                booking.setNumberOfGuests(rs.getInt("guest_count"));
                booking.setTotalPrice(rs.getDouble("total_price"));
                booking.setStatus(rs.getString("status"));
                booking.setBookingDate(rs.getTimestamp("booking_date").toLocalDateTime().toLocalDate());
                booking.setSpecialRequests(rs.getString("special_requests"));
                return booking;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Update booking status
     */
    public boolean updateBookingStatus(int bookingId, String status) {
        String sql = "UPDATE bookings SET status = ? WHERE booking_id = ?";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            
            return ps.executeUpdate() > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Cancel a booking
     */
    public boolean cancelBooking(int bookingId) {
        return updateBookingStatus(bookingId, "cancelled");
    }
}