<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Bookings - Heaven Bliss Hotel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admindashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminbookings.css">
</head>
<body>

<!-- Hamburger Menu Button -->
<button class="hamburger" onclick="toggleSidebar()">☰</button>

<div class="admin-container">
    
    <!-- Sidebar Navigation -->
    <div class="sidebar" id="sidebar">
        <div class="sidebar-brand">
            <h2>Heaven Bliss</h2>
            <p>Admin Panel</p>
        </div>
        
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">
                Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/admin/rooms" class="nav-link">
                Rooms
            </a>
            <a href="${pageContext.request.contextPath}/admin/users" class="nav-link">
                Users
            </a>
            <a href="${pageContext.request.contextPath}/admin/bookings" class="nav-link active">
                Bookings
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
        <div class="top-bar">
            <h1>Manage Bookings</h1>
            <div class="admin-welcome">
                Welcome, <strong>${sessionScope.userName}</strong>
            </div>
        </div>
        
        <!-- Statistics Cards -->
        <div class="stats-cards">
            <div class="stat-card">
                <div class="stat-info">
                    <h3>${totalBookings}</h3>
                    <p>Total Bookings</p>
                </div>
            </div>
            <div class="stat-card pending">
                <div class="stat-info">
                    <h3>${pendingCount}</h3>
                    <p>Pending</p>
                </div>
            </div>
            <div class="stat-card confirmed">
                <div class="stat-info">
                    <h3>${confirmedCount}</h3>
                    <p>Confirmed</p>
                </div>
            </div>
            <div class="stat-card completed">
                <div class="stat-info">
                    <h3>${completedCount}</h3>
                    <p>Completed</p>
                </div>
            </div>
            <div class="stat-card cancelled">
                <div class="stat-info">
                    <h3>${cancelledCount}</h3>
                    <p>Cancelled</p>
                </div>
            </div>
        </div>
        
        <!-- Filter Tabs -->
        <div class="filter-tabs">
            <a href="${pageContext.request.contextPath}/admin/bookings?filter=all" 
               class="filter-tab ${currentFilter == 'all' ? 'active' : ''}">All Bookings</a>
            <a href="${pageContext.request.contextPath}/admin/bookings?filter=pending" 
               class="filter-tab ${currentFilter == 'pending' ? 'active' : ''}">Pending</a>
            <a href="${pageContext.request.contextPath}/admin/bookings?filter=confirmed" 
               class="filter-tab ${currentFilter == 'confirmed' ? 'active' : ''}">Confirmed</a>
            <a href="${pageContext.request.contextPath}/admin/bookings?filter=completed" 
               class="filter-tab ${currentFilter == 'completed' ? 'active' : ''}">Completed</a>
            <a href="${pageContext.request.contextPath}/admin/bookings?filter=cancelled" 
               class="filter-tab ${currentFilter == 'cancelled' ? 'active' : ''}">Cancelled</a>
        </div>
        
        <!-- Bookings Table -->
        <div class="table-container">
            <div class="table-header">
                <h2>📋 All Bookings</h2>
            </div>
            
            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Guest</th>
                        <th>Room</th>
                        <th>Check In</th>
                        <th>Check Out</th>
                        <th>Nights</th>
                        <th>Total</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty bookings}">
                            <c:forEach items="${bookings}" var="booking">
                                <tr>
                                    <td>${booking.booking_id}</td>
                                    <td>
                                        <strong>${booking.full_name}</strong><br>
                                        <small>${booking.email}</small><br>
                                        <small>${booking.phone}</small>
                                    </td>
                                    <td>
                                        Room ${booking.room_number}<br>
                                        <small>${booking.room_type}</small><br>
                                        <small>रु ${booking.price_per_night}/night</small>
                                    </td>
                                    <td>${booking.check_in_date}</td>
                                    <td>${booking.check_out_date}</td>
                                    <td>${booking.nights}</td>
                                    <td>रु ${booking.total_price}</td>
                                    <td>
                                        <span class="status ${booking.status}">
                                            ${booking.status}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <form action="${pageContext.request.contextPath}/admin/bookings" method="post" style="display: inline;">
                                                <input type="hidden" name="action" value="updateStatus">
                                                <input type="hidden" name="bookingId" value="${booking.booking_id}">
                                                <select name="status" onchange="this.form.submit()" class="status-select">
                                                    <option value="pending" ${booking.status == 'pending' ? 'selected' : ''}>Pending</option>
                                                    <option value="confirmed" ${booking.status == 'confirmed' ? 'selected' : ''}>Confirmed</option>
                                                    <option value="completed" ${booking.status == 'completed' ? 'selected' : ''}>Completed</option>
                                                    <option value="cancelled" ${booking.status == 'cancelled' ? 'selected' : ''}>Cancelled</option>
                                                </select>
                                            </form>
                                            <a href="${pageContext.request.contextPath}/admin/bookings?action=delete&bookingId=${booking.booking_id}" 
                                               class="btn-delete" 
                                               onclick="return confirm('Are you sure you want to delete this booking?')">Delete</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="9" style="text-align: center;">No bookings found</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
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