<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Rooms - Heaven Bliss Hotel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userdashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/browserooms.css">
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
            <a href="${pageContext.request.contextPath}/user/bookings" class="nav-link">
                My Bookings
            </a>
            <a href="${pageContext.request.contextPath}/user/profile" class="nav-link">
                My Profile
            </a>
            <a href="${pageContext.request.contextPath}/user/rooms" class="nav-link active">
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
                <h1>Browse Our Rooms</h1>
                <p>Find your perfect stay at Heaven Bliss Hotel</p>
            </div>
        </div>
        
        <!-- Search and Filter Section -->
        <div class="filter-section">
            <form action="${pageContext.request.contextPath}/user/rooms" method="get" class="filter-form">
                <div class="filter-row">
                    <div class="filter-group">
                        <label>Search</label>
                        <input type="text" name="search" placeholder="Room number, type..." value="${search}">
                    </div>
                    
                    <div class="filter-group">
                        <label>Room Type</label>
                        <select name="roomType">
                            <option value="all">All Types</option>
                            <c:forEach items="${roomTypes}" var="type">
                                <option value="${type}" ${selectedType == type ? 'selected' : ''}>${type}</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="filter-group">
                        <label>Min Price (NPR)</label>
                        <input type="number" name="minPrice" placeholder="Min" value="${selectedMinPrice}">
                    </div>
                    
                    <div class="filter-group">
                        <label>Max Price (NPR)</label>
                        <input type="number" name="maxPrice" placeholder="Max" value="${selectedMaxPrice}">
                    </div>
                    
                    <div class="filter-group filter-actions">
                        <label>&nbsp;</label>
                        <button type="submit" class="btn-filter">Search</button>
                        <a href="${pageContext.request.contextPath}/user/rooms" class="btn-reset">Reset</a>
                    </div>
                </div>
            </form>
        </div>
        
        <!-- Results Count -->
        <div class="results-count">
            Found <strong>${rooms.size()}</strong> rooms available
        </div>
        
        <!-- Rooms Grid -->
        <div class="rooms-container">
            <c:choose>
                <c:when test="${not empty rooms}">
                    <c:forEach items="${rooms}" var="room">
                        <div class="room-card">
                            <div class="room-image">
                                🛏️
                            </div>
                            <div class="room-details">
                                <div class="room-number">Room ${room.room_number}</div>
                                <h3 class="room-title">${room.room_type}</h3>
                                <p class="room-description">${room.description}</p>
                                <div class="room-price">
                                    रु ${room.price_per_night} <span>/ night</span>
                                </div>
                                <div class="room-actions">
                                    <a href="${pageContext.request.contextPath}/user/book?room_id=${room.room_id}" class="btn-book">
                                        Book Now →
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <p>🏨 No rooms available at the moment.</p>
                        <p>Please check back later or try different search criteria.</p>
                        <a href="${pageContext.request.contextPath}/user/rooms" class="btn-reset">Clear Filters</a>
                    </div>
                </c:otherwise>
            </c:choose>
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