package com.heavenbliss.model;

import java.time.LocalDate;

public class BookingModel {
    private int bookingId;
    private int userId;
    private int roomId;
    private String roomNumber;
    private String roomType;
    private LocalDate checkInDate;
    private LocalDate checkOutDate;
    private int numberOfGuests;
    private double totalPrice;
    private String status;
    private LocalDate bookingDate;
    private String specialRequests;
    
    // Constructors
    public BookingModel() {}
    
    public BookingModel(int userId, int roomId, String roomNumber, String roomType, LocalDate checkInDate, LocalDate checkOutDate, int numberOfGuests, double totalPrice, String specialRequests) {
        this.userId = userId;
        this.roomId = roomId;
        this.roomNumber = roomNumber;
        this.roomType = roomType;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.numberOfGuests = numberOfGuests;
        this.totalPrice = totalPrice;
        this.specialRequests = specialRequests;
        this.status = "pending";
        this.bookingDate = LocalDate.now();
    }
    
    // Getters and Setters
    public int getBookingId() 
    { 
    	return bookingId; 
    }
    public void setBookingId(int bookingId) 
    { 
    	this.bookingId = bookingId; 
    }
    
    public int getUserId() 
    { 
    	return userId; 
    }
    public void setUserId(int userId) 
    { 
    	this.userId = userId; 
    }
    
    public int getRoomId() 
    { 
    	return roomId; 
    }
    public void setRoomId(int roomId) 
    { 
    	this.roomId = roomId; 
    }
    
    public String getRoomNumber() 
    { 
    	return roomNumber; 
    }
    public void setRoomNumber(String roomNumber) 
    { 
    	this.roomNumber = roomNumber;
    }
    
    public String getRoomType() 
    { 
    	return roomType; 
    }
    public void setRoomType(String roomType) 
    { 
    	this.roomType = roomType; 
    }
    
    public LocalDate getCheckInDate() 
    { 
    	return checkInDate; 
    }
    public void setCheckInDate(LocalDate checkInDate) 
    { 
    	this.checkInDate = checkInDate;
    }
    
    public LocalDate getCheckOutDate() 
    { 
    	return checkOutDate; 
    }
    public void setCheckOutDate(LocalDate checkOutDate) 
    { 
    	this.checkOutDate = checkOutDate; 
    }
    
    public int getNumberOfGuests()
    { 
    	return numberOfGuests;
    }
    public void setNumberOfGuests(int numberOfGuests) 
    {
    	this.numberOfGuests = numberOfGuests;
    }
    
    public double getTotalPrice() 
    { 
    	return totalPrice; 
    }
    public void setTotalPrice(double totalPrice)
    { 
    	this.totalPrice = totalPrice;
    }
    
    public String getStatus() 
    { 
    	return status;
    }
    public void setStatus(String status) 
    { 
    	this.status = status; 
    }
    
    public LocalDate getBookingDate() 
    { 
    	return bookingDate; 
    }
    public void setBookingDate(LocalDate bookingDate)
    {
    	this.bookingDate = bookingDate; 
    }
    
    public String getSpecialRequests() 
    { 
    	return specialRequests; 
    }
    public void setSpecialRequests(String specialRequests) 
    { 
    	this.specialRequests = specialRequests; 
    }
}