<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Dashboard - Heaven Bliss Hotel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userdashboard.css">
</head>
<body>

<!-- Hamburger Menu Button -->
<button class="hamburger" onclick="toggleSidebar()">☰</button>

<div class="user-container">
    
    <!-- Sidebar Navigation -->
    <div class="sidebar" id="sidebar">
        <div class="sidebar-brand">
            <h2>Heaven Bliss</h2>
            <p>Member Portal</p>
        </div>
        
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/user/dashboard" class="nav-link active">
                Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/user/bookings" class="nav-link">
                My Bookings
            </a>
            <a href="${pageContext.request.contextPath}/user/profile" class="nav-link">
                My Profile
            </a>
            <a href="${pageContext.request.contextPath}/user/rooms" class="nav-link">
                Browse Rooms
            </a>
        </nav>
        
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                Logout
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
                <div class="stat-info">
                    <h3>${totalBookings}</h3>
                    <p>Total Bookings</p>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-info">
                    <h3>${upcomingBookings}</h3>
                    <p>Upcoming Stays</p>
                </div>
            </div>
            
            <div class="stat-card">
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
                <c:choose>
                    <c:when test="${not empty userBookings}">
                        <c:set var="hasUpcoming" value="false" />
                        <c:forEach items="${userBookings}" var="booking">
                            <c:if test="${booking.status != 'completed' and booking.status != 'cancelled'}">
                                <c:set var="hasUpcoming" value="true" />
                                <div class="booking-card">
                                    <div class="booking-status ${booking.status}">
                                        ${booking.status}
                                    </div>
                                    <div class="booking-details">
                                        <h3>Room ${booking.room_number} - ${booking.room_type}</h3>
                                        <div class="booking-dates">
                                            <span>📅 Check In: ${booking.check_in_date}</span>
                                            <span>📅 Check Out: ${booking.check_out_date}</span>
                                        </div>
                                        <div class="booking-info">
                                            <span>👥 Guests: ${booking.guest_count}</span>
                                            <span>💰 Total: रु ${booking.total_price}</span>
                                        </div>
                                        <c:if test="${not empty booking.special_requests}">
                                            <div class="special-requests">
                                                📝 Special Request: ${booking.special_requests}
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                        <c:if test="${not hasUpcoming}">
                            <div class="empty-state">
                                <p>No upcoming reservations. <a href="${pageContext.request.contextPath}/user/rooms">Book a room now!</a></p>
                            </div>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <p>You haven't made any bookings yet. <a href="${pageContext.request.contextPath}/user/rooms">Browse available rooms</a></p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <!-- Available Rooms -->
        <div class="section">
            <div class="section-header">
                <h2>🛏️ Recommended Suites</h2>
                <a href="${pageContext.request.contextPath}/user/rooms" class="view-link">View All Rooms →</a>
            </div>
            
            <div class="rooms-grid">
                <c:choose>
                    <c:when test="${not empty availableRooms}">
                        <c:forEach items="${availableRooms}" var="room">
                            <div class="room-card">
                                <div class="room-number">Room ${room.room_number}</div>
                                <h3 class="room-type">${room.room_type}</h3>
                                <p class="room-desc">${room.description}</p>
                                <div class="room-price">
                                    रु ${room.price_per_night} <span>/ night</span>
                                </div>
                                <a href="${pageContext.request.contextPath}/user/book?room_id=${room.room_id}" class="book-btn">
                                    Book Now →
                                </a>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <p>No rooms available at the moment. Please check back later.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
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
                        <c:choose>
                            <c:when test="${not empty userProfile and not empty userProfile.created_at}">
                                ${userProfile.created_at}
                            </c:when>
                            <c:otherwise>
                                2024
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>
        </div>
        
    </div>
</div>

<script>
    function toggleSidebar() {
        var sidebar = document.getElementById('sidebar');
        sidebar.classList.toggle('open');
    }
    
    // Close sidebar when clicking outside (optional)
    document.addEventListener('click', function(event) {
        var sidebar = document.getElementById('sidebar');
        var hamburger = document.querySelector('.hamburger');
        if (sidebar.classList.contains('open')) {
            if (!sidebar.contains(event.target) && !hamburger.contains(event.target)) {
                sidebar.classList.remove('open');
            }
        }
    });
</script>

</body>
</html>