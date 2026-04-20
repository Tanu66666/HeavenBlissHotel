<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Rooms - Heaven Bliss Hotel</title>
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
            <h1>Manage Rooms</h1>
            <div class="admin-welcome">
                Welcome, <strong>${sessionScope.userName}</strong>
            </div>
        </div>
        
        <!-- Add Room Button -->
        <div class="action-bar">
            <a href="${pageContext.request.contextPath}/admin/rooms?action=add" class="btn-add">
                + Add New Room
            </a>
        </div>
        
        <!-- Rooms Table -->
        <div class="table-container">
            <div class="table-header">
                <h2>📋 All Rooms</h2>
            </div>
            
            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Room Number</th>
                        <th>Room Type</th>
                        <th>Price (NPR)</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty rooms}">
                            <c:forEach items="${rooms}" var="room">
                                <tr>
                                    <td>${room.room_id}</td>
                                    <td>${room.room_number}</td>
                                    <td>${room.room_type}</td>
                                    <td>रु ${room.price_per_night}</td>
                                    <td>${room.description}</td>
                                    <td>
                                        <span class="status ${room.status}">
                                            ${room.status}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="${pageContext.request.contextPath}/admin/rooms?action=edit&id=${room.room_id}" class="btn-edit">Edit</a>
                                            <a href="${pageContext.request.contextPath}/admin/rooms?action=delete&id=${room.room_id}" 
                                               class="btn-delete" 
                                               onclick="return confirm('Are you sure you want to delete this room?')">Delete</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="7" style="text-align: center;">No rooms found</td>
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