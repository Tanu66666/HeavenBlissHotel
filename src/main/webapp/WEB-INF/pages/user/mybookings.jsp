<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - Heaven Bliss Hotel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userdashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mybookings.css">
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
            <a href="${pageContext.request.contextPath}/user/dashboard" class="nav-link">
                Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/user/bookings" class="nav-link active">
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
        
        <!-- Header -->
        <div class="welcome-header">
            <div>
                <h1>My Bookings</h1>
                <p>View and manage your reservations</p>
            </div>
        </div>
        
        <!-- Statistics -->
        <div class="stats-row">
            <div class="stat-badge">📋 Total: <span>${totalBookings}</span></div>
            <div class="stat-badge">⏳ Upcoming: <span>${upcomingCount}</span></div>
            <div class="stat-badge">✅ Completed: <span>${completedCount}</span></div>
            <div class="stat-badge">❌ Cancelled: <span>${cancelledCount}</span></div>
        </div>
        
        <!-- Filter Tabs -->
        <div class="filter-tabs">
            <a href="${pageContext.request.contextPath}/user/bookings?filter=all" 
               class="filter-tab ${currentFilter == 'all' ? 'active' : ''}">All Bookings</a>
            <a href="${pageContext.request.contextPath}/user/bookings?filter=upcoming" 
               class="filter-tab ${currentFilter == 'upcoming' ? 'active' : ''}">Upcoming</a>
            <a href="${pageContext.request.contextPath}/user/bookings?filter=completed" 
               class="filter-tab ${currentFilter == 'completed' ? 'active' : ''}">Completed</a>
            <a href="${pageContext.request.contextPath}/user/bookings?filter=cancelled" 
               class="filter-tab ${currentFilter == 'cancelled' ? 'active' : ''}">Cancelled</a>
        </div>
        
        <!-- Bookings List -->
        <div class="section">
            <div class="section-header">
                <h2>📋 Your Reservations</h2>
            </div>
            
            <div class="bookings-list">
                <c:choose>
                    <c:when test="${not empty bookings}">
                        <c:forEach items="${bookings}" var="booking">
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
                                    <div class="nights-info">
                                        📆 ${booking.nights} nights at रु ${booking.price_per_night} per night
                                    </div>
                                    <div class="booking-info">
                                        <span>👥 Guests: ${booking.guest_count}</span>
                                        <span>💰 Total Paid: रु ${booking.total_price}</span>
                                    </div>
                                    <c:if test="${not empty booking.special_requests}">
                                        <div class="special-requests">
                                            📝 Special Request: ${booking.special_requests}
                                        </div>
                                    </c:if>
                                </div>
                                <div class="booking-actions">
                                    <c:if test="${booking.status == 'pending' or booking.status == 'confirmed'}">
                                        <form action="${pageContext.request.contextPath}/user/bookings" method="post" 
                                              onsubmit="return confirm('Are you sure you want to cancel this booking?');">
                                            <input type="hidden" name="action" value="cancel">
                                            <input type="hidden" name="bookingId" value="${booking.booking_id}">
                                            <button type="submit" class="cancel-btn">Cancel Booking</button>
                                        </form>
                                    </c:if>
                                    <c:if test="${booking.status == 'cancelled'}">
                                        <button class="cancel-btn" disabled style="background:#ccc;">Already Cancelled</button>
                                    </c:if>
                                    <c:if test="${booking.status == 'completed'}">
                                        <button class="cancel-btn" disabled style="background:#ccc;">Stay Completed</button>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <p>📭 No bookings found.</p>
                            <a href="${pageContext.request.contextPath}/user/rooms">Browse available rooms →</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
    </div>
</div>

<script>
    function toggleSidebar() {
        var sidebar = document.getElementById('sidebar');
        sidebar.classList.toggle('open');
    }
    
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