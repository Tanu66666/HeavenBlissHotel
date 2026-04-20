<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Edit Room' : 'Add Room'} - Heaven Bliss Hotel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admindashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminrooms.css">
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
            <a href="${pageContext.request.contextPath}/admin/rooms" class="nav-link active">
                Rooms
            </a>
            <a href="${pageContext.request.contextPath}/admin/users" class="nav-link">
                Users
            </a>
            <a href="${pageContext.request.contextPath}/admin/bookings" class="nav-link">
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
            <h1>${isEdit ? 'Edit Room' : 'Add New Room'}</h1>
            <div class="admin-welcome">
                Welcome, <strong>${sessionScope.userName}</strong>
            </div>
        </div>
        
        <!-- Room Form -->
        <div class="form-container">
            <form action="${pageContext.request.contextPath}/admin/rooms" method="post" class="room-form">
                <input type="hidden" name="action" value="${isEdit ? 'update' : 'add'}">
                <c:if test="${isEdit}">
                    <input type="hidden" name="room_id" value="${room.room_id}">
                </c:if>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Room Number *</label>
                        <input type="text" name="room_number" value="${room.room_number}" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Room Type *</label>
                        <input type="text" name="room_type" value="${room.room_type}" required>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Price per Night (NPR) *</label>
                        <input type="number" name="price_per_night" value="${room.price_per_night}" step="0.01" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Status *</label>
                        <select name="status" required>
                            <option value="available" ${room.status == 'available' ? 'selected' : ''}>Available</option>
                            <option value="booked" ${room.status == 'booked' ? 'selected' : ''}>Booked</option>
                            <option value="maintenance" ${room.status == 'maintenance' ? 'selected' : ''}>Maintenance</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Description</label>
                    <textarea name="description" rows="4">${room.description}</textarea>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn-save">${isEdit ? 'Update Room' : 'Add Room'}</button>
                    <a href="${pageContext.request.contextPath}/admin/rooms" class="btn-cancel">Cancel</a>
                </div>
            </form>
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