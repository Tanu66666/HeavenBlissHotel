<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Dashboard - Heaven Bliss Hotel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userdashboard.css">
</head>
<body>

<div class="user-container">
    
    <!-- Sidebar Navigation -->
    <div class="sidebar">
        <div class="sidebar-brand">
            <h2>Heaven Bliss</h2>
            <p>Member Portal</p>
        </div>
        
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/user/dashboard" class="nav-link active">
                <span>📊</span> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/user/bookings" class="nav-link">
                <span>📅</span> My Bookings
            </a>
            <a href="${pageContext.request.contextPath}/user/profile" class="nav-link">
                <span>👤</span> My Profile
            </a>
            <a href="${pageContext.request.contextPath}/user/rooms" class="nav-link">
                <span>🛏️</span> Browse Rooms
            </a>
        </nav>
        
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                <span>🚪</span> Logout
            </a>
        </div>
    </div>
    
    <!-- Main Content -->
    <div class="main-content">
        
        <!-- Welcome Header -->
        <div class="welcome-header">
            <div>
                <h1>Welcome back, ${sessionScope.userName}!</h1>
                <p>Your stay is choreographed to perfection.</p>
            </div>
        </div>
        
        <!-- Stats Cards -->
        <div class="stats-cards">
            <div class="stat-card">
                <div class="stat-icon">📅</div>
                <div class="stat-info">
                    <h3>${totalBookings}</h3>
                    <p>Total Bookings</p>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">⏳</div>
                <div class="stat-info">
                    <h3>${upcomingBookings}</h3>
                    <p>Upcoming Stays</p>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">✅</div>
                <div class="stat-info">
                    <h3>${completedBookings}</h3>
                    <p>Completed Stays</p>
                </div>
            </div>
        </div>
        
        <!-- My Upcoming Reservations -->
        <div class="section">
            <div class="section-header">
                <h2>📋 My Upcoming Reservations</h2>
                <a href="${pageContext.request.contextPath}/user/bookings" class="view-link">View All →</a>
            </div>
            
            <div class="bookings-list">
                <% 
                List<Map<String, Object>> userBookings = (List<Map<String, Object>>) request.getAttribute("userBookings");
                if (userBookings != null && !userBookings.isEmpty()) {
                    boolean hasUpcoming = false;
                    for (Map<String, Object> booking : userBookings) {
                        String status = (String) booking.get("status");
                        if (!"completed".equals(status) && !"cancelled".equals(status)) {
                            hasUpcoming = true;
                %>
                <div class="booking-card">
                    <div class="booking-status <%= status %>">
                        <%= status %>
                    </div>
                    <div class="booking-details">
                        <h3>Room <%= booking.get("room_number") %> - <%= booking.get("room_type") %></h3>
                        <div class="booking-dates">
                            <span>📅 Check In: <%= booking.get("check_in_date") %></span>
                            <span>📅 Check Out: <%= booking.get("check_out_date") %></span>
                        </div>
                        <div class="booking-info">
                            <span>👥 Guests: <%= booking.get("guest_count") %></span>
                            <span>💰 Total: रु <%= booking.get("total_price") %></span>
                        </div>
                        <% if (booking.get("special_requests") != null && !booking.get("special_requests").toString().isEmpty()) { %>
                            <div class="special-requests">
                                📝 Special Request: <%= booking.get("special_requests") %>
                            </div>
                        <% } %>
                    </div>
                </div>
                <% 
                        }
                    }
                    if (!hasUpcoming) {
                %>
                <div class="empty-state">
                    <p>No upcoming reservations. <a href="${pageContext.request.contextPath}/user/rooms">Book a room now!</a></p>
                </div>
                <% 
                    }
                } else { 
                %>
                <div class="empty-state">
                    <p>You haven't made any bookings yet. <a href="${pageContext.request.contextPath}/user/rooms">Browse available rooms</a></p>
                </div>
                <% } %>
            </div>
        </div>
        
        <!-- Available Rooms -->
        <div class="section">
            <div class="section-header">
                <h2>🛏️ Recommended Suites</h2>
                <a href="${pageContext.request.contextPath}/user/rooms" class="view-link">View All Rooms →</a>
            </div>
            
            <div class="rooms-grid">
                <% 
                List<Map<String, Object>> availableRooms = (List<Map<String, Object>>) request.getAttribute("availableRooms");
                if (availableRooms != null && !availableRooms.isEmpty()) {
                    for (Map<String, Object> room : availableRooms) {
                %>
                <div class="room-card">
                    <div class="room-number">Room <%= room.get("room_number") %></div>
                    <h3 class="room-type"><%= room.get("room_type") %></h3>
                    <p class="room-desc"><%= room.get("description") %></p>
                    <div class="room-price">
                        रु <%= room.get("price_per_night") %> <span>/ night</span>
                    </div>
                    <a href="${pageContext.request.contextPath}/user/book?room_id=<%= room.get("room_id") %>" class="book-btn">
                        Book Now →
                    </a>
                </div>
                <% 
                    }
                } else { 
                %>
                <div class="empty-state">
                    <p>No rooms available at the moment. Please check back later.</p>
                </div>
                <% } %>
            </div>
        </div>
        
        <!-- Profile Quick View -->
        <div class="profile-card">
            <div class="profile-header">
                <h2>👤 Your Profile</h2>
                <a href="${pageContext.request.contextPath}/user/profile" class="edit-link">Edit Profile →</a>
            </div>
            <div class="profile-info">
                <div class="info-row">
                    <span class="info-label">Full Name:</span>
                    <span class="info-value">${sessionScope.userName}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Email:</span>
                    <span class="info-value">${sessionScope.userEmail}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Member Since:</span>
                    <span class="info-value">
                        <% 
                        Map<String, Object> userProfile = (Map<String, Object>) request.getAttribute("userProfile");
                        if (userProfile != null && userProfile.get("created_at") != null) {
                            out.print(userProfile.get("created_at"));
                        } else {
                            out.print("2024");
                        }
                        %>
                    </span>
                </div>
            </div>
        </div>
        
    </div>
</div>

</body>
</html>